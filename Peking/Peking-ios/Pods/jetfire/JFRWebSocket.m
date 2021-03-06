/////////////////////////////////////////////////////////////////////////////
//
//  JFRWebSocket.m
//
//  Created by Austin and Dalton Cherry on 5/13/14.
//  Copyright (c) 2014 Vluxe. All rights reserved.
//
/////////////////////////////////////////////////////////////////////////////

#import "JFRWebSocket.h"

//this get the correct bits out by masking the bytes of the buffer.
static const uint8_t JFRFinMask             = 0x80;
static const uint8_t JFROpCodeMask          = 0x0F;
static const uint8_t JFRRSVMask             = 0x70;
static const uint8_t JFRMaskMask            = 0x80;
static const uint8_t JFRPayloadLenMask      = 0x7F;
static const size_t  JFRMaxFrameSize        = 32;

//get the opCode from the packet
typedef NS_ENUM(NSUInteger, JFROpCode) {
    JFROpCodeContinueFrame = 0x0,
    JFROpCodeTextFrame = 0x1,
    JFROpCodeBinaryFrame = 0x2,
    //3-7 are reserved.
    JFROpCodeConnectionClose = 0x8,
    JFROpCodePing = 0x9,
    JFROpCodePong = 0xA,
    //B-F reserved.
};

typedef NS_ENUM(NSUInteger, JFRCloseCode) {
    JFRCloseCodeNormal                 = 1000,
    JFRCloseCodeGoingAway              = 1001,
    JFRCloseCodeProtocolError          = 1002,
    JFRCloseCodeProtocolUnhandledType  = 1003,
    // 1004 reserved.
    JFRCloseCodeNoStatusReceived       = 1005,
    //1006 reserved.
    JFRCloseCodeEncoding               = 1007,
    JFRCloseCodePolicyViolated         = 1008,
    JFRCloseCodeMessageTooBig          = 1009
};

//holds the responses in our read stack to properly process messages
@interface JFRResponse : NSObject

@property(nonatomic, assign)BOOL isFin;
@property(nonatomic, assign)JFROpCode code;
@property(nonatomic, assign)NSInteger bytesLeft;
@property(nonatomic, assign)NSInteger frameCount;
@property(nonatomic, strong)NSMutableData *buffer;

@end

@interface JFRWebSocket ()<NSStreamDelegate>

@property(nonatomic, strong)NSURL *url;
@property(nonatomic, strong)NSInputStream *inputStream;
@property(nonatomic, strong)NSOutputStream *outputStream;
@property(nonatomic, strong)NSOperationQueue *writeQueue;
@property(nonatomic, assign)BOOL isRunLoop;
@property(nonatomic, strong)NSMutableArray *readStack;
@property(nonatomic, strong)NSMutableArray *inputQueue;
@property(nonatomic, strong)NSData *fragBuffer;
@property(nonatomic, strong)NSMutableDictionary *headers;
@property(nonatomic, strong)NSArray *optProtocols;

@end

//Constant Header Values.
static const NSString *headerWSUpgradeName     = @"Upgrade";
static const NSString *headerWSUpgradeValue    = @"websocket";
static const NSString *headerWSHostName        = @"Host";
static const NSString *headerWSConnectionName  = @"Connection";
static const NSString *headerWSConnectionValue = @"Upgrade";
static const NSString *headerWSProtocolName    = @"Sec-WebSocket-Protocol";
static const NSString *headerWSVersionName     = @"Sec-Websocket-Version";
static const NSString *headerWSVersionValue    = @"13";
static const NSString *headerWSKeyName         = @"Sec-WebSocket-Key";
static const NSString *headerOriginName        = @"Origin";
static const NSString *headerWSAcceptName      = @"Sec-WebSocket-Accept";

//Class Constants
static char CRLFBytes[] = {'\r', '\n', '\r', '\n'};
static int BUFFER_MAX = 2048;

@implementation JFRWebSocket

/////////////////////////////////////////////////////////////////////////////
//Default initializer
- (instancetype)initWithURL:(NSURL *)url protocols:(NSArray*)protocols
{
    if(self = [super init]) {
        self.voipEnabled = NO;
        self.url = url;
        self.readStack = [NSMutableArray new];
        self.inputQueue = [NSMutableArray new];
        self.optProtocols = protocols;
    }
    
    return self;
}
/////////////////////////////////////////////////////////////////////////////
//Exposed method for connecting to URL provided in init method.
- (void)connect
{
    //everything is on a background thread.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self createHTTPRequest];
    });
}
/////////////////////////////////////////////////////////////////////////////
- (void)disconnect
{
    [self writeError:JFRCloseCodeNormal];
}
/////////////////////////////////////////////////////////////////////////////
-(void)writeString:(NSString*)string
{
    if(string) {
        [self dequeueWrite:[string dataUsingEncoding:NSUTF8StringEncoding]
                  withCode:JFROpCodeTextFrame];
    }
}
/////////////////////////////////////////////////////////////////////////////
-(void)writeData:(NSData*)data
{
    [self dequeueWrite:data withCode:JFROpCodeBinaryFrame];
}
/////////////////////////////////////////////////////////////////////////////
- (void)addHeader:(NSString*)value forKey:(NSString*)key
{
    if(!self.headers) {
        self.headers = [[NSMutableDictionary alloc] init];
    }
    [self.headers setObject:value forKey:key];
}
/////////////////////////////////////////////////////////////////////////////

#pragma mark - connect's internal supporting methods

/////////////////////////////////////////////////////////////////////////////
//Uses CoreFoundation to build a HTTP request to send over TCP stream.
- (void)createHTTPRequest
{
    CFURLRef url = CFURLCreateWithString(kCFAllocatorDefault, (CFStringRef)self.url.absoluteString, NULL);
    CFStringRef requestMethod = CFSTR("GET");
    CFHTTPMessageRef urlRequest = CFHTTPMessageCreateRequest(kCFAllocatorDefault,
                                                             requestMethod,
                                                             url,
                                                             kCFHTTPVersion1_1);
    CFRelease(url);
    
    NSNumber *port = _url.port;
    if (!port) {
        if([self.url.scheme isEqualToString:@"wss"] || [self.url.scheme isEqualToString:@"https"]){
            port = @(443);
        } else {
            port = @(80);
        }
    }
    NSString *protocols = @"";
    if(self.optProtocols) {
        protocols = [self.optProtocols componentsJoinedByString:@","];
    }
    CFHTTPMessageSetHeaderFieldValue(urlRequest,
                                     (__bridge CFStringRef)headerWSUpgradeName,
                                     (__bridge CFStringRef)headerWSUpgradeValue);
    CFHTTPMessageSetHeaderFieldValue(urlRequest,
                                     (__bridge CFStringRef)headerWSConnectionName,
                                     (__bridge CFStringRef)headerWSConnectionValue);
    CFHTTPMessageSetHeaderFieldValue(urlRequest,
                                     (__bridge CFStringRef)headerWSProtocolName,
                                     (__bridge CFStringRef)protocols);
    CFHTTPMessageSetHeaderFieldValue(urlRequest,
                                     (__bridge CFStringRef)headerWSVersionName,
                                     (__bridge CFStringRef)headerWSVersionValue);
    CFHTTPMessageSetHeaderFieldValue(urlRequest,
                                     (__bridge CFStringRef)headerWSKeyName,
                                     (__bridge CFStringRef)[self generateWebSocketKey]);
    CFHTTPMessageSetHeaderFieldValue(urlRequest,
                                     (__bridge CFStringRef)headerOriginName,
                                     (__bridge CFStringRef)self.url.absoluteString);
    CFHTTPMessageSetHeaderFieldValue(urlRequest,
                                     (__bridge CFStringRef)headerWSHostName,
                                     (__bridge CFStringRef)[NSString stringWithFormat:@"%@:%@",self.url.host,port]);
    
    for(NSString *key in self.headers) {
        CFHTTPMessageSetHeaderFieldValue(urlRequest,
                                         (__bridge CFStringRef)key,
                                         (__bridge CFStringRef)self.headers[key]);
    }
    
    NSData *serializedRequest = (__bridge_transfer NSData *)(CFHTTPMessageCopySerializedMessage(urlRequest));
    [self initStreamsWithData:serializedRequest port:port];
    CFRelease(urlRequest);
}
/////////////////////////////////////////////////////////////////////////////
//Random String of 16 lowercase chars, SHA1 and base64 encoded.
- (NSString *)generateWebSocketKey
{
    NSInteger seed = 16;
    NSMutableString *string = [NSMutableString stringWithCapacity:seed];
    for (int i = 0; i < seed; i++) {
        [string appendFormat:@"%C", (unichar)('a' + arc4random_uniform(25))];
    }
    return [[string dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
}
/////////////////////////////////////////////////////////////////////////////
//Sets up our reader/writer for the TCP stream.
- (void)initStreamsWithData:(NSData *)data port:(NSNumber*)port
{
    CFReadStreamRef readStream = NULL;
    CFWriteStreamRef writeStream = NULL;
    CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)self.url.host, [port intValue], &readStream, &writeStream);
    
    self.inputStream = (__bridge_transfer NSInputStream *)readStream;
    self.inputStream.delegate = self;
    self.outputStream = (__bridge_transfer NSOutputStream *)writeStream;
    self.outputStream.delegate = self;
    if([self.url.scheme isEqualToString:@"wss"] || [self.url.scheme isEqualToString:@"https"]) {
        [self.inputStream setProperty:NSStreamSocketSecurityLevelNegotiatedSSL forKey:NSStreamSocketSecurityLevelKey];
        [self.outputStream setProperty:NSStreamSocketSecurityLevelNegotiatedSSL forKey:NSStreamSocketSecurityLevelKey];
    }
    if(self.voipEnabled) {
        [self.inputStream setProperty:NSStreamNetworkServiceTypeVoIP forKey:NSStreamNetworkServiceType];
        [self.outputStream setProperty:NSStreamNetworkServiceTypeVoIP forKey:NSStreamNetworkServiceType];
    }
    [self.inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [self.outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [self.inputStream open];
    [self.outputStream open];
    [self.outputStream write:[data bytes] maxLength:[data length]];
    self.isRunLoop = YES;
    //正常链接直接走到这里，超时时不会到这里但是执行disconnect后会调用这里，加判断逻辑&& self.inputStream使cpu不在空转，原判断逻辑会造成cup占满
    while (self.isRunLoop && self.inputStream){
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}
/////////////////////////////////////////////////////////////////////////////

#pragma mark - NSStreamDelegate

/////////////////////////////////////////////////////////////////////////////
- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
{
    switch (eventCode) {
        case NSStreamEventNone:
            break;
        case NSStreamEventOpenCompleted:
            break;
        case NSStreamEventHasBytesAvailable:
        {
            if(aStream == self.inputStream)
                [self processInputStream];
            break;
        }
        case NSStreamEventHasSpaceAvailable:
        {
            break;
        }
        case NSStreamEventErrorOccurred:
        {
            [self disconnectStream:[aStream streamError]];
            break;
        }
        case NSStreamEventEndEncountered:
        {
            [self disconnectStream:nil];
            break;
        }
        default:
            break;
    }
}
/////////////////////////////////////////////////////////////////////////////
-(void)disconnectStream:(NSError*)error
{
    [self.writeQueue waitUntilAllOperationsAreFinished];
    [self.inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [self.outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [self.outputStream close];
    [self.inputStream close];
    self.outputStream = nil;
    self.inputStream = nil;
    self.isRunLoop = NO;
    _isConnected = NO;
    
    if([self.delegate respondsToSelector:@selector(websocketDidDisconnect:error:)]) {
        dispatch_async(dispatch_get_main_queue(),^{
            [self.delegate websocketDidDisconnect:self error:error];
        });
    }
}
/////////////////////////////////////////////////////////////////////////////

#pragma mark - Stream Processing Methods

/////////////////////////////////////////////////////////////////////////////
- (void)processInputStream
{
    @autoreleasepool {
        uint8_t buffer[BUFFER_MAX];
        NSInteger length = [self.inputStream read:buffer maxLength:BUFFER_MAX];
        if(length > 0) {
            if(!self.isConnected) {
                _isConnected = [self processHTTP:buffer length:length];
                if(!self.isConnected) {
                    if([self.delegate respondsToSelector:@selector(websocketDidDisconnect:error:)])
                        [self.delegate websocketDidDisconnect:self error:[self errorWithDetail:@"Invalid HTTP upgrade" code:1]];
                }
            } else {
                BOOL process = NO;
                if(self.inputQueue.count == 0) {
                    process = YES;
                }
                [self.inputQueue addObject:[NSData dataWithBytes:buffer length:length]];
                if(process) {
                    [self dequeueInput];
                }
            }
        }
    }
}
/////////////////////////////////////////////////////////////////////////////
-(void)dequeueInput
{
    if(self.inputQueue.count > 0) {
        NSData *data = [self.inputQueue objectAtIndex:0];
        NSData *work = data;
        if(self.fragBuffer) {
            NSMutableData *combine = [NSMutableData dataWithData:self.fragBuffer];
            [combine appendData:data];
            work = combine;
            self.fragBuffer = nil;
        }
        [self processRawMessage:(uint8_t*)work.bytes length:work.length];
        [self.inputQueue removeObject:data];
        [self dequeueInput];
    }
}
/////////////////////////////////////////////////////////////////////////////
//Finds the HTTP Packet in the TCP stream, by looking for the CRLF.
- (BOOL)processHTTP:(uint8_t*)buffer length:(NSInteger)bufferLen
{
    int k = 0;
    NSInteger totalSize = 0;
    for(int i = 0; i < bufferLen; i++) {
        if(buffer[i] == CRLFBytes[k]) {
            k++;
            if(k == 3) {
                totalSize = i + 1;
                break;
            }
        } else {
            k = 0;
        }
    }
    if(totalSize > 0) {
        
        if([self validateResponse:buffer length:totalSize])
        {
            if([self.delegate respondsToSelector:@selector(websocketDidConnect:)]) {
                dispatch_async(dispatch_get_main_queue(),^{
                    [self.delegate websocketDidConnect:self];
                });
            }
            totalSize += 1; //skip the last \n
            NSInteger  restSize = bufferLen-totalSize;
            if(restSize > 0) {
                [self processRawMessage:(buffer+totalSize) length:restSize];
            }
            return YES;
        }
    }
    return NO;
}
/////////////////////////////////////////////////////////////////////////////
//Validate the HTTP is a 101, as per the RFC spec.
- (BOOL)validateResponse:(uint8_t *)buffer length:(NSInteger)bufferLen
{
    CFHTTPMessageRef response = CFHTTPMessageCreateEmpty(kCFAllocatorDefault, NO);
    CFHTTPMessageAppendBytes(response, buffer, bufferLen);
    if(CFHTTPMessageGetResponseStatusCode(response) != 101) {
        CFRelease(response);
        return NO;
    }
    NSDictionary *headers = (__bridge_transfer NSDictionary *)(CFHTTPMessageCopyAllHeaderFields(response));
    NSString *acceptKey = headers[headerWSAcceptName];
    CFRelease(response);
    if(acceptKey.length > 0)
        return YES;
    return NO;
}
/////////////////////////////////////////////////////////////////////////////
-(void)writeError:(uint16_t)code
{
    uint16_t buffer[1];
    buffer[0] = CFSwapInt16BigToHost(code);
    [self dequeueWrite:[NSData dataWithBytes:buffer length:sizeof(uint16_t)] withCode:JFROpCodeConnectionClose];
}
/////////////////////////////////////////////////////////////////////////////
-(void)processRawMessage:(uint8_t*)buffer length:(NSInteger)bufferLen
{
    JFRResponse *response = [self.readStack lastObject];
    if(response && bufferLen < 2) {
        self.fragBuffer = [NSData dataWithBytes:buffer length:bufferLen];
        return;
    }
    if(response.bytesLeft > 0) {
        NSInteger len = response.bytesLeft;
        NSInteger extra =  bufferLen - response.bytesLeft;
        if(response.bytesLeft > bufferLen) {
            len = bufferLen;
            extra = 0;
        }
        response.bytesLeft -= len;
        [response.buffer appendData:[NSData dataWithBytes:buffer length:len]];
        [self processResponse:response];
        NSInteger offset = bufferLen - extra;
        if(extra > 0) {
            [self processExtra:(buffer+offset) length:extra];
        }
    } else {
        BOOL isFin = (JFRFinMask & buffer[0]);
        uint8_t receivedOpcode = (JFROpCodeMask & buffer[0]);
        BOOL isMasked = (JFRMaskMask & buffer[1]);
        uint8_t payloadLen = (JFRPayloadLenMask & buffer[1]);
        NSInteger offset = 2; //how many bytes do we need to skip for the header
        if((isMasked  || (JFRRSVMask & buffer[0])) && receivedOpcode != JFROpCodePong) {
            if([self.delegate respondsToSelector:@selector(websocketDidDisconnect:error:)])
                [self.delegate websocketDidDisconnect:self error:[self errorWithDetail:@"masked and rsv data is not currently supported" code:JFRCloseCodeProtocolError]];
            [self writeError:JFRCloseCodeProtocolError];
            return;
        }
        BOOL isControlFrame = (receivedOpcode == JFROpCodeConnectionClose || receivedOpcode == JFROpCodePing); //|| receivedOpcode == JFROpCodePong
        if(!isControlFrame && (receivedOpcode != JFROpCodeBinaryFrame && receivedOpcode != JFROpCodeContinueFrame && receivedOpcode != JFROpCodeTextFrame && receivedOpcode != JFROpCodePong)) {
            if([self.delegate respondsToSelector:@selector(websocketDidDisconnect:error:)])
                [self.delegate websocketDidDisconnect:self error:[self errorWithDetail:[NSString stringWithFormat:@"unknown opcode: 0x%x",receivedOpcode] code:JFRCloseCodeProtocolError]];
            [self writeError:JFRCloseCodeProtocolError];
            return;
        }
        if(isControlFrame && !isFin) {
            if([self.delegate respondsToSelector:@selector(websocketDidDisconnect:error:)])
                [self.delegate websocketDidDisconnect:self error:[self errorWithDetail:@"control frames can't be fragmented" code:JFRCloseCodeProtocolError]];
            [self writeError:JFRCloseCodeProtocolError];
            return;
        }
        if(receivedOpcode == JFROpCodeConnectionClose) {
            //the server disconnected us
            uint16_t code = JFRCloseCodeNormal;
            if(payloadLen == 1) {
                code = JFRCloseCodeProtocolError;
            }
            else if(payloadLen > 1) {
                code = CFSwapInt16BigToHost(*(uint16_t *)(buffer+offset) );
                if(code < 1000 || (code > 1003 && code < 1007) || (code > 1011 && code < 3000)) {
                    code = JFRCloseCodeProtocolError;
                }
                offset += 2;
            }
            NSInteger len = payloadLen-2;
            if(len > 0) {
                NSData *data = [NSData dataWithBytes:(buffer+offset) length:len];
                NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                if(!str) {
                    code = JFRCloseCodeProtocolError;
                }
            }
            [self writeError:code];
            return;
        }
        if(isControlFrame && payloadLen > 125) {
            [self writeError:JFRCloseCodeProtocolError];
            return;
        }
        NSInteger dataLength = payloadLen;
        if(payloadLen == 127) {
            dataLength = (NSInteger)CFSwapInt64BigToHost(*(uint64_t *)(buffer+offset));
            offset += sizeof(uint64_t);
        } else if(payloadLen == 126) {
            dataLength = CFSwapInt16BigToHost(*(uint16_t *)(buffer+offset) );
            offset += sizeof(uint16_t);
        }
        NSInteger len = dataLength;
        if(dataLength > bufferLen)
            len = bufferLen-offset;
        NSData *data = nil;
        if(len < 0) {
            len = 0;
            data = [NSData data];
        } else {
            data = [NSData dataWithBytes:(buffer+offset) length:len];
        }
        if(receivedOpcode == JFROpCodePong) {
            NSInteger step = (offset+len);
            NSInteger extra = bufferLen-step;
            if(extra > 0) {
                [self processRawMessage:(buffer+step) length:extra];
            }
            return;
        }
        JFRResponse *response = [self.readStack lastObject];
        if(isControlFrame) {
            response = nil; //don't append pings
        }
        if(!isFin && receivedOpcode == JFROpCodeContinueFrame && !response) {
            if([self.delegate respondsToSelector:@selector(websocketDidDisconnect:error:)])
                [self.delegate websocketDidDisconnect:self error:[self errorWithDetail:@"continue frame before a binary or text frame" code:JFRCloseCodeProtocolError]];
            [self writeError:JFRCloseCodeProtocolError];
            return;
        }
        BOOL isNew = NO;
        if(!response) {
            if(receivedOpcode == JFROpCodeContinueFrame) {
                if([self.delegate respondsToSelector:@selector(websocketDidDisconnect:error:)])
                    [self.delegate websocketDidDisconnect:self error:[self errorWithDetail:@"first frame can't be a continue frame" code:JFRCloseCodeProtocolError]];
                [self writeError:JFRCloseCodeProtocolError];
                return;
            }
            isNew = YES;
            response = [JFRResponse new];
            response.code = receivedOpcode;
            response.bytesLeft = dataLength;
            response.buffer = [NSMutableData dataWithData:data];
        } else {
            if(receivedOpcode == JFROpCodeContinueFrame) {
                response.bytesLeft = dataLength;
            } else {
                if([self.delegate respondsToSelector:@selector(websocketDidDisconnect:error:)])
                    [self.delegate websocketDidDisconnect:self error:[self errorWithDetail:@"second and beyond of fragment message must be a continue frame" code:JFRCloseCodeProtocolError]];
                [self writeError:JFRCloseCodeProtocolError];
                return;
            }
            [response.buffer appendData:data];
        }
        response.bytesLeft -= len;
        response.frameCount++;
        response.isFin = isFin;
        if(isNew) {
            [self.readStack addObject:response];
        }
        [self processResponse:response];
        
        NSInteger step = (offset+len);
        NSInteger extra = bufferLen-step;
        if(extra > 0) {
            [self processExtra:(buffer+step) length:extra];
        }
    }
    
}
/////////////////////////////////////////////////////////////////////////////
-(void)processExtra:(uint8_t*)buffer length:(NSInteger)bufferLen
{
    if(bufferLen < 2) {
        self.fragBuffer = [NSData dataWithBytes:buffer length:bufferLen];
    } else {
        [self processRawMessage:buffer length:bufferLen];
    }
}
/////////////////////////////////////////////////////////////////////////////
-(BOOL)processResponse:(JFRResponse*)response
{
    if(response.isFin && response.bytesLeft <= 0) {
        NSData *data = response.buffer;
        if(response.code == JFROpCodePing) {
            [self dequeueWrite:response.buffer withCode:JFROpCodePong];
        } else if(response.code == JFROpCodeTextFrame) {
            NSString *str = [[NSString alloc] initWithData:response.buffer encoding:NSUTF8StringEncoding];
            if(!str) {
                [self writeError:JFRCloseCodeEncoding];
                return NO;
            }
            if([self.delegate respondsToSelector:@selector(websocket:didReceiveMessage:)]) {
                dispatch_async(dispatch_get_main_queue(),^{
                    [self.delegate websocket:self didReceiveMessage:str];
                });
            }
        } else if([self.delegate respondsToSelector:@selector(websocket:didReceiveData:)]) {
            dispatch_async(dispatch_get_main_queue(),^{
                [self.delegate websocket:self didReceiveData:data];
            });
        }
        [self.readStack removeLastObject];
        return YES;
    }
    return NO;
}
/////////////////////////////////////////////////////////////////////////////
-(BOOL)processCloseCode:(uint16_t)code
{
    if(code > 0) {
        [self writeError:code];
        return YES;
    }
    return NO;
}
/////////////////////////////////////////////////////////////////////////////
-(void)dequeueWrite:(NSData*)data withCode:(JFROpCode)code
{
    if(!self.writeQueue) {
        self.writeQueue = [[NSOperationQueue alloc] init];
        self.writeQueue.maxConcurrentOperationCount = 1;
    }
    //we have a queue so we can be thread safe.
    [self.writeQueue addOperationWithBlock:^{
        //stream isn't ready, let's wait
        int tries = 0;
        while(!self.outputStream || !self.isConnected) {
            if(tries < 5) {
                sleep(1);
            } else {
                break;
            }
            tries++;
        }
        uint64_t offset = 2; //how many bytes do we need to skip for the header
        uint8_t *bytes = (uint8_t*)[data bytes];
        uint64_t dataLength = data.length;
        NSMutableData *frame = [[NSMutableData alloc] initWithLength:(NSInteger)(dataLength + JFRMaxFrameSize)];
        uint8_t *buffer = (uint8_t*)[frame mutableBytes];
        buffer[0] = JFRFinMask | code;
        if(dataLength < 126) {
            buffer[1] |= dataLength;
        } else if(dataLength <= UINT16_MAX) {
            buffer[1] |= 126;
            *((uint16_t *)(buffer + offset)) = CFSwapInt16BigToHost((uint16_t)dataLength);
            offset += sizeof(uint16_t);
        } else {
            buffer[1] |= 127;
            *((uint64_t *)(buffer + offset)) = CFSwapInt64BigToHost((uint64_t)dataLength);
            offset += sizeof(uint64_t);
        }
        BOOL isMask = YES;
        if(isMask) {
            buffer[1] |= JFRMaskMask;
            uint8_t *mask_key = (buffer + offset);
            SecRandomCopyBytes(kSecRandomDefault, sizeof(uint32_t), (uint8_t *)mask_key);
            offset += sizeof(uint32_t);
            
            for (size_t i = 0; i < dataLength; i++) {
                buffer[offset] = bytes[i] ^ mask_key[i % sizeof(uint32_t)];
                offset += 1;
            }
        } else {
            for(size_t i = 0; i < dataLength; i++) {
                buffer[offset] = bytes[i];
                offset += 1;
            }
        }
        uint64_t total = 0;
        while (true) {
            if(!self.outputStream) {
                break;
            }
            NSInteger len = [self.outputStream write:([frame bytes]+total) maxLength:(NSInteger)(offset-total)];
            if(len < 0) {
                if([self.delegate respondsToSelector:@selector(websocketDidWriteError:error:)])
                    [self.delegate websocketDidWriteError:self error:[self.outputStream streamError]];
                break;
            } else {
                total += len;
            }
            if(total >= offset) {
                break;
            }
        }
    }];
}
/////////////////////////////////////////////////////////////////////////////
-(NSError*)errorWithDetail:(NSString*)detail code:(NSInteger)code
{
    NSMutableDictionary* details = [NSMutableDictionary dictionary];
    [details setValue:detail forKey:NSLocalizedDescriptionKey];
    return [[NSError alloc] initWithDomain:@"JFRWebSocket" code:code userInfo:details];
}
/////////////////////////////////////////////////////////////////////////////
-(void)dealloc
{
    if(self.isConnected)
        [self disconnect];
}
/////////////////////////////////////////////////////////////////////////////
@end

/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
@implementation JFRResponse

@end
/////////////////////////////////////////////////////////////////////////////

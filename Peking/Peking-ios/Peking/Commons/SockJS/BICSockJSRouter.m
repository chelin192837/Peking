// *****
//  BICSockJSRouter.m
//  Biconome
//
//  Created by 车林 on 2019/9/19.
//  Copyright © 2019年 qsm. All rights reserved.
//
#import "BICSockJSRouter.h"
#import "WebsocketStompKit.h"
#import "BICMarketGetResponse.h"
#import "BICCoinAndUnitResponse.h"
#import "BICGetHistoryListResponse.h"
#import "BICKLineResponse.h"
#import "Y_KLineGroupModel.h"
#import "Y_KLineModel.h"
 
#import "Header.h"


//#define kBICBaseSockJSUrl @"ws://39.100.122.157/currency/app-websocket/"
//#define kBICCCTBaseSockJSUrl @"ws://39.100.122.157/cct/app-cct-websocket/"
 

//k线处理,行情,历史成交记录 涨跌幅，成交额
//#define kBICBaseSockJSUrl @"ws://192.168.1.141/currency/app-websocket/"
////盘口
//#define kBICCCTBaseSockJSUrl @"ws://192.168.1.141/cct/app-cct-websocket/"


static id share = nil;

@interface BICSockJSRouter ()<STOMPClientDelegate>

@property(nonatomic,strong)STOMPClient *buySellClient;
@property(nonatomic,strong)STOMPClient *otherClient;

@property(nonatomic,strong)STOMPSubscription *subKLine;
@property(nonatomic,strong)STOMPSubscription *subHistory;
@property(nonatomic,strong)STOMPSubscription *subBySell;
@property(nonatomic,strong)STOMPSubscription *subCurrentEntrust;
@property(nonatomic,strong)STOMPSubscription *subMarket;
@property(nonatomic,strong)STOMPSubscription *subTopicGainer;
@property(nonatomic,strong)STOMPSubscription *subTopicVolumeTop;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,assign)int reRonnectCount;
@end

@implementation BICSockJSRouter

+(instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[BICSockJSRouter alloc] init];
    });
    return share;
}


-(void)processHandle{
    self.buySellClient.connectionCompletionHandler = ^(STOMPFrame *connectedFrame, NSError *error) {
        if (error) {
            return;
        }
    };
    self.otherClient.connectionCompletionHandler = ^(STOMPFrame *connectedFrame, NSError *error) {
        if (error) {
            return;
        }
    };
    NSLog(@"修改connectionCompletionHandler完成");
}
//k线处理 入口
-(void)SockJSKLineStartSockJS_Type:(SockJS_Type)sockJsType
                      CurrencyPair:(NSString*)currencyPair
                           ForType:(NSString *)type
                   KLineArrayBlock:(KLineArrayBlock)kLineBlock
{

    self.type=type;
    WEAK_SELF
    self.kLineBlock = kLineBlock;
    //第一步创建队列
    dispatch_queue_t customQuue = dispatch_queue_create("com.manman.kLineBlockClient", DISPATCH_QUEUE_CONCURRENT);
    //第二步创建组
    dispatch_group_t customGroup = dispatch_group_create();
    //第三步添加任务
    dispatch_group_async(customGroup, customQuue, ^{
        [weakSelf createConnect:customGroup];
        [weakSelf createConnectBuySell:customGroup];
    });
    //第四步通知
    dispatch_group_notify(customGroup, dispatch_get_main_queue(), ^{
        [weakSelf SockOtherStartSockJS_Type:sockJsType CurrencyPair:currencyPair ForType:type KLineArrayBlock:kLineBlock ForParameter:nil];
        [weakSelf processHandle];
        NSLog(@"k线处理,监听注册任务完成");
    });
    
}



//行情,历史成交记录,盘口,涨跌幅，成交额  入口
-(void)SockJSGlobeStart
{
    WEAK_SELF
    //当前币对
    NSString *currencyPair= [NSString stringWithFormat:@"%@-%@",[BICDeviceManager GetPairCoinName],[BICDeviceManager GetPairUnitName]];
   //第一步创建队列
   dispatch_queue_t customQuue = dispatch_queue_create("com.manman.otherClient", DISPATCH_QUEUE_CONCURRENT);
   //第二步创建组
   dispatch_group_t customGroup = dispatch_group_create();
   //第三步添加任务
   dispatch_group_async(customGroup, customQuue, ^{
       [weakSelf createConnect:customGroup];
       [weakSelf createConnectBuySell:customGroup];
   });
   //第四步通知
   dispatch_group_notify(customGroup, dispatch_get_main_queue(), ^{
        [weakSelf SockJSStartSockJS_Type:SockJS_Type_BuySellClient CurrencyPair:currencyPair ForParameter:@""];
       if ([BICDeviceManager isLogin]) {
           [weakSelf SockJSStartSockJS_Type:SockJS_Type_CurrentEntrust CurrencyPair:currencyPair ForParameter:@""];
       }
       [weakSelf SockOtherStartSockJS_Type:SockJS_Type_KLine CurrencyPair:currencyPair ForType:self.type KLineArrayBlock:self.kLineBlock ForParameter:nil];
       [weakSelf SockJSStartSockJS_Type:SockJS_Type_Market CurrencyPair:currencyPair ForParameter:@""];
       [weakSelf SockJSStartSockJS_Type:SockJS_Type_History CurrencyPair:currencyPair ForParameter:@""];
       [weakSelf SockJSStartSockJS_Type:SockJS_Type_TopicVolumeTop CurrencyPair:currencyPair ForParameter:@""];
       [weakSelf SockJSStartSockJS_Type:SockJS_Type_TopicGainer CurrencyPair:currencyPair ForParameter:@""];
       [weakSelf processHandle];
       NSLog(@"行情,历史成交记录,盘口,涨跌幅，成交额，当前委托,监听注册任务完成");
   });
}
//当前委托  入口
-(void)SockJSCurrentEntrustStart
{
    WEAK_SELF
    //当前币对
    NSString *currencyPair= [NSString stringWithFormat:@"%@-%@",[BICDeviceManager GetPairCoinName],[BICDeviceManager GetPairUnitName]];
   //第一步创建队列
   dispatch_queue_t customQuue = dispatch_queue_create("com.manman.EntrustStart", DISPATCH_QUEUE_CONCURRENT);
   //第二步创建组
   dispatch_group_t customGroup = dispatch_group_create();
   //第三步添加任务
   dispatch_group_async(customGroup, customQuue, ^{
       [weakSelf createConnect:customGroup];
       [weakSelf createConnectBuySell:customGroup];
   });
   //第四步通知
   dispatch_group_notify(customGroup, dispatch_get_main_queue(), ^{
       if ([BICDeviceManager isLogin]) {
           [weakSelf SockJSStartSockJS_Type:SockJS_Type_CurrentEntrust CurrencyPair:currencyPair ForParameter:@""];
       }
       [weakSelf processHandle];
       NSLog(@"当前委托,监听注册任务完成");
   });
}

-(void)SockJSStartSockJS_Type:(SockJS_Type)sockJsType CurrencyPair:(NSString*)currencyPair ForParameter:(NSString *)parameter
{
    //行情,历史成交记录 涨跌幅，成交额
    if (sockJsType==SockJS_Type_Market || sockJsType == SockJS_Type_History || sockJsType == SockJS_Type_TopicVolumeTop || sockJsType == SockJS_Type_TopicGainer ) {
        [self SockOtherStartSockJS_Type:sockJsType CurrencyPair:currencyPair ForType:nil KLineArrayBlock:nil ForParameter:parameter];
    //盘口 当前委托
    }else if (sockJsType==SockJS_Type_BuySellClient || sockJsType==SockJS_Type_CurrentEntrust)
    {
        [self SockBuySellStartSockJS_Type:sockJsType CurrencyPair:currencyPair ForParameter:parameter];
    }
}

-(STOMPClient *)buySellClient{
    if(!_buySellClient){
        _buySellClient=[[STOMPClient alloc] initWithURL:[NSURL URLWithString:kBICCCTBaseSockJSUrl] webSocketHeaders:@{} useHeartbeat:YES];
    }
    return _buySellClient;
}

-(void)createConnectBuySell:(dispatch_group_t)group{
    
    if(![self.buySellClient connected]){
        
    self.buySellClient=[[STOMPClient alloc] initWithURL:[NSURL URLWithString:kBICCCTBaseSockJSUrl] webSocketHeaders:@{} useHeartbeat:YES];

        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        [self.buySellClient connectWithHeaders:@{} completionHandler:^(STOMPFrame *connectedFrame, NSError *error) {
            NSLog(@"self.buySellClient创建连接任务完成");
            //发送一个信号,让信号总量增加1
            dispatch_semaphore_signal(sema);
            if (error) {
                NSLog(@"%@",error);
                return;
            }
 
        }];
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
   
}


-(void)SockBuySellStartSockJS_Type:(SockJS_Type)sockJsType
                      CurrencyPair:(NSString*)currencyPair
                      ForParameter:(NSString *)parameter{
     self.buySellClient.delegate = self; //添加代理监听连接状态
    [self clientSubscribe:sockJsType CurrencyPair:currencyPair ForType:nil KLineArrayBlock:nil ForParameter:parameter];
}



-(STOMPClient *)otherClient{
    if(!_otherClient){
        _otherClient = [[STOMPClient alloc] initWithURL:[NSURL URLWithString:kBICBaseSockJSUrl] webSocketHeaders:@{} useHeartbeat:YES];
       
    }
    return _otherClient;
}
-(void)createConnect:(dispatch_group_t)group{
    
    if(![self.otherClient connected]){
        
    self.otherClient = [[STOMPClient alloc] initWithURL:[NSURL URLWithString:kBICBaseSockJSUrl] webSocketHeaders:@{} useHeartbeat:YES];

        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        [self.otherClient connectWithHeaders:@{} completionHandler:^(STOMPFrame *connectedFrame, NSError *error) {
            NSLog(@"self.otherClient创建连接任务完成");
            dispatch_semaphore_signal(sema);
            if (error) {
                NSLog(@"%@",error);
                return;
            }
        }];
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    
}


//k线处理,行情,历史成交记录 涨跌幅，成交额
-(void)SockOtherStartSockJS_Type:(SockJS_Type)sockJsType
                      CurrencyPair:(NSString*)currencyPair
                           ForType:(NSString *)type
                   KLineArrayBlock:(KLineArrayBlock)kLineBlock
                    ForParameter:(NSString *)parameter
{
    self.otherClient.delegate = self; //添加代理监听连接状态
    [self clientSubscribe:sockJsType CurrencyPair:currencyPair ForType:type KLineArrayBlock:kLineBlock ForParameter:parameter];
}

-(NSString*)getTimeType:(NSString*)type
{
    NSString* timeType = @"MINUTE";
    switch (type.intValue) {
         case 1:timeType = @"MINUTE";//@"1min";
             break;
         case 5:timeType = @"MINUTE";//@"30min";
             break;
         case 15:timeType = @"MINUTE";//@"15min";
             break;
         case 30:timeType = @"MINUTE";//@"1week";
             break;
         case 60:timeType = @"HOUR";//@"1hour";
             break;
         case 1440:timeType = @"DAY";//@"1day";
             break;
         case 10080:timeType = @"WEEK";//@"1min";
             break;

         default:
             break;
     }
    
    return timeType;
}
-(NSString*)getTimeNumber:(NSString*)type
{
    NSString* timeNumber = @"15";
    switch (type.intValue) {
         case 1:timeNumber = @"1";//@"1min";
             break;
         case 5:timeNumber = @"5";//@"30min";
             break;
         case 15:timeNumber = @"15";//@"15min";
             break;
         case 30:timeNumber = @"30";//@"1week";
             break;
         case 60:timeNumber = @"1";//@"1hour";
             break;
         case 1440:timeNumber = @"1";//@"1day";
             break;
         case 10080:timeNumber = @"1";//@"1min";
             break;

         default:
             break;
     }
    
    return timeNumber;
}
-(void)clientSubscribe:(SockJS_Type)sockJsType CurrencyPair:(NSString*)currencyPair ForType:(NSString *)type KLineArrayBlock:(KLineArrayBlock)kLineBlock ForParameter:(NSString *)parameter{
    WEAK_SELF
    if (sockJsType==SockJS_Type_KLine){
       //k线处理
        if(self.subKLine){
            [self.subKLine unsubscribe];
        }
       self.subKLine=[self.otherClient subscribeTo:[self getSockJSUrl:sockJsType CurrencyPair:currencyPair ForParameter:type]
                      headers:[NSDictionary dictionaryWithObjectsAndKeys:[self getSockJSUrl:sockJsType CurrencyPair:currencyPair ForParameter:type],kHeaderID, nil]
                      messageHandler:^(STOMPMessage *message) {
           [weakSelf sendMessageSockJSType:sockJsType STOMPMessage:message CurrencyPair:currencyPair Type:type];
       }];
    }else if(sockJsType==SockJS_Type_History){
        if(self.subHistory){
            [self.subHistory unsubscribe];
        }
        self.subHistory=[self.otherClient subscribeTo:[self getSockJSUrl:sockJsType CurrencyPair:currencyPair ForParameter:parameter]
                             headers:[NSDictionary dictionaryWithObjectsAndKeys:[self getSockJSUrl:sockJsType CurrencyPair:currencyPair ForParameter:type],kHeaderID, nil]
                             messageHandler:^(STOMPMessage *message) {
                  [weakSelf sendMessageSockJSType:sockJsType STOMPMessage:message CurrencyPair:currencyPair Type:parameter];
              }];
    }else if(sockJsType==SockJS_Type_BuySellClient){
        if(self.subBySell){
            [self.subBySell unsubscribe];
        }
        self.subBySell=[self.buySellClient subscribeTo:[self getSockJSUrl:sockJsType CurrencyPair:currencyPair ForParameter:parameter]
                         headers:[NSDictionary dictionaryWithObjectsAndKeys:[self getSockJSUrl:sockJsType CurrencyPair:currencyPair ForParameter:type],kHeaderID, nil]
                         messageHandler:^(STOMPMessage *message) {
            [weakSelf sendMessageSockJSType:sockJsType STOMPMessage:message CurrencyPair:currencyPair Type:parameter];
        }];
    }else if(sockJsType==SockJS_Type_CurrentEntrust){
        if(self.subCurrentEntrust){
            [self.subCurrentEntrust unsubscribe];
        }
        self.subCurrentEntrust=[self.buySellClient subscribeTo:[self getSockJSUrl:sockJsType CurrencyPair:currencyPair ForParameter:parameter]
                         headers:[NSDictionary dictionaryWithObjectsAndKeys:[self getSockJSUrl:sockJsType CurrencyPair:currencyPair ForParameter:type],kHeaderID, nil]
                         messageHandler:^(STOMPMessage *message) {
            [weakSelf sendMessageSockJSType:sockJsType STOMPMessage:message CurrencyPair:currencyPair Type:parameter];
        }];
    }else if(sockJsType==SockJS_Type_Market){
        if(self.subMarket){
            [self.subMarket unsubscribe];
        }
       self.subMarket=[self.otherClient subscribeTo:[self getSockJSUrl:sockJsType CurrencyPair:currencyPair ForParameter:parameter]
                       headers:[NSDictionary dictionaryWithObjectsAndKeys:[self getSockJSUrl:sockJsType CurrencyPair:currencyPair ForParameter:type],kHeaderID, nil]
                       messageHandler:^(STOMPMessage *message) {
            [weakSelf sendMessageSockJSType:sockJsType STOMPMessage:message CurrencyPair:currencyPair Type:parameter];
        }];
    }else if(sockJsType == SockJS_Type_TopicVolumeTop){
        if(self.subTopicVolumeTop){
                [self.subTopicVolumeTop unsubscribe];
        }
        self.subTopicVolumeTop=[self.otherClient subscribeTo:[self getSockJSUrl:sockJsType CurrencyPair:currencyPair ForParameter:parameter]
                       headers:[NSDictionary dictionaryWithObjectsAndKeys:[self getSockJSUrl:sockJsType CurrencyPair:currencyPair ForParameter:type],kHeaderID, nil]
                       messageHandler:^(STOMPMessage *message) {
            [weakSelf sendMessageSockJSType:sockJsType STOMPMessage:message CurrencyPair:currencyPair Type:parameter];
        }];
    }else if(sockJsType == SockJS_Type_TopicGainer){
        if(self.subTopicGainer){
                [self.subTopicGainer unsubscribe];
        }
       self.subTopicGainer=[self.otherClient subscribeTo:[self getSockJSUrl:sockJsType CurrencyPair:currencyPair ForParameter:parameter]
                      headers:[NSDictionary dictionaryWithObjectsAndKeys:[self getSockJSUrl:sockJsType CurrencyPair:currencyPair ForParameter:type],kHeaderID, nil]
                      messageHandler:^(STOMPMessage *message) {
           [weakSelf sendMessageSockJSType:sockJsType STOMPMessage:message CurrencyPair:currencyPair Type:parameter];
       }];
    }
}



-(void)SockJSKLineStop
{
//    [self.kLineClient disconnect];
//    self.kLineClient = nil;
}



-(void)SockJSGlobeReStart
{
    [self SockJSGlobeStop];
    [self SockJSGlobeStart];
}

-(void)SockJSGlobeStop
{
//    [self SockJSStopSockJS_Type:SockJS_Type_Market];
//    [self SockJSStopSockJS_Type:SockJS_Type_BuySellClient];
//    [self SockJSStopSockJS_Type:SockJS_Type_History];

}

-(void)SockJSStopSockJS_Type:(SockJS_Type)sockJsType
{
//    [self didNotConnetedSockJS_Type:sockJsType];
}

//socket消息通知方法
-(void)sendMessageSockJSType:(SockJS_Type)sockJsType
                STOMPMessage:(STOMPMessage *)message
                CurrencyPair:(NSString*)currencyPair
                        Type:(NSString*)type
{
    if (sockJsType==SockJS_Type_Market) {
        marketGetResponse  * response = [marketGetResponse yy_modelWithJSON:message.body];
        BICMarketGetResponse * responseM = [[BICMarketGetResponse alloc] init];
        responseM.data = response;
        kPOSTNSNotificationCenter(NSNotificationCenteSockJSTopicMarket, response);
//        RSDLog(@"MarketJs_source--%@",response.amount);
        SDUserDefaultsSET(@(responseM.data.cnyAmount.doubleValue), BICUSDTYANG);
        
    } else if (sockJsType==SockJS_Type_BuySellClient)
    {
        BICCoinAndUnitResponse * response = [[BICCoinAndUnitResponse alloc] init];
        
        CoinAndUnitResponse *responseM = [CoinAndUnitResponse yy_modelWithJSON:message.body];
       
        response.data = responseM;
        
        kPOSTNSNotificationCenter(NSNotificationCenteSockJSTopicSubscription, response);
        
    }else if (sockJsType==SockJS_Type_History)
    {
        BICGetHistoryListResponse * response = [[BICGetHistoryListResponse alloc] init];
        
        NSArray <GetHistoryListResponse>*arr= [GetHistoryListResponse mj_objectArrayWithKeyValuesArray:message.body].copy;
        
        response.data = arr;
        
        kPOSTNSNotificationCenter(NSNotificationCenteSockJSTopicHistory, response);

    }else if (sockJsType==SockJS_Type_KLine)
    {

        kLineResponse *model = [kLineResponse yy_modelWithJSON:message.body];

        NSMutableArray * mulArr = [NSMutableArray array];
        [mulArr addObject:model.timestamp?:@"0"];
        [mulArr addObject:model.open?:@"0"];
        [mulArr addObject:model.highest?:@"0"];
        [mulArr addObject:model.lowest?:@"0"];
        [mulArr addObject:model.close?:@"0"];
        [mulArr addObject:model.total?:@"0"];
        
        Y_KLineModel *lineModel = [[Y_KLineModel alloc] init];
       
        [lineModel initWithArray:mulArr];
        
        
        if (self.kLineBlock) {
            self.kLineBlock(lineModel,type);
        }
    //成交额
    }else if(sockJsType == SockJS_Type_TopicVolumeTop){
        NSArray* arr= [getTopListResponse mj_objectArrayWithKeyValuesArray:message.body];
        kPOSTNSNotificationCenter(NSNotificationCenterVOLUMETOP, arr);
    //涨跌幅
    }else if(sockJsType == SockJS_Type_TopicGainer){
        NSArray* arr= [getTopListResponse mj_objectArrayWithKeyValuesArray:message.body];
        kPOSTNSNotificationCenter(NSNotificationCenterGAINER, arr);
    //当前委托
    }else if(sockJsType == SockJS_Type_CurrentEntrust){
        ListUserRowsResponse* res= [ListUserRowsResponse mj_objectWithKeyValues:message.body];
        RSDLog(@"ListUserRowsResponse--%@",res);
        kPOSTNSNotificationCenter(NSNotificationCenterCurrentEntrust,res);
    }
}

//断开连接 启动后保持长连接，不做断开2个socketClient连接
-(void)didNotConnetedSockJS_Type:(SockJS_Type)sockJsType
{
    
//    if (sockJsType==SockJS_Type_Market) {
//        [self.marketClient disconnect];
//    } else if (sockJsType==SockJS_Type_BuySellClient)
//    {
//        [self.buySellClient disconnect];
//    }else if (sockJsType==SockJS_Type_History)
//    {
//        [self.historyClient disconnect];
//    }
}

//与后台断开连接的回调方法 STOMPClientDelegate
- (void)websocketDidDisconnect:(NSError *)error {
    
    NSLog(@"%@",error);
    self.reRonnectCount++;
    //当前委托+盘口
    if(!self.buySellClient.connected){
        NSLog(@"当前委托+盘口buySellClient断开连接....");
        NSLog(@"当前委托+盘口buySellClient 5秒后重新连接....第%d次重连",self.reRonnectCount);
    }
    
    if(!self.otherClient.connected){
        NSLog(@"k线，行情,历史成交记录otherClient断开连接....");
        NSLog(@"k线，行情,历史成交记录buySellClient 5秒后重新连接....第%d次重连",self.reRonnectCount);
    }
    
    if(self.reRonnectCount<=10){
        //注：此方法是一种非阻塞的执行方式
        [self performSelector:@selector(reConnectByMySelf) withObject:nil/*可传任意类型参数*/ afterDelay:5.0];
    }else{
        NSLog(@"完成重连任务 任务结束");
    }
}

-(void)reConnectByMySelf{
    //当前币对
    NSString *currencyPair= [NSString stringWithFormat:@"%@-%@",[BICDeviceManager GetPairCoinName],[BICDeviceManager GetPairUnitName]];
    WEAK_SELF
   //第一步创建队列
   dispatch_queue_t customQuue = dispatch_queue_create("com.manman.ClientReConnect", DISPATCH_QUEUE_CONCURRENT);
   //第二步创建组
   dispatch_group_t customGroup = dispatch_group_create();
   //第三步添加任务
   dispatch_group_async(customGroup, customQuue, ^{
       [weakSelf createConnectBuySell:customGroup];
       [weakSelf createConnect:customGroup];
   });

   //第四步通知
   dispatch_group_notify(customGroup, dispatch_get_main_queue(), ^{
       [weakSelf SockJSStartSockJS_Type:SockJS_Type_BuySellClient CurrencyPair:currencyPair ForParameter:@""];
       if ([BICDeviceManager isLogin]) {
           [weakSelf SockJSStartSockJS_Type:SockJS_Type_CurrentEntrust CurrencyPair:currencyPair ForParameter:@""];
       }
       [weakSelf SockOtherStartSockJS_Type:SockJS_Type_KLine CurrencyPair:currencyPair ForType:self.type KLineArrayBlock:self.kLineBlock ForParameter:nil];
       [weakSelf SockJSStartSockJS_Type:SockJS_Type_Market CurrencyPair:currencyPair ForParameter:@""];
       [weakSelf SockJSStartSockJS_Type:SockJS_Type_History CurrencyPair:currencyPair ForParameter:@""];
       [weakSelf SockJSStartSockJS_Type:SockJS_Type_TopicVolumeTop CurrencyPair:currencyPair ForParameter:@""];
       [weakSelf SockJSStartSockJS_Type:SockJS_Type_TopicGainer CurrencyPair:currencyPair ForParameter:@""];
       [weakSelf processHandle];
       NSLog(@"当前委托+盘口监听【重新】注册任务完成");
       NSLog(@"k线，行情,历史成交记录监听【重新】注册任务完成");
   });
}


-(NSString*)getSockJSUrl:(SockJS_Type)sockJS_Type CurrencyPair:(NSString*)currencyPair ForParameter:(NSString *)parameter
{
    if (sockJS_Type==SockJS_Type_Market) {
        return @"/topic/market";
    }else if (sockJS_Type ==SockJS_Type_BuySellClient)
    {
        NSString *currencyP= [NSString stringWithFormat:@"%@-%@",[BICDeviceManager GetPairCoinName],[BICDeviceManager GetPairUnitName]];
//        NSLog(@"盘口订阅地址:%@",[NSString stringWithFormat:@"/topic/subscription/%@",currencyP]);
        return [NSString stringWithFormat:@"/topic/subscription/%@",currencyP];
    }else if (sockJS_Type ==SockJS_Type_History)
    {
        NSString *currencyP= [NSString stringWithFormat:@"%@-%@",[BICDeviceManager GetPairCoinName],[BICDeviceManager GetPairUnitName]];
        return [NSString stringWithFormat:@"/topic/history/%@",currencyP];
    }else if (sockJS_Type ==SockJS_Type_KLine)
    {
        NSString * timeType = [self getTimeType:parameter];
        NSString* timeNumber = [self getTimeNumber:parameter];
        return [NSString stringWithFormat:@"/topic/marketk/%@/%@%@",currencyPair,timeNumber,timeType];
    }else if(sockJS_Type == SockJS_Type_TopicGainer){
        return @"/topic/gainer";
    }else if(sockJS_Type == SockJS_Type_TopicVolumeTop){
        return @"/topic/volumeTop";
    //当前委托
    }else if(sockJS_Type == SockJS_Type_CurrentEntrust){
        NSString *currencyP= [NSString stringWithFormat:@"%@/%@-%@",SDUserDefaultsGET(USERID),[BICDeviceManager GetPairCoinName],[BICDeviceManager GetPairUnitName]];
        return [NSString stringWithFormat:@"/topic/currentOrder/%@",currencyP];
    }
    
    return @"";
}



@end

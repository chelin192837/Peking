//
//  BICpcGetTransferInOutResponse.m
//  Biconome
//
//  Created by 车林 on 2019/8/31.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICpcGetTransferInOutResponse.h"

@implementation BICpcGetTransferInOutResponse

@end

@implementation pcGetTransferInOutResponse

@end

@implementation GetTransferInOutResponse
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    if ([key isEqualToString:@"hash"]) {
        self.khash =value;
    }
}
@end

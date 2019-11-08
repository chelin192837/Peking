//
//  BICMarketGetResponse.h
//  Biconome
//
//  Created by 车林 on 2019/8/28.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class GetCoinPairConfigResponse,BICGetCoinPairConfigResponse;

@protocol BICGetCoinPairConfigResponse <NSObject>

@end

@protocol GetCoinPairConfigResponse <NSObject>

@end

@interface BICGetCoinPairConfigResponse : BICBaseResponse

@property(nonatomic,strong)GetCoinPairConfigResponse*data;

@end

@interface GetCoinPairConfigResponse : BaseModel

@property(nonatomic,strong)NSString * coinName;
@property(nonatomic,strong)NSString * unitName;

@property(nonatomic,strong)NSString * coinDecimals; //btc/used coinDecimal-->btc
@property(nonatomic,strong)NSString * unitDecimals;  // usdt

@property(nonatomic,strong)NSString * newestPrice;
@property(nonatomic,strong)NSString * amount;
@property(nonatomic,strong)NSString * upDown;
@property(nonatomic,strong)NSString * openMode;
@property(nonatomic,strong)NSString * openTime;
@property(nonatomic,strong)NSString * postOnlyTime;
@property(nonatomic,strong)NSString * minNum;

@property(nonatomic,strong)NSString * numDecimals;
@property(nonatomic,strong)NSString * firstUser;
@property(nonatomic,strong)NSString * lowest;
@property(nonatomic,strong)NSString * highest;


@end

NS_ASSUME_NONNULL_END


//
//  BICMarketGetResponse.h
//  Biconome
//
//  Created by 车林 on 2019/8/28.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class GetOutQuotaResponse,BICGetOutQuotaResponse;

@protocol BICGetOutQuotaResponse <NSObject>

@end

@protocol GetOutQuotaResponse <NSObject>

@end

@interface BICGetOutQuotaResponse : BICBaseResponse

@property(nonatomic,strong)GetOutQuotaResponse *data;

@end

@interface GetOutQuotaResponse : BaseModel

@property(nonatomic,strong)NSString * BTC;
@property(nonatomic,strong)NSString * IOTE;
@property(nonatomic,strong)NSString * ETH;
@property(nonatomic,strong)NSString * EOS;
@property(nonatomic,strong)NSString * USDT;
@property(nonatomic,strong)NSString * MEE;


@end

NS_ASSUME_NONNULL_END


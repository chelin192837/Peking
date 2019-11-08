//
//  BICMarketGetResponse.h
//  Biconome
//
//  Created by 车林 on 2019/8/28.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class GetCurrencyConfigResponse,BICGetCurrencyConfigResponse;

@protocol BICGetCurrencyConfigResponse <NSObject>

@end

@protocol GetCurrencyConfigResponse <NSObject>

@end

@interface BICGetCurrencyConfigResponse : BICBaseResponse

@property(nonatomic,strong)GetCurrencyConfigResponse *data;

@end

@interface GetCurrencyConfigResponse : BaseModel

@property(nonatomic,strong)NSString * currencyName;

@property(nonatomic,assign)BOOL isRecharge;
@property(nonatomic,assign)BOOL isWithdrawal;
@property(nonatomic,assign)BOOL isRemark;
@property(nonatomic,assign)BOOL isBlackWithdrawal;



@end

NS_ASSUME_NONNULL_END

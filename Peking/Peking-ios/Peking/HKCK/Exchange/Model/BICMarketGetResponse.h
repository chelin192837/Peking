//
//  BICMarketGetResponse.h
//  Biconome
//
//  Created by 车林 on 2019/8/28.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class marketGetResponse,BICMarketGetResponse;

@protocol BICMarketGetResponse <NSObject>

@end

@protocol marketGetResponse <NSObject>

@end

@interface BICMarketGetResponse : BICBaseResponse

@property(nonatomic,strong)marketGetResponse * data;

@end

@interface marketGetResponse : BaseModel

@property(nonatomic,strong)NSString * currencyPair;
@property(nonatomic,strong)NSString * amount;
@property(nonatomic,strong)NSString * timestamp;
@property(nonatomic,strong)NSString * percent;
@property(nonatomic,strong)NSString * usdAmount;
@property(nonatomic,strong)NSString * cnyAmount;
@property(nonatomic,strong)NSString * hkdAmount;
@property(nonatomic,strong)NSString * eurAmount;
@property(nonatomic,strong)NSString * lowest;
@property(nonatomic,strong)NSString * highest;
@property(nonatomic,strong)NSString * open;
@property(nonatomic,strong)NSString * total;
@property(nonatomic,assign)BOOL isCollection;


@end

NS_ASSUME_NONNULL_END

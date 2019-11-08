//
//  BICLimitMarketRequest.h
//  Biconome
//
//  Created by 车林 on 2019/8/27.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICLimitMarketRequest : BICBaseRequest
//单位
@property(nonatomic,copy)NSString * unitName;
//币种
@property(nonatomic,copy)NSString * coinName;
//数量（市价卖）
@property(nonatomic,copy)NSString * totalNum;
//单价
@property(nonatomic,copy)NSString * unitPrice;
//触发价格
@property(nonatomic,copy)NSString * triggerPrice;

@property(nonatomic,copy)NSString * turnover;
//总交易额（市价买）
@property(nonatomic,copy)NSString * totalTurnover;
//订单类型BUY/SELL
@property(nonatomic,copy)NSString * orderType;
//发布类型LIMIT/MARKET
@property(nonatomic,copy)NSString * publishType;

@end

NS_ASSUME_NONNULL_END

//
//  BICListUserResponse.h
//  Biconome
//
//  Created by 车林 on 2019/8/24.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BICBaseResponse.h"
#import "BaseModel.h"
NS_ASSUME_NONNULL_BEGIN

@class ListByUserResponse,DealListByUserResponse,BICDealListByUserResponse;

@protocol BICDealListByUserResponse <NSObject>

@end

@protocol DealListByUserResponse <NSObject>


@end

@protocol ListByUserResponse <NSObject>

@end

@interface BICDealListByUserResponse : BICBaseResponse

@property(nonatomic,strong)DealListByUserResponse * data;

@end

@interface DealListByUserResponse : BaseModel

@property(nonatomic,strong) NSArray <ListByUserResponse>* rows;

@end

@interface ListByUserResponse : BaseModel

@property(nonatomic,strong)NSString * totalAmount;
@property(nonatomic,strong)NSString * realAmount;
@property(nonatomic,strong)NSString * unitPrice;
@property(nonatomic,strong)NSString * tradingNum;
@property(nonatomic,strong)NSString * chargeRatio;
@property(nonatomic,strong)NSString * serviceCharge;
@property(nonatomic,strong)NSString * tradingType;
@property(nonatomic,strong)NSString * coinName;
@property(nonatomic,strong)NSString * unitName;
@property(nonatomic,strong)NSString * createTime;
@property(nonatomic,strong)NSString * publishType;
@property(nonatomic,strong)NSString * orderType;
@property(nonatomic,strong)NSString * orderStatus;


@end



NS_ASSUME_NONNULL_END

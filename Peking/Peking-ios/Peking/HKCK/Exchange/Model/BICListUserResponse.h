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

@class ListUserRowsResponse,ListUserDataResponse,BICListUserResponse;

@protocol BICListUserResponse <NSObject>

@end

@protocol ListUserDataResponse <NSObject>


@end

@protocol ListUserRowsResponse <NSObject>

@end

@interface BICListUserResponse : BICBaseResponse

@property(nonatomic,strong)ListUserDataResponse * data;

@end

@interface ListUserDataResponse : BaseModel

@property(nonatomic,strong) NSArray <ListUserRowsResponse>* rows;

@end

@interface ListUserRowsResponse : BaseModel

@property(nonatomic,strong)NSString * id;

@property(nonatomic,strong)NSString * userId;

@property(nonatomic,strong)NSString * unitPrice;

@property(nonatomic,strong)NSString * totalNum;
@property(nonatomic,strong)NSString * lastNum;
@property(nonatomic,strong)NSString * totalTurnover;
@property(nonatomic,strong)NSString * lastTurnover;


@property(nonatomic,strong)NSString * coinName;
@property(nonatomic,strong)NSString * unitName;
@property(nonatomic,strong)NSString * orderStatus;
@property(nonatomic,strong)NSString * orderType;
@property(nonatomic,strong)NSString * publishType;
@property(nonatomic,strong)NSString * version;
@property(nonatomic,strong)NSString * createTime;
@property(nonatomic,strong)NSString * modifyTime;

@property(nonatomic,strong)NSString * entrustTurnover;
@property(nonatomic,strong)NSString * dealTurnover;

@property(nonatomic,strong)NSString * dealPrice;
@property(nonatomic,strong)NSString * entrustPrice;

@property(nonatomic,strong)NSString * dealNum;
@property(nonatomic,strong)NSString * entrustNum;

@property(nonatomic,strong)NSString * dealCharge;

@property(nonatomic,strong)NSString * orderId;

@property(nonatomic,strong)NSString * triggerPrice;

@property(nonatomic,strong)NSString * triggerCondition;





@end



NS_ASSUME_NONNULL_END

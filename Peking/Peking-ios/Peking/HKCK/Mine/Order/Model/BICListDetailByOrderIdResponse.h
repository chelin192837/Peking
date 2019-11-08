//
//  BICListUserResponse.h
//  Biconome
// BICListDetailByOrderIdResponse
//  Created by 车林 on 2019/8/24.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BICBaseResponse.h"
#import "BaseModel.h"
NS_ASSUME_NONNULL_BEGIN

@class ListDetailByOrderId,ListDetailByOrderIdResponse,BICListDetailByOrderIdResponse;

@protocol BICListDetailByOrderIdResponse <NSObject>

@end

@protocol ListDetailByOrderIdResponse <NSObject>


@end

@protocol ListDetailByOrderId <NSObject>

@end

@interface BICListDetailByOrderIdResponse : BICBaseResponse

@property(nonatomic,strong)NSArray <ListDetailByOrderId>*  data;

@end

@interface ListDetailByOrderIdResponse : BaseModel

@property(nonatomic,strong) NSArray <ListDetailByOrderId>* rows;

@end

@interface ListDetailByOrderId : BaseModel

@property(nonatomic,strong)NSString * id;
@property(nonatomic,strong)NSString * recordId;
@property(nonatomic,strong)NSString * unitPrice;
@property(nonatomic,strong)NSString * tradingNum;
@property(nonatomic,strong)NSString * serviceCharge;
@property(nonatomic,strong)NSString * tradingType;
@property(nonatomic,strong)NSString * createTime;


@end



NS_ASSUME_NONNULL_END

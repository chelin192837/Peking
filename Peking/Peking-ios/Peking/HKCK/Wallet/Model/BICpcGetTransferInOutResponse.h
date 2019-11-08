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

@class GetTransferInOutResponse,pcGetTransferInOutResponse,BICpcGetTransferInOutResponse;

@protocol BICpcGetTransferInOutResponse <NSObject>

@end

@protocol pcGetTransferInOutResponse <NSObject>


@end

@protocol GetTransferInOutResponse <NSObject>

@end

@interface BICpcGetTransferInOutResponse : BICBaseResponse

@property(nonatomic,strong)pcGetTransferInOutResponse * data;

@end

@interface pcGetTransferInOutResponse : BaseModel

@property(nonatomic,strong) NSArray <GetTransferInOutResponse>* rows;

@end

@interface GetTransferInOutResponse : BaseModel

@property(nonatomic,copy)NSString * id;
@property(nonatomic,copy)NSString * khash;
@property(nonatomic,copy)NSString * hash;
@property(nonatomic,copy)NSString * fromAddr;
@property(nonatomic,copy)NSString * toAddr;
@property(nonatomic,copy)NSString * amount;
@property(nonatomic,copy)NSString * tokenAddr;
@property(nonatomic,copy)NSString * tokenSymbol;
@property(nonatomic,copy)NSString * gasPrice;
@property(nonatomic,copy)NSString * gasTokenType;
@property(nonatomic,copy)NSString * gasTokenName;
@property(nonatomic,copy)NSString * gasTokenSymbol;
@property(nonatomic,copy)NSString * transferType;
@property(nonatomic,copy)NSString * status;
@property(nonatomic,copy)NSString * remark;
@property(nonatomic,copy)NSString * createTime;
@property(nonatomic,copy)NSString * updateTime;
@property(nonatomic,copy)NSString * chainType;
@property(nonatomic,copy)NSString * logoAddr;

@end



NS_ASSUME_NONNULL_END

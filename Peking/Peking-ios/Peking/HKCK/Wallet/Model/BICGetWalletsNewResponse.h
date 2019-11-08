//
//  BICMarketGetResponse.h
//  Biconome
//
//  Created by 车林 on 2019/8/28.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class GetWalletsNewResponse,BICGetWalletsNewResponse;

@protocol BICGetWalletsNewResponse <NSObject>

@end

@protocol GetWalletsNewResponse <NSObject>

@end

@interface BICGetWalletsNewResponse : BICBaseResponse

@property(nonatomic,copy)NSArray<GetWalletsNewResponse> *data;

@end

@interface GetWalletsNewResponse : BaseModel

@property(nonatomic,copy)NSString * addr;
@property(nonatomic,copy)NSString * tokenAddr;
@property(nonatomic,copy)NSString * userOpenId;
@property(nonatomic,copy)NSString * tokenSymbol;
@property(nonatomic,copy)NSString * tokenDecimals;
@property(nonatomic,copy)NSString * balance;
@property(nonatomic,copy)NSString * freeBalance;
@property(nonatomic,copy)NSString * freezeBalance;
@property(nonatomic,copy)NSString * walletType;
@property(nonatomic,copy)NSString * createTime;
@property(nonatomic,copy)NSString * updateTime;
@property(nonatomic,copy)NSString * logoAddr;
@property(nonatomic,copy)NSString * btcValue;
@property(nonatomic,copy)NSString * tokenId;
@property(nonatomic,copy)NSString * walletGasType;
@property(nonatomic,assign)BOOL isWithdrawal;
@property(nonatomic,assign)BOOL isRecharge;
@property(nonatomic,assign)BOOL isRemark;
@property(nonatomic,assign)BOOL isBlackWithdrawal;
@property(nonatomic,copy)NSString * minWdAmount;//
@property(nonatomic,copy)NSString * gasPrice;
@property(nonatomic,copy)NSString * limitPrice;
@property(nonatomic,copy)NSString * toAddr;
@end

NS_ASSUME_NONNULL_END

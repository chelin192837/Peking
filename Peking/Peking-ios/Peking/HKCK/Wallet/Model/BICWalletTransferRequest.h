//
//  BICWalletTransferRequest.h
//  Biconome
//
//  Created by 车林 on 2019/9/2.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICWalletTransferRequest : BICBaseRequest

@property(nonatomic,copy)NSString * tokenId;
@property(nonatomic,copy)NSString * tokenAddr;

@property(nonatomic,copy)NSString * walletType;
@property(nonatomic,copy)NSString * toAddr;
@property(nonatomic,copy)NSString * amount;
@property(nonatomic,copy)NSString * phone;
@property(nonatomic,copy)NSString * code;
//新加参数
//币种名称
@property(nonatomic,copy)NSString * tokenSymbol;
//查询eos资产返回的tokenName
@property(nonatomic,copy)NSString * tokenName;
//链类型 1，2
@property(nonatomic,copy)NSString * chainType;

@property(nonatomic,copy)NSString * verifyType;
@property(nonatomic,copy)NSString * googleKey;
@property(nonatomic,copy)NSString * googleCode;

@property(nonatomic,copy)NSString * id;
@end

NS_ASSUME_NONNULL_END

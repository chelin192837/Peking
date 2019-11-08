//
//  BICpcGetTransferInOutRequest.h
//  Biconome
//
//  Created by 车林 on 2019/8/31.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICpcGetTransferInOutRequest : BICBaseRequest

@property(nonatomic,strong)NSString * walletType;

@property(nonatomic,strong)NSString * transferType;

@property(nonatomic,assign)int pageNum;

@end

NS_ASSUME_NONNULL_END

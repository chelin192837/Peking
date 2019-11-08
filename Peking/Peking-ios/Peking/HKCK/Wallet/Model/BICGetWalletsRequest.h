//
//  BICGetWalletsRequest.h
//  Biconome
//
//  Created by 车林 on 2019/8/30.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICGetWalletsRequest : BICBaseRequest

@property(nonatomic,strong)NSString * walletType;

@end

NS_ASSUME_NONNULL_END

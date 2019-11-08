//
//  BICGetCurrencyConfigRequest.h
//  Biconome
//
//  Created by 车林 on 2019/9/2.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICGetCurrencyConfigRequest : BICBaseRequest

@property(nonatomic,strong)NSString * currencyName;

@property(nonatomic,strong)NSString * tokenSymbol;


@end

NS_ASSUME_NONNULL_END

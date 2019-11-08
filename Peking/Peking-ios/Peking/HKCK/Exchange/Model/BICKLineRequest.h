//
//  BICKLineRequest.h
//  Biconome
//
//  Created by 车林 on 2019/8/28.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICKLineRequest : BICBaseRequest

@property(nonatomic,strong)NSString * currencyPair;
@property(nonatomic,strong)NSString * timeType;
@property(nonatomic,strong)NSString * timeNumber;
@property(nonatomic,strong)NSString * start;
@property(nonatomic,strong)NSString * stop;

@end

NS_ASSUME_NONNULL_END

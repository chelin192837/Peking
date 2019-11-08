//
//  BICOrderCancelRequest.h
//  Biconome
//
//  Created by 车林 on 2019/8/27.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICOrderCancelRequest : BICBaseRequest

@property(nonatomic,strong)NSString * orderId;


@end

NS_ASSUME_NONNULL_END

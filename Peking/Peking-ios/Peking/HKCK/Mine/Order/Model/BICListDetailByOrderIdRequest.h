//
//  BICListDetailByOrderIdRequest.h
//  Biconome
//
//  Created by 车林 on 2019/8/29.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICListDetailByOrderIdRequest : BICBaseRequest

@property(nonatomic,assign)int pageNum;

@property(nonatomic,strong)NSString * orderId;

@end

NS_ASSUME_NONNULL_END

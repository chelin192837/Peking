//
//  BICDealListByUserRequest.h
//  Biconome
//
//  Created by 车林 on 2019/8/29.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICDealListByUserRequest : BICBaseRequest

@property(nonatomic,strong)NSString * coinName;
@property(nonatomic,strong)NSString * unitName;

@property(nonatomic,strong)NSString * status;
@property(nonatomic,assign)int pageNum;
@property(nonatomic,strong)NSString * beginTime;
@property(nonatomic,strong)NSString * lastTime;


@end

NS_ASSUME_NONNULL_END

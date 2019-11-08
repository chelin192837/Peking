//
//  BICListUserRequest.h
//  Biconome
//
//  Created by 车林 on 2019/8/24.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICListUserRequest : BICBaseRequest

@property(nonatomic,strong)NSString * coinName;
@property(nonatomic,strong)NSString * unitName;
@property(nonatomic,strong)NSString * type;
@property(nonatomic,strong)NSString * orderType;

@property(nonatomic,assign)int pageNum;


@end

NS_ASSUME_NONNULL_END

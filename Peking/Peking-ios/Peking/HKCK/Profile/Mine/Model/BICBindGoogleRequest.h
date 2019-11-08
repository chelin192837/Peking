//
//  BICBindGoogleRequest.h
//  Biconome
//
//  Created by 车林 on 2019/9/4.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICBindGoogleRequest : BICBaseRequest

@property(nonatomic,strong)NSString * googleKey;
@property(nonatomic,strong)NSString * googleCode;
@property(nonatomic,strong)NSString * tel;
@property(nonatomic,strong)NSString * code;
@property(nonatomic,strong)NSString * password;

@end

NS_ASSUME_NONNULL_END

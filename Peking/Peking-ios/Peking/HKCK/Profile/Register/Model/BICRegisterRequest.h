//
//  BICRegisterRequest.h
//  Biconome
//
//  Created by 车林 on 2019/8/12.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICRegisterRequest : BICBaseRequest

@property(nonatomic,copy)NSString *tel;

@property(nonatomic,copy)NSString *password;

@property(nonatomic,copy)NSString *internationalCode;

@property(nonatomic,copy)NSString *code;

@property(nonatomic,copy)NSString *invitationCode;


@property(nonatomic,copy)NSString *oldPassword;

@property(nonatomic,copy)NSString *verifyType;

@property(nonatomic,copy)NSString *googleCode;

@property(nonatomic,copy)NSString *googleKey;

@property(nonatomic,copy)NSString *source;


@end

NS_ASSUME_NONNULL_END

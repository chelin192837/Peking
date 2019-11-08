//
//  BICRegisterResponse.h
//  Biconome
//
//  Created by 车林 on 2019/8/12.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BICBaseResponse.h"
#import "BaseModel.h"
NS_ASSUME_NONNULL_BEGIN

@class regDetail,BICRegisterResponse;

@protocol BICRegisterResponse <NSObject>

@end

@protocol regDetail <NSObject>

@end

@interface BICRegisterResponse : BICBaseResponse

@property(nonatomic,strong)regDetail* data;

@end

@interface regDetail : BaseModel

@property(nonatomic,strong)NSString* id;
@property(nonatomic,strong)NSString* mobilePhone;
@property(nonatomic,strong)NSString* nickName;
@property(nonatomic,strong)NSString* avatar;
@property(nonatomic,strong)NSString* email;
@property(nonatomic,strong)NSString* lowAuth;
@property(nonatomic,strong)NSString* higthAuth;
@property(nonatomic,strong)NSString* grade;
@property(nonatomic,strong)NSString* hasPassword;
@property(nonatomic,strong)NSString* token;
@property(nonatomic,strong)NSString* invitationCode;

@property(nonatomic,assign)BOOL bindGoogleAuth;
@property(nonatomic,strong)NSString* internationalCode;

//谷歌验证KEY
@property(nonatomic,strong)NSString* googleKey;


@end



NS_ASSUME_NONNULL_END

//
//  SWViewController.h
//  SWOAuthCode
//
//  Created by shede333 on 06/05/2019.
//  Copyright (c) 2019 shede333. All rights reserved.
//

@import UIKit;

typedef NS_ENUM(NSInteger,LoginRegType)
{
    LoginRegType_login =99,
    LoginRegType_reg,
    LoginRegType_update,
    LoginRegType_reset,
    LoginRegType_logout,
    LoginRegType_Draw, //提币
    LoginRegType_Google,
    LoginRegType_modify//修改密码
};

@interface SWViewController : BaseViewController

@property(nonatomic,strong) BICRegisterRequest * requsestModel;

@property (nonatomic,assign)LoginRegType loginType;

@end

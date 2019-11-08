//
//  BICLoginVC.m
//  Biconome
//
//  Created by 车林 on 2019/8/13.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICLoginVC.h"
#import "BICSendRegCodeRequest.h"
#import "BICBaseResponse.h"
#import "SWViewController.h"
#import "UITextField+Placeholder.h"
#import "BICRegisterVC.h"
#import "BICSWViewController.h"
#import "BICResetPwdVC.h"
#import "BICRegisterResponse.h"
#import "WKWebViewController.h"

@interface BICLoginVC ()
@property (weak, nonatomic) IBOutlet UITextField *passwordTex;
@property (weak, nonatomic) IBOutlet UITextField *userNameTex;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *tipLab;
@property (weak, nonatomic) IBOutlet UILabel *accountLab;
@property (weak, nonatomic) IBOutlet UILabel *passwordNameLab;
@property (weak, nonatomic) IBOutlet UIButton *forgetPwdLab;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@property(nonatomic,strong) NSString* internationalCode;

@property(nonatomic,strong) NSString* googleKey;


@end

@implementation BICLoginVC



- (IBAction)forgetPwdBtn:(id)sender {
    
    BICResetPwdVC * resetPwdVC = [[BICResetPwdVC alloc] initWithNibName:@"BICResetPwdVC" bundle:nil];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:resetPwdVC];
    [self presentViewController:nav animated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

#pragma mark -键盘弹出添加监听事件
    // 键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    // 键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHiden:) name:UIKeyboardWillHideNotification object:nil];
    
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"close" titleColor:nil];
    [self initNavigationRightButtonWithTitle:LAN(@"注册") titileColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromContextWithColor:[UIColor colorWithHexColorString:@"6653FF"]] forBarMetrics:UIBarMetricsDefault];

    // 开始第三方键盘
    // 开始第三方键盘
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    // 点击屏幕隐藏键盘
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = NO;
    
    [self setupUI];
    
}
-(void)doRightBtnAction
{
    BICRegisterVC * registerVC = [[BICRegisterVC alloc] initWithNibName:@"BICRegisterVC" bundle:nil];
    
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:registerVC];
    
    [self presentViewController:nav animated:YES completion:nil];
}
-(void)backTo
{
    [self dismissViewControllerAnimated:YES completion:^{
        // 开始第三方键盘
        [[IQKeyboardManager sharedManager] setEnable:YES];
        [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = YES;
        [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
        // 点击屏幕隐藏键盘
        [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    }];
}
-(void)setupUI
{
    self.passwordTex.layer.borderColor = [UIColor whiteColor].CGColor;
    self.passwordTex.layer.borderWidth = 1.f;
    
    [self.passwordTex setPlaceHolder:LAN(@"输入密码") placeHoldColor:[UIColor colorWithHexColorString:@"FFFFFF" alpha:0.4] off_X:10.f];
    self.passwordTex.layer.cornerRadius = kBICCornerRadius;
    
    self.userNameTex.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.userNameTex setPlaceHolder:LAN(@"输入手机号") placeHoldColor:[UIColor colorWithHexColorString:@"FFFFFF" alpha:0.4] off_X:10.f];
    self.userNameTex.layer.borderWidth = 1.f;
    self.userNameTex.layer.cornerRadius = kBICCornerRadius;
    
    [self.loginBtn setTitle:LAN(@"登录") forState:UIControlStateNormal];
    self.titleLab.text = LAN(@"登录 Biconomy");
    self.tipLab.text = LAN(@"在下面输入您的帐户信息");
    self.accountLab.text = LAN(@"账户");
    self.passwordNameLab.text = LAN(@"密码");
    [self.forgetPwdLab setTitle:LAN(@"忘记密码") forState:UIControlStateNormal];
    [self.registerBtn setTitle:LAN(@"注册") forState:UIControlStateNormal];
   
    self.loginBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];


    self.loginBtn.zhw_acceptEventInterval = 3.f;
}

- (IBAction)backTo:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        // 开始第三方键盘
        [[IQKeyboardManager sharedManager] setEnable:YES];
        [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = YES;
        // 点击屏幕隐藏键盘
        [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    }];
    
}

-(BOOL)validate
{
    if (self.userNameTex.text.length==0) {
        [BICDeviceManager AlertShowTip:LAN(@"请填写手机号")];
        return NO;
    }else if (![BICDeviceManager deptNumInputShouldNumber:self.userNameTex.text])
    {
        [BICDeviceManager AlertShowTip:LAN(@"手机号格式错误")];
        return NO;
    }else if (self.passwordTex.text.length==0){
        [BICDeviceManager AlertShowTip:LAN(@"密码不能为空")];
        return NO;
    }
//    else if (![BICDeviceManager passwordVertify:self.passwordTex.text])
//    {
//        [BICDeviceManager AlertShowTip:[BICDeviceManager isOrNoPasswordStyle:self.passwordTex.text]];
//        return NO;
//    }
    return YES;
}
- (IBAction)nextBtn:(id)sender {
    if (![self validate]) {
        return;
    }
    [self.view endEditing:YES];
    BICRegisterRequest *request = [[BICRegisterRequest alloc] init];
    request.tel = self.userNameTex.text;
    request.password = self.passwordTex.text;
    request.source = @"APP";
    WEAK_SELF
    [[BICProfileService sharedInstance] analyticalPasswordData:request serverSuccessResultHandler:^(id response) {
        BICRegisterResponse * responseM = (BICRegisterResponse*)response;
        if (responseM.code==200) {
            self.internationalCode = responseM.data.internationalCode;
            self.googleKey = responseM.data.googleKey;
            [BICDeviceManager AlertShowTip:LAN(@"密码验证成功")];
            [weakSelf getCode];
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
    } failedResultHandler:^(id response) {
        
    } requestErrorHandler:^(id error) {
        
    }];

}

-(void)getCode
{
    WKWebViewController * wkWeb = [[WKWebViewController alloc] init];
    wkWeb.successBlock = ^{
        BICSWViewController * swViewVC = [[BICSWViewController alloc] initWithNibName:NSStringFromClass([BICSWViewController class]) bundle:nil];
        swViewVC.loginType = LoginRegType_login;
        BICRegisterRequest * requsetModel = [[BICRegisterRequest alloc] init];
        requsetModel.tel = self.userNameTex.text;
        requsetModel.password = self.passwordTex.text;
        requsetModel.googleKey = self.googleKey;
        requsetModel.internationalCode =self.internationalCode?:SDUserDefaultsGET(BICInternationalCode);
        swViewVC.requsestModel = requsetModel;
        [self presentViewController:swViewVC animated:YES
                         completion:nil];
    };
    
    [self.navigationController pushViewController:wkWeb animated:YES];

}

#pragma mark - 监听键盘事件
- (void)keyboardWasShown:(NSNotification *)notif {
    
    CGRect rect = [[notif.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat y = rect.size.height ;
    
    float animationTime = [[notif.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
  
    if(y+CGRectGetMaxY(self.loginBtn.frame)+20+kNavBar_Height > KScreenHeight){
        
        CGFloat off_y = y+CGRectGetMaxY(self.loginBtn.frame)+20+kNavBar_Height-KScreenHeight;
        if (self.view.y<kNavBar_Height) {
            return;
        }
        [UIView animateWithDuration:animationTime animations:^{
            
            self.view.y=self.view.y-off_y;
        }];
    }

}

- (void)keyboardWillBeHiden:(NSNotification *)notif {
    [UIView animateWithDuration:0.25 animations:^{
        
        self.view.frame = CGRectMake(0, kNavBar_Height, kScreenWidth, kScreenHeight);
    }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end

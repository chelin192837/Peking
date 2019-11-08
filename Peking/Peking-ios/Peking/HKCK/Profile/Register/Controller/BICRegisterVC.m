//
//  BICRegisterVC.m
//  Biconome
//
//  Created by 车林 on 2019/8/12.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICRegisterVC.h"
#import "BICRegisterRequest.h"
#import "BICSendRegCodeRequest.h"
#import "SWViewController.h"
#import "BICRegisterRequest.h"
#import "UITextField+Placeholder.h"
#import "XWCountryCodeController.h"
#import "TopAlertView.h"
#import "BICSWViewController.h"
#import "WKWebViewController.h"
@interface BICRegisterVC ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTex;
@property (weak, nonatomic) IBOutlet UITextField *passwordTex;
@property (weak, nonatomic) IBOutlet UIButton *registerTypeBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectAreaBtn;
@property(nonatomic,strong) NSString* internationalCode;
@property (weak, nonatomic) IBOutlet UILabel *areaLab;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *tipLab;
@property (weak, nonatomic) IBOutlet UILabel *accountLab;
@property (weak, nonatomic) IBOutlet UILabel *passwordNameLab;

@property (weak, nonatomic) IBOutlet UITextField *inviteCodeTex;
@property (weak, nonatomic) IBOutlet UILabel *inviteCode;

@end

@implementation BICRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.internationalCode = @"86";
    
    [self setupUI];
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"close" titleColor:nil];
    [self initNavigationRightButtonWithTitle:LAN(@"登录") titileColor:[UIColor whiteColor]];
   
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromContextWithColor:[UIColor colorWithHexColorString:@"6653FF"]] forBarMetrics:UIBarMetricsDefault];
    
#pragma mark -键盘弹出添加监听事件
    // 键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    // 键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHiden:) name:UIKeyboardWillHideNotification object:nil];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getCountryCode:) name:@"__IMP__AREA__" object:nil];
    
}
-(void)backTo{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)selectAreaBtn:(id)sender {
    
    XWCountryCodeController *CountryCodeVC = [[XWCountryCodeController alloc] init];
    CountryCodeVC.type=XWCountry_type_Other;
    CountryCodeVC.returnCountryCodeBlock = ^(NSString *countryName, NSString *code) {
        [self.selectAreaBtn setTitle:[NSString stringWithFormat:@"%@ +%@",countryName,code] forState:UIControlStateNormal];
        self.internationalCode = code;
    };
    
    [self.navigationController pushViewController:CountryCodeVC animated:YES];    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)doRightBtnAction
{
    [self dismissViewControllerAnimated:YES completion:^{
        
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
    
    self.inviteCodeTex.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.inviteCodeTex setPlaceHolder:LAN(@"输入邀请码") placeHoldColor:[UIColor colorWithHexColorString:@"FFFFFF" alpha:0.4] off_X:10.f];
    self.inviteCodeTex.layer.borderWidth = 1.f;
    self.inviteCodeTex.layer.cornerRadius = kBICCornerRadius;
    
    self.selectAreaBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.selectAreaBtn.layer.borderWidth = 1.f;
    self.selectAreaBtn.layer.cornerRadius = kBICCornerRadius;
    
    self.titleLab.text = LAN(@"注册 Biconomy");
      self.areaLab.text = LAN(@"地区");
    [self.selectAreaBtn setTitle:LAN(@"中国大陆 +86") forState:UIControlStateNormal];

    self.tipLab.text = LAN(@"在下面输入您的帐户信息");
    self.accountLab.text = LAN(@"账户");
    self.passwordNameLab.text = LAN(@"密码");
    
    self.inviteCode.text = LAN(@"邀请码");

    [self.registerTypeBtn setTitle:LAN(@"注册") forState:UIControlStateNormal];
    self.registerTypeBtn.zhw_acceptEventInterval = 3 ;

//    self.passwordTex.tintColor = kBICWhiteColor;
//    self.userNameTex.tintColor = kBICWhiteColor;

    self.registerTypeBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];


}

- (IBAction)registerBtn:(id)sender {
    if (![self validate]) {
        return;
    }
    BICRegisterRequest * request = [[BICRegisterRequest alloc] init];
    request.tel = self.userNameTex.text;
    request.password= self.passwordTex.text;
    request.internationalCode = self.internationalCode;
    request.invitationCode = self.inviteCodeTex.text;
    
    [[BICProfileService sharedInstance] analyticalRegisterVerifyData:request serverSuccessResultHandler:^(id response) {
        BICBaseResponse * responseM = (BICBaseResponse*)response;
        if (responseM.code==200) {
            [self sendCode];
        }else{
             [BICDeviceManager AlertShowTip:responseM.msg];
        }
    } failedResultHandler:^(id response) {
        
    } requestErrorHandler:^(id error) {
        
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
    }else if (![BICDeviceManager passwordVertify:self.passwordTex.text])
    {
        [BICDeviceManager AlertShowTip:[BICDeviceManager isOrNoPasswordStyle:self.passwordTex.text]];
        return NO;
    }
    return YES;
}



-(void)sendCode
{
    WKWebViewController * wkWeb = [[WKWebViewController alloc] init];
    wkWeb.successBlock = ^{
            BICSWViewController * swViewVC = [[BICSWViewController alloc] initWithNibName:NSStringFromClass([BICSWViewController class]) bundle:nil];
            swViewVC.loginType = LoginRegType_reg;
            BICRegisterRequest * requsetModel = [[BICRegisterRequest alloc] init];
            requsetModel.tel = self.userNameTex.text;
            requsetModel.password = self.passwordTex.text;
            requsetModel.internationalCode = self.internationalCode;
            requsetModel.invitationCode = self.inviteCodeTex.text;

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
    
    if(y+CGRectGetMaxY(self.registerTypeBtn.frame)+20+kNavBar_Height > KScreenHeight){
        
        CGFloat off_y = y+CGRectGetMaxY(self.registerTypeBtn.frame)+20 + kNavBar_Height-KScreenHeight;
        if (self.view.y<0) {
            return;
        }
        [UIView animateWithDuration:animationTime animations:^{
            
            self.view.y=self.view.y-off_y;
        }];
    }
    
}

- (void)keyboardWillBeHiden:(NSNotification *)notif {
    [UIView animateWithDuration:0.25 animations:^{
        
        self.view.frame = CGRectMake(0,kNavBar_Height, kScreenWidth, kScreenHeight);
    }];
    
}

-(void)getCountryCode:(NSNotification*)notify
{
    NSDictionary*dic = notify.object;
    
    [self.selectAreaBtn setTitle:[NSString stringWithFormat:@"%@ +%@",dic[@"countryName"],dic[@"code"]] forState:UIControlStateNormal];
    self.internationalCode = dic[@"code"];
    
//    NSLog(@"__IMP__AREA__%@",dic);
}


@end

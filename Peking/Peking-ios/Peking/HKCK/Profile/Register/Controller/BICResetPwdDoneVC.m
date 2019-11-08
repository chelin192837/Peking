//
//  BICResetPwdDoneVC.m
//  Biconome
//
//  Created by 车林 on 2019/8/17.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICResetPwdDoneVC.h"
#import "UITextField+Placeholder.h"
#import "BICRegisterResponse.h"
@interface BICResetPwdDoneVC ()
@property (weak, nonatomic) IBOutlet UITextField *password1Tex;
@property (weak, nonatomic) IBOutlet UITextField *password2Tex;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;


@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *tipLab;
@property (weak, nonatomic) IBOutlet UILabel *accountLab;
@property (weak, nonatomic) IBOutlet UILabel *passwordNameLab;


@end

@implementation BICResetPwdDoneVC
- (IBAction)nextBtn:(id)sender {
    if (![self validate]) {
        return;
    }
    [self resetRequest];
}

-(BOOL)validate
{
     if (self.password1Tex.text.length==0){
        [BICDeviceManager AlertShowTip:LAN(@"密码不能为空")];
        return NO;
    }else if (![BICDeviceManager passwordVertify:self.password1Tex.text])
    {
        [BICDeviceManager AlertShowTip:[BICDeviceManager isOrNoPasswordStyle:self.password1Tex.text]];
        return NO;
    }else if (self.password2Tex.text.length==0){
        [BICDeviceManager AlertShowTip:LAN(@"密码不能为空")];
        return NO;
    }else if (![BICDeviceManager passwordVertify:self.password2Tex.text])
    {
        [BICDeviceManager AlertShowTip:[BICDeviceManager isOrNoPasswordStyle:self.password2Tex.text]];
        return NO;
    }else if (![self.password1Tex.text isEqualToString:self.password2Tex.text])
    {
        [BICDeviceManager AlertShowTip:LAN(@"两次输入密码不一致")];
        return NO;
    }
    return YES;
}
-(void)resetRequest
{
    self.requsestModel.password = self.password1Tex.text;
    
    [[BICProfileService sharedInstance] analyticalResetPasswordData:self.requsestModel serverSuccessResultHandler:^(id response) {
        BICRegisterResponse * responseM =(BICRegisterResponse*)response;
        if (responseM.code == 200) {
            
            [BICDeviceManager AlertShowTip:LAN(@"重置密码成功")];
            // 开始第三方键盘
            [[IQKeyboardManager sharedManager] setEnable:YES];
            [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = YES;
            [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
            // 点击屏幕隐藏键盘
            [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
            [self dismissToRootViewController];
 
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
            
        }
        
    } failedResultHandler:^(id response) {
        
    } requestErrorHandler:^(id error) {
        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"close" titleColor:nil];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromContextWithColor:[UIColor colorWithHexColorString:@"6653FF"]] forBarMetrics:UIBarMetricsDefault];

    // 键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    // 键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHiden:) name:UIKeyboardWillHideNotification object:nil];
    
    [self setupUI];
    
}
-(void)setupUI
{
    self.password1Tex.layer.borderColor = [UIColor whiteColor].CGColor;
    self.password1Tex.layer.borderWidth = 1.f;
    [self.password1Tex setPlaceHolder:LAN(@"设置新密码") placeHoldColor:[UIColor colorWithHexColorString:@"FFFFFF" alpha:0.4] off_X:10.f];
    self.password1Tex.layer.cornerRadius = kBICCornerRadius;
    
    self.password2Tex.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.password2Tex setPlaceHolder:LAN(@"确认新密码") placeHoldColor:[UIColor colorWithHexColorString:@"FFFFFF" alpha:0.4] off_X:10.f];
    self.password2Tex.layer.borderWidth = 1.f;
    self.password2Tex.layer.cornerRadius = kBICCornerRadius;
    
    self.nextButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.nextButton.layer.borderWidth = 1.f;
    self.nextButton.layer.cornerRadius = kBICCornerRadius;
    
    
    self.titleLab.text = LAN(@"重置密码");
    self.tipLab.text = LAN(@"为了账户安全，重置登录密码后24小时禁止提币");

    self.accountLab.text = LAN(@"密码");
    self.passwordNameLab.text = LAN(@"确认密码");
    
    [self.nextButton setTitle:LAN(@"确认重置") forState:UIControlStateNormal];
    self.nextButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];

    self.nextButton.zhw_acceptEventInterval = 3 ;

    
}

-(void)backTo
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 监听键盘事件
- (void)keyboardWasShown:(NSNotification *)notif {
    
    CGRect rect = [[notif.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat y = rect.size.height ;
    
    float animationTime = [[notif.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    if(y+CGRectGetMaxY(self.nextButton.frame)+20+kNavBar_Height > KScreenHeight){
        
        CGFloat off_y = y+CGRectGetMaxY(self.nextButton.frame)+20+kNavBar_Height -KScreenHeight;
        if (self.view.y<kNavBar_Height) {
            return;
        }
        [UIView animateWithDuration:animationTime animations:^{
            
            self.view.y=self.view.y-off_y;
        }];
    }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)keyboardWillBeHiden:(NSNotification *)notif {
    [UIView animateWithDuration:0.25 animations:^{
        
        self.view.frame = CGRectMake(0,kNavBar_Height, kScreenWidth, kScreenHeight);
    }];
    
}


@end

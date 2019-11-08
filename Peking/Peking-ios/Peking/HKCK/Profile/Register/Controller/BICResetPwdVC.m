//
//  BICResetPwdVC.m
//  Biconome
//
//  Created by 车林 on 2019/8/16.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICResetPwdVC.h"
#import "UITextField+Placeholder.h"
#import "BICSendRegCodeRequest.h"
#import "BICSWViewController.h"
#import "XWCountryCodeController.h"
#import "BICRegisterResponse.h"
#import "WKWebViewController.h"
@interface BICResetPwdVC ()
@property (weak, nonatomic) IBOutlet UIButton *areaBtn;
@property (weak, nonatomic) IBOutlet UITextField *iphoneTex;
@property (weak, nonatomic) IBOutlet UIButton *selectAreaBtn;

@property(nonatomic,strong) NSString* internationalCode;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *tipLab;
@property (weak, nonatomic) IBOutlet UILabel *accountLab;

@end

@implementation BICResetPwdVC


- (IBAction)nextBtn:(id)sender {
    if (![self validate]) {
        return;
    }
    BICRegisterRequest *request = [[BICRegisterRequest alloc] init];
    request.tel = self.iphoneTex.text;
    WEAK_SELF
    [[BICProfileService sharedInstance] analyticalLoginTelData:request serverSuccessResultHandler:^(id response) {
        BICRegisterResponse * responseM = (BICRegisterResponse*)response;
        if (responseM.code==200) {
            self.internationalCode = responseM.data.internationalCode;
            
            [weakSelf sendCode];
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
    } failedResultHandler:^(id response) {
        
    } requestErrorHandler:^(id error) {
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"close" titleColor:nil];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromContextWithColor:[UIColor colorWithHexColorString:@"6653FF"]] forBarMetrics:UIBarMetricsDefault];

    // Do any additional setup after loading the view from its nib.
#pragma mark -键盘弹出添加监听事件
    // 键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    // 键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHiden:) name:UIKeyboardWillHideNotification object:nil];
}


-(void)backTo{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)setupUI
{
    self.iphoneTex.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.iphoneTex setPlaceHolder:LAN(@"输入手机号") placeHoldColor:[UIColor colorWithHexColorString:@"FFFFFF" alpha:0.4] off_X:10.f];
    self.iphoneTex.layer.borderWidth = 1.f;
    self.iphoneTex.layer.cornerRadius = kBICCornerRadius;
    
    [self.selectAreaBtn setTitle:LAN(@"下一步") forState:UIControlStateNormal];
    
    self.titleLab.text = LAN(@"重置密码");
    self.tipLab.text = LAN(@"为了账户安全，重置登录密码后24小时禁止提币");
    self.accountLab.text = LAN(@"账户");
    
    self.selectAreaBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];

    self.selectAreaBtn.zhw_acceptEventInterval = 3 ;

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(BOOL)validate
{
    if (self.iphoneTex.text.length==0) {
        [BICDeviceManager AlertShowTip:LAN(@"请填写手机号")];
        return NO;
    }else if (![BICDeviceManager deptNumInputShouldNumber:self.iphoneTex.text])
    {
        [BICDeviceManager AlertShowTip:LAN(@"手机号格式错误")];
        return NO;
    }
    return YES;
}

-(void)sendCode
{
    WKWebViewController * wkWeb = [[WKWebViewController alloc] init];
    wkWeb.successBlock = ^{

            BICSWViewController * swViewVC = [[BICSWViewController alloc] initWithNibName:NSStringFromClass([BICSWViewController class]) bundle:nil];
            swViewVC.loginType = LoginRegType_reset;
            BICRegisterRequest * requsetModel = [[BICRegisterRequest alloc] init];
            requsetModel.tel = self.iphoneTex.text;
            requsetModel.internationalCode = self.internationalCode?:SDUserDefaultsGET(BICInternationalCode);
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
    
    if(y+CGRectGetMaxY(self.selectAreaBtn.frame)+20+kNavBar_Height > KScreenHeight){
        
        CGFloat off_y = y+CGRectGetMaxY(self.selectAreaBtn.frame)+20+kNavBar_Height -KScreenHeight;
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



@end

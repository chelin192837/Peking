//
//  SWViewController.m
//  SWOAuthCode
//
//  Created by shede333 on 06/05/2019.
//  Copyright (c) 2019 shede333. All rights reserved.
//

#import "SWViewController.h"

#import <Masonry/Masonry.h>
#import <SWOAuthCode/SWOAuthCodeView.h>
#import "BICRegisterResponse.h"

@interface SWViewController ()<SWOAuthCodeViewDelegate>

@property (nonatomic, strong) SWOAuthCodeView *oacView;

@end

@implementation SWViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor colorWithHexColorString:@"6653FF"];
    
//    [self initNavigationTitleViewLabelWithTitle:@"获取验证码" IfBelongTabbar:NO];
    
    //创建view时，需要指定验证码的长度
    SWOAuthCodeView *oacView = [[SWOAuthCodeView alloc] initWithMaxLength:6];
    self.oacView = oacView;
    [self.view addSubview:oacView];
    /* -----设置可选的属性 start----- */
    oacView.delegate = self; //设置代理
    oacView.boxNormalBorderColor = [UIColor grayColor]; //方框的边框正常状态时的边框颜色
    oacView.boxHighlightBorderColor = [UIColor blackColor]; //方框的边框输入状态时的边框颜色
    oacView.boxBorderWidth = 5; //方框的边框宽度
    oacView.boxCornerRadius = 6; //方框的圆角半径
    oacView.boxBGColor = [UIColor whiteColor];  //方框的背景色
    oacView.boxTextColor = [UIColor blackColor]; //方框内文字的颜色
    oacView.backgroundColor = [UIColor whiteColor]; //底色为：灰色
    /* -----设置可选的属性 end----- */
    
    //显示键盘，可以输入验证码了
    [oacView beginEdit];
    
    //可选步骤：Masonry布局/设置frame
    [oacView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(oacView.superview).offset(15);
        make.right.equalTo(oacView.superview).offset(-15);
        make.top.equalTo(oacView.superview).offset(150);
        make.height.mas_equalTo(44);
    }];

}

- (void)testLayout{
    //3秒后，布局大小改变，看看能够自动适应
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.oacView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.oacView.superview).offset(30);
//            make.right.equalTo(self.oacView.superview).offset(-30);
//            make.top.equalTo(self.oacView.superview).offset(200);
//            make.height.mas_equalTo(35);
//        }];
//    });
    
}

#pragma mark - SWOAuthCodeViewDelegate

- (void)oauthCodeView :(SWOAuthCodeView *)mqView inputTextChange:(NSString *)currentText{
//    NSLog(@"currentText: %@", currentText);
    
}

- (void)oauthCodeView:(SWOAuthCodeView *)mqView didInputFinish:(NSString *)finalText{
  
    NSLog(@"didInputFinish: %@", finalText);
    
    if (self.loginType==LoginRegType_login) {
        [self loginRequest:finalText];
    }else if(self.loginType==LoginRegType_reg){
//        [self registerRequest:finalText];
    }else if(self.loginType==LoginRegType_reset)
    {
        [self resetRequest:finalText];
    }else if(self.loginType==LoginRegType_Draw)
    {
        [self drawCoinRequest:finalText];
    }
    
    
    
}


-(void)loginRequest:(NSString *)finalText
{
    self.requsestModel.code = finalText;
    self.requsestModel.verifyType = @"phone";
    [[BICProfileService sharedInstance] analyticalLoginByCodeData:self.requsestModel serverSuccessResultHandler:^(id response) {
        BICRegisterResponse * responseM =(BICRegisterResponse*)response;
        if (responseM.code == 200) {
            [BICDeviceManager AlertShowTip:LAN(@"登录成功")];
            
            NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
            [standard setObject:responseM.data.token forKey:APPID];
            [standard setObject:responseM.data.mobilePhone forKey:BICMOBILE];
            
            //debug--
            [standard setObject:@1001 forKey:[NSString stringWithFormat:@"%@%@",BICCOINMONEY_,@"USDT"]];

        }else{
            
        }
        
    } failedResultHandler:^(id response) {
        
    } requestErrorHandler:^(id error) {
        
    }];
    
    
}
-(void)drawCoinRequest:(NSString *)finalText
{
//    [[BICWalletService sharedInstance] analyticalWithdrawDepositData:<#(nonnull BICBaseRequest *)#> serverSuccessResultHandler:^(id response) {
//        <#code#>
//    } failedResultHandler:^(id response) {
//        <#code#>
//    } requestErrorHandler:^(id error) {
//        <#code#>
//    }];
    
    
}

-(void)resetRequest:(NSString *)finalText
{
    
    [[BICProfileService sharedInstance] analyticalResetPasswordData:self.requsestModel serverSuccessResultHandler:^(id response) {
        BICRegisterResponse * responseM =(BICRegisterResponse*)response;
        if (responseM.code == 200) {
            [ODAlertViewFactory showToastWithMessage:@"重置密码成功"];
        }else{
            
        }
        
    } failedResultHandler:^(id response) {
        
    } requestErrorHandler:^(id error) {
        
    }];
}


#pragma mark - action
- (IBAction)actionShowErrorState:(id)sender {
    [self.oacView setAllBoxBorderColor:[UIColor redColor]];
}

- (IBAction)actionEndEdit:(id)sender {
    [self.oacView endEdit];
}

- (IBAction)actionAddRandomText:(id)sender {
    NSInteger firstInt = pow(10, 10);
    NSString *randomText = [NSString stringWithFormat:@"%ld", (NSInteger)(firstInt + arc4random()%(firstInt * 8))];
    randomText = [randomText substringToIndex:(arc4random()%randomText.length)];
    NSLog(@"actionAddRandomText: %@, len: %ld", randomText, randomText.length);
    [self.oacView setInputBoxText:randomText];
}

- (IBAction)actionEmptyText:(id)sender {
    [self.oacView setInputBoxText:nil];
}



@end

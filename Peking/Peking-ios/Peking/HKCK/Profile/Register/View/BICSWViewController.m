//
//  BICSWViewController.m
//  Biconome
//
//  Created by 车林 on 2019/8/16.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICSWViewController.h"
#import <SWOAuthCode/SWOAuthCodeView.h>
#import "BICRegisterResponse.h"
#import "BICResetPwdDoneVC.h"
#import "CQCountDownButton.h"
#import "BICSendRegCodeRequest.h"
#import "BICBindGoogleResponse.h"
#import "BICGetWalletsResponse.h"
#import "AppDelegate.h"
#import "BICDataToUserDefault.h"
@interface BICSWViewController ()<SWOAuthCodeViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *codeBGView;
@property (weak, nonatomic) IBOutlet UILabel *iphoneLab;

@property (nonatomic, strong) SWOAuthCodeView *oacView;
@property (nonatomic, strong) NSString *finalText;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (nonatomic, strong) CQCountDownButton *countDownButton;

@property (weak, nonatomic) IBOutlet UIView *countDownBgView;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;


@property (weak, nonatomic) IBOutlet UILabel *accountLab;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property(nonatomic,assign) BOOL index;

@property (nonatomic, strong)NSString* verifyType;
@end

@implementation BICSWViewController


- (IBAction)rightBtnClick:(id)sender {
    
    self.index = !self.index;
    
    if(self.index)
    {
        self.countDownButton.hidden = NO ;
    }else{
        self.countDownButton.hidden = YES ;
    }
    
    [self setRightBtnTitle:self.index];
    
    [self setMiddenTitle:self.index];
}

-(void)setRightBtnTitle:(BOOL)index
{
    if (!index) {
        self.verifyType = @"google";
        [self.rightBtn setTitle:LAN(@"手机验证") forState:UIControlStateNormal];
    }else{
        self.verifyType = @"phone";
        [self.rightBtn setTitle:LAN(@"谷歌验证") forState:UIControlStateNormal];
    }
}

-(void)setMiddenTitle:(BOOL)index
{
    if(index){
        self.titleLab.text = LAN(@"手机验证");
        self.accountLab.text = LAN(@"验证码");
        self.iphoneLab.text = [NSString stringWithFormat:@"%@%@%@",LAN(@"输入手机号"),self.requsestModel.tel,LAN(@"收到的六位数验证码")];
    }else{
        self.titleLab.text = LAN(@"谷歌验证");
        self.accountLab.text = LAN(@"验证码");
        self.iphoneLab.text = LAN(@"请输入谷歌验证中的六位数验证码");
    }
}

- (IBAction)backTo:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.countDownButton.timer invalidate];
    self.countDownButton.timer=nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLab.text = LAN(@"手机验证");
    if([SDUserDefaultsGET(BICBindGoogleAuth) intValue]){
        self.rightBtn.hidden=NO;
    }else{
        self.rightBtn.hidden=YES;
    }
    [self.rightBtn setTitle:LAN(@"谷歌验证") forState:UIControlStateNormal];
    self.accountLab.text = LAN(@"验证码");
    self.iphoneLab.text = [NSString stringWithFormat:@"%@%@%@",LAN(@"输入手机号"),self.requsestModel.tel,LAN(@"收到的六位数验证码")];
    
    //创建view时，需要指定验证码的长度
    SWOAuthCodeView *oacView = [[SWOAuthCodeView alloc] initWithMaxLength:6];
    self.oacView = oacView;
    [self.codeBGView addSubview:oacView];
    /* -----设置可选的属性 start----- */
    oacView.delegate = self; //设置代理
    oacView.boxNormalBorderColor = [UIColor colorWithHexColorString:@"FFFFFF" alpha:0.4]; //方框的边框正常状态时的边框颜色
    oacView.boxHighlightBorderColor = [UIColor whiteColor]; //方框的边框输入状态时的边框颜色
    oacView.boxBorderWidth = 1; //方框的边框宽度
    oacView.boxCornerRadius = kBICCornerRadius; //方框的圆角半径
    oacView.boxBGColor = kBICMainBGColor;  //方框的背景色
    oacView.boxTextColor = [UIColor whiteColor]; //方框内文字的颜色
    oacView.backgroundColor = kBICMainBGColor; //底色为：灰色
    /* -----设置可选的属性 end----- */
    //显示键盘，可以输入验证码了
    [oacView beginEdit];
    
    WEAK_SELF
    //可选步骤：Masonry布局/设置frame
    [oacView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.codeBGView);
    }];
    
    self.countDownButton = [[CQCountDownButton alloc] init];
    [self.countDownBgView addSubview:self.countDownButton];
    [self.countDownButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.top.equalTo(weakSelf.countDownBgView);
    }];
    
    [self.countDownButton setTitle:LAN(@"发送") forState:UIControlStateNormal];
    self.countDownButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    self.countDownButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [self.countDownButton setTitleColor:[UIColor colorWithHexColorString:@"FFFFFF" alpha:1] forState:UIControlStateNormal];
    [self.countDownButton setTitleColor:[UIColor colorWithHexColorString:@"FFFFFF" alpha:0.6] forState:UIControlStateDisabled];
    
    //    __weak typeof(self) weakSelf = self;
    [self.countDownButton configDuration:120 buttonClicked:^{
        //========== 按钮点击 ==========//
        if (weakSelf.index) {
            [weakSelf.countDownButton startCountDown];
            [weakSelf getCode];
        }else{
            
        }
    } countDownStart:^{
        //========== 倒计时开始 ==========//
        NSLog(@"倒计时开始");
    } countDownUnderway:^(NSInteger restCountDownNum) {
        //========== 倒计时进行中 ==========//
        NSString *title = [NSString stringWithFormat:@"%lds", restCountDownNum];
        [weakSelf.countDownButton setTitle:title forState:UIControlStateNormal];
    } countDownCompletion:^{
        //========== 倒计时结束 ==========//
        [weakSelf.countDownButton setTitle:LAN(@"发送") forState:UIControlStateNormal];
        NSLog(@"倒计时结束");
    }];
    
    //    [self.countDownButton startCountDown];
    self.nextButton.zhw_acceptEventInterval = 3 ;

    if (self.loginType==LoginRegType_login) {
        [self.nextButton setTitle:LAN(@"登录") forState:UIControlStateNormal];
    }else if(self.loginType==LoginRegType_reg){
        [self.nextButton setTitle:LAN(@"注册") forState:UIControlStateNormal];
    }else if(self.loginType==LoginRegType_reset)
    {
        [self.nextButton setTitle:LAN(@"重置") forState:UIControlStateNormal];
    }else if(self.loginType==LoginRegType_Draw)
    {
        [self.nextButton setTitle:LAN(@"提币") forState:UIControlStateNormal];
    }else if(self.loginType==LoginRegType_Google)
    {
        [self.nextButton setTitle:LAN(@"启用") forState:UIControlStateNormal];
    }
    
    self.nextButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    
    
    self.index = YES; //手机验证
    
    self.verifyType = @"phone";
    
    if (self.loginType==LoginRegType_reg
        || self.loginType==LoginRegType_Google
        || self.loginType==LoginRegType_reset) {
        
        self.rightBtn.hidden = YES;
    }
    
    if (self.loginType==LoginRegType_login) {
        if (!self.requsestModel.googleKey) {
            self.rightBtn.hidden = YES;
        }
    }
    
    
    if(self.loginType==LoginRegType_modify){
        self.view.backgroundColor=[UIColor whiteColor];
        self.titleLab.textColor=UIColorWithRGB(0x33353B);
        self.iphoneLab.textColor=UIColorWithRGB(0x95979D);
        self.accountLab.textColor=UIColorWithRGB(0x64666C);
        [self.rightBtn setTitleColor:UIColorWithRGB(0x33353B) forState:UIControlStateNormal];
        [self.countDownButton setTitleColor:UIColorWithRGB(0x64666C) forState:UIControlStateNormal];
        self.oacView.boxNormalBorderColor = UIColorWithRGB(0xC6C8CE);
        self.oacView.boxHighlightBorderColor = UIColorWithRGB(0x6653FF);
        self.oacView.boxBGColor = [UIColor whiteColor];  //方框的背景色
        self.oacView.boxTextColor = UIColorWithRGB(0x6653FF); //方框内文字的颜色
        self.oacView.backgroundColor = [UIColor whiteColor]; //底色为：灰色
        [self.nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.leftBtn setImage:[UIImage imageNamed:@"fanhuiHei"] forState:UIControlStateNormal];
        [self.nextButton setBackgroundColor:UIColorWithRGB(0x6653FF)];
        [self.nextButton setTitle:LAN(@"确认修改") forState:UIControlStateNormal];
    }
}

-(void)getCode
{
    BICSendRegCodeRequest *request = [[BICSendRegCodeRequest alloc] init];
    request.tel = self.requsestModel.tel;
    request.internationalCode = self.requsestModel.internationalCode;
    
    if (self.loginType==LoginRegType_login) {
        request.type = @"login";
    }else if(self.loginType==LoginRegType_reg){
        request.type = @"register";
    }else if(self.loginType==LoginRegType_reset)
    {
        request.type = @"resetpwd";
    }else if(self.loginType==LoginRegType_Draw)
    {
        request.type = @"withdrawal";
    }else if(self.loginType==LoginRegType_Google)
    {
        request.type = @"bindGoogle";
    }else if(self.loginType==LoginRegType_modify){
        request.type=@"updpwd";
    }
    [ODAlertViewFactory showLoadingViewWithView:self.view];
    WEAK_SELF
    [[BICProfileService sharedInstance] analyticalSendRegisterCodeData:request serverSuccessResultHandler:^(id response) {
        BICBaseResponse * responseM = (BICBaseResponse*)response;
        if (responseM.code==200 || responseM.code==1138) {
            [BICDeviceManager AlertShowTip:LAN(@"验证码发送成功")];
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    }];
}


//防止重复点击问题
- (IBAction)loginBtn:(id)sender {
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(btnClikeToProcess:) object:sender];
    [self performSelector:@selector(btnClikeToProcess:) withObject:sender afterDelay:0.2f];
}

-(void)btnClikeToProcess:(id)sender{
    
    if (self.finalText.length<6) {
        return;
    }
    if(self.loginType==LoginRegType_Google){
        self.requsestModel.code =self.finalText;
    }else{
        self.requsestModel.googleCode =self.finalText;
    }
    self.requsestModel.verifyType = self.verifyType;
//    [ODAlertViewFactory showLoadingViewWithView:self.view];
    if (self.loginType==LoginRegType_login) {
        [self loginRequest:self.finalText];
    }else if(self.loginType==LoginRegType_reg){
        [self registerRequest:self.finalText];
    }else if(self.loginType==LoginRegType_reset)
    {
        [self resetRequest:self.finalText];
    }else if(self.loginType==LoginRegType_Draw)
    {
        self.transferRequest.code = self.finalText;
        self.transferRequest.googleCode = self.finalText;
        self.transferRequest.verifyType = self.verifyType;
        [self analyData_ALLTYPE];
    }else if(self.loginType==LoginRegType_Google)
    {
        [self gooleCodeRequest:self.finalText];
    }else if(self.loginType==LoginRegType_modify){
        self.requsestModel.verifyType = self.verifyType;
        self.requsestModel.googleCode = self.finalText;
        self.requsestModel.code = self.finalText;
        [self analyData_updpwd];
    }
    
}

-(void)analyData_updpwd{
    WEAK_SELF
    [ODAlertViewFactory showLoadingViewWithView:self.view];
    [[BICProfileService sharedInstance] analyticalupdatePass:self.requsestModel serverSuccessResultHandler:^(id response) {
        BICBaseResponse * responseM  = (BICBaseResponse *)response;
        if (responseM.code==200) {
            [BICDeviceManager AlertShowTip:LAN(@"登录密码修改成功")];
            [weakSelf dismissToRootViewController];
            if(weakSelf.backFinishItemOperationBlock){
                weakSelf.backFinishItemOperationBlock();
            }
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    }];
}

-(void)analyData_ALLTYPE{
    WEAK_SELF
    [ODAlertViewFactory showLoadingViewWithView:self.view];
    [[BICWalletService sharedInstance] analyticalWithdrawAllType:self.transferRequest serverSuccessResultHandler:^(id response) {
        BICGetWalletsResponse * responseM  = (BICGetWalletsResponse *)response;
        if (responseM.code==200) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:ISNeedUpdateExchangeView];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [BICDeviceManager AlertShowTip:LAN(@"提币成功")];
            [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenterWithDrawBackRefWeb object:responseM];
            [weakSelf dismissToRootViewController];
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    }];
}


#pragma mark - SWOAuthCodeViewDelegate

- (void)oauthCodeView :(SWOAuthCodeView *)mqView inputTextChange:(NSString *)currentText{
    //    NSLog(@"currentText: %@", currentText);
    
}

- (void)oauthCodeView:(SWOAuthCodeView *)mqView didInputFinish:(NSString *)finalText{
    
    self.finalText = finalText;
    
}

-(void)loginRequest:(NSString *)finalText
{
    WEAK_SELF
    self.requsestModel.code = finalText;
    self.requsestModel.verifyType = self.verifyType;
    [ODAlertViewFactory showLoadingViewWithView:self.view];
    [[BICProfileService sharedInstance] analyticalLoginByCodeData:self.requsestModel serverSuccessResultHandler:^(id response) {
        BICRegisterResponse * responseM =(BICRegisterResponse*)response;
        if (responseM.code == 200) {
            [BICDeviceManager AlertShowTip:LAN(@"登录成功")];
            
            NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
            [standard setObject:responseM.data.id forKey:USERID];
            [standard setObject:responseM.data.token forKey:APPID];
            [standard setObject:responseM.data.mobilePhone forKey:BICMOBILE];
            [standard setObject:responseM.data.nickName forKey:BICNickName];
            [standard setObject:@(responseM.data.bindGoogleAuth) forKey:BICBindGoogleAuth];
            [standard setObject:responseM.data.internationalCode forKey:BICInternationalCode];
            [standard setObject:@(responseM.data.bindGoogleAuth) forKey:BICBindGoogleAuth];
            [standard setObject:responseM.data.invitationCode forKey:BICInvitationCode];
            [standard synchronize];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:KUpdate_Token object:nil];
            
            kPOSTNSNotificationCenter(NSNotificationCenterProfileHeader, nil);
            
            [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenterLoginSucceed object:nil];
            
            //初始化数据
            BICDataToUserDefault * userDefult = [[BICDataToUserDefault alloc] init];
            [userDefult setupData];
            
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
              
                
                [weakSelf dismissToRootViewController];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                              // 开始第三方键盘
                                  [[IQKeyboardManager sharedManager] setEnable:YES];
                                  [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = YES;
                                  [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
                                  // 点击屏幕隐藏键盘
                                  [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
                });
                
            });
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    }];
    
}


-(void)registerRequest:(NSString *)finalText
{
    WEAK_SELF
    self.requsestModel.code = finalText;
    self.requsestModel.verifyType = self.verifyType;
    [ODAlertViewFactory showLoadingViewWithView:self.view];
    [[BICProfileService sharedInstance] analyticalRegisterData:self.requsestModel serverSuccessResultHandler:^(id response) {
        BICRegisterResponse * responseM =(BICRegisterResponse*)response;
        if (responseM.code == 200) {
            [BICDeviceManager AlertShowTip:LAN(@"注册成功")];
            SDUserDefaultsSET(weakSelf.requsestModel.internationalCode, INTERNATIONCODE);
            
            
            NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
            
            [standard setObject:responseM.data.token forKey:APPID];
            [standard setObject:responseM.data.mobilePhone forKey:BICMOBILE];
            [standard setObject:responseM.data.nickName forKey:BICNickName];
            [standard setObject:@(responseM.data.bindGoogleAuth) forKey:BICBindGoogleAuth];
            [standard setObject:responseM.data.internationalCode forKey:BICInternationalCode];
            [standard setObject:@(responseM.data.bindGoogleAuth) forKey:BICBindGoogleAuth];
            
            
            [[NSNotificationCenter defaultCenter] postNotificationName:KUpdate_Token object:nil];
            
            kPOSTNSNotificationCenter(NSNotificationCenterProfileHeader, nil);
            
            [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenterLoginSucceed object:nil];
            
            BaseTabBarController *nmTabBarVC =  ((AppDelegate*)[UIApplication sharedApplication].delegate).mainController;
                  [nmTabBarVC setSelectedIndex:0];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf dismissToRootViewController];

                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    // 开始第三方键盘
                    [[IQKeyboardManager sharedManager] setEnable:YES];
                    [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = YES;
                    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
                    // 点击屏幕隐藏键盘
                    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
                });

            });
            
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    }];
}
-(void)gooleCodeRequest:(NSString *)finalText
{
    WEAK_SELF
    self.requsestModel.verifyType = self.verifyType;
    self.requsestModel.code=finalText;
    [ODAlertViewFactory showLoadingViewWithView:self.view];
    [[BICProfileService sharedInstance] analyticalBindGoogleData:self.requsestModel serverSuccessResultHandler:^(id response) {
        BICBaseResponse * responseM  = (BICBaseResponse*)response;
        if (responseM.code == 200) {
            [BICDeviceManager AlertShowTip:LAN(@"谷歌验证成功")];
            SDUserDefaultsSET(@(YES), BICBindGoogleAuth);
            
            [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenterBindGoogleSucceed object:nil];
            
            [weakSelf dismissToRootViewController];
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    }];
}

-(void)resetRequest:(NSString *)finalText
{
    WEAK_SELF
    self.requsestModel.code = finalText;
    self.requsestModel.verifyType = self.verifyType;
    [ODAlertViewFactory showLoadingViewWithView:self.view];
    [[BICProfileService sharedInstance] analyticalResetPasswordVerifyData:self.requsestModel serverSuccessResultHandler:^(id response) {
        BICRegisterResponse * responseM =(BICRegisterResponse*)response;
        if (responseM.code == 200) {
            
            BICResetPwdDoneVC * resetVC = [[BICResetPwdDoneVC alloc] initWithNibName:@"BICResetPwdDoneVC" bundle:nil];
            resetVC.requsestModel = self.requsestModel;
            UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:resetVC];
            
            [weakSelf presentViewController:nav animated:YES completion:nil];
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
            
        }
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
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

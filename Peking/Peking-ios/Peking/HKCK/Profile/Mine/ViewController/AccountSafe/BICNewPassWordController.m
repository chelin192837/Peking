//
//  BICPassWordController.m
//  Biconome
//
//  Created by a on 2019/9/26.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "BICNewPassWordController.h"
#import "BICNewPassWordView.h"
#import "BICSWViewController.h"
#import "WKWebViewController.h"
@interface BICNewPassWordController ()
@property(nonatomic,strong)BICNewPassWordView *passwordView;

@end

@implementation BICNewPassWordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];
    [self.view addSubview:self.passwordView];
}

-(BICNewPassWordView *)passwordView{
    if(!_passwordView){
        _passwordView=[[BICNewPassWordView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, kScreenHeight-kNavBar_Height)];
        [_passwordView.nextButton addTarget:self action:@selector(requestNext) forControlEvents:UIControlEventTouchUpInside];
    }
    return _passwordView;
}
-(void)requestNext{
    if(self.passwordView.passField.text.length==0 ){
        [BICDeviceManager AlertShowTip:LAN(@"请输入新密码")];
        return;
    }
    if(self.passwordView.confirmField.text.length==0){
       [BICDeviceManager AlertShowTip:LAN(@"请确认密码")];
       return;
    }
    if(![self.passwordView.passField.text isEqualToString:self.passwordView.confirmField.text]){
        [BICDeviceManager AlertShowTip:LAN(@"两次输入密码不一致")];
        return;
    }
    if (![BICDeviceManager passwordVertify:self.passwordView.passField.text])
    {
        [BICDeviceManager AlertShowTip:[BICDeviceManager isOrNoPasswordStyle:self.passwordView.passField.text]];
        return;
    }
    WKWebViewController * wkWeb = [[WKWebViewController alloc] init];
    wkWeb.isWhiteNav = YES;
    wkWeb.successBlock = ^{
    BICSWViewController *vc=[[BICSWViewController alloc] init];
    vc.loginType=LoginRegType_modify;
    self.requestModel.tel=SDUserDefaultsGET(BICMOBILE);
    self.requestModel.code=SDUserDefaultsGET(BICInternationalCode);
    self.requestModel.password=self.passwordView.confirmField.text;
    self.requestModel.internationalCode=SDUserDefaultsGET(BICInternationalCode);
    vc.requsestModel=self.requestModel;
    vc.backFinishItemOperationBlock = ^{
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    };
       [self presentViewController:vc animated:YES completion:nil];
    };
    [self.navigationController pushViewController:wkWeb animated:YES];

}
-(BICRegisterRequest *)requestModel{
    if(!_requestModel){
        _requestModel=[[BICRegisterRequest alloc] init];
    }
    return _requestModel;
}
@end

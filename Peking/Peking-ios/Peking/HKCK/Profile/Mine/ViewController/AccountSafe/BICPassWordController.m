//
//  BICPassWordController.m
//  Biconome
//
//  Created by a on 2019/9/26.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "BICPassWordController.h"
#import "BICPassWordView.h"
#import "BICNewPassWordController.h"
@interface BICPassWordController ()
@property(nonatomic,strong)BICPassWordView *passwordView;
@end

@implementation BICPassWordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];
    [self.view addSubview:self.passwordView];
}

-(BICPassWordView *)passwordView{
    if(!_passwordView){
        _passwordView=[[BICPassWordView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, kScreenHeight-kNavBar_Height)];
        [_passwordView.nextButton addTarget:self action:@selector(requestNext) forControlEvents:UIControlEventTouchUpInside];
    }
    return _passwordView;
}
-(void)requestNext{
    if(self.passwordView.pwdField.text.length==0){
        [BICDeviceManager AlertShowTip:LAN(@"密码不能为空")];
    }else{
        BICRegisterRequest *request = [[BICRegisterRequest alloc] init];
        request.password=self.passwordView.pwdField.text;
        [[BICProfileService sharedInstance] analyticalCheckOriginPass:request serverSuccessResultHandler:^(id response) {
               BICBaseResponse  *responseM = (BICBaseResponse*)response;
               if (responseM.code==200) {
                   BICNewPassWordController *vc=[[BICNewPassWordController alloc] init];
                   vc.requestModel.oldPassword=self.passwordView.pwdField.text;
                   [self.navigationController pushViewController:vc animated:YES];
               }else{
                   [BICDeviceManager AlertShowTip:responseM.msg];
               }
           } failedResultHandler:^(id response) {
            
           } requestErrorHandler:^(id error) {
            
           }];
    }
}
@end

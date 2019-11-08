//
//  BICGoogleCodeCell.m
//  Biconome
//
//  Created by 车林 on 2019/9/4.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICGoogleCodeCell.h"
#import "BICSendRegCodeRequest.h"
#import "BICSWViewController.h"
#import "WKWebViewController.h"
#import "BICProfileService.h"
@interface BICGoogleCodeCell()
@property (weak, nonatomic) IBOutlet UILabel *passwordLab;
@property (weak, nonatomic) IBOutlet UILabel *gooleLab;

@property (weak, nonatomic) IBOutlet UITextField *gooleTex;

@property (weak, nonatomic) IBOutlet UITextField *passwordTex;

@end

@implementation BICGoogleCodeCell


- (IBAction)nextBtn:(id)sender {
    if (![self validate]) {
        return;
    }
    
    [self gooleCodeRequest];
}
-(BOOL)validate
{
    if (self.passwordTex.text.length==0){
        [BICDeviceManager AlertShowTip:LAN(@"密码不能为空")];
        return NO;
    }else if (![BICDeviceManager passwordVertify:self.passwordTex.text])
    {
        [BICDeviceManager AlertShowTip:[BICDeviceManager isOrNoPasswordStyle:self.passwordTex.text]];
        return NO;
    }else if (self.gooleTex.text.length!=6)
    {
        [BICDeviceManager AlertShowTip:LAN(@"谷歌验证码格式错误")];
        return NO;
    }
    return YES;
}


-(void)gooleCodeRequest
{
    WEAK_SELF
    BICRegisterRequest *requsestModel=[[BICRegisterRequest alloc] init];
    requsestModel.googleKey = self.gooleKey;
    requsestModel.googleCode = self.gooleTex.text;
    requsestModel.tel=SDUserDefaultsGET(BICMOBILE);
    requsestModel.password=self.passwordTex.text;
    [[BICProfileService sharedInstance] analyticalBindGoogleData:requsestModel serverSuccessResultHandler:^(id response) {
        BICBaseResponse * responseM  = (BICBaseResponse*)response;
        if (responseM.code == 200) {
            [weakSelf sendCode];
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
        
    } failedResultHandler:^(id response) {
        
    } requestErrorHandler:^(id error) {
        
    }];
}

-(void)sendCode
{
    WKWebViewController * wkWeb = [[WKWebViewController alloc] init];
    wkWeb.isWhiteNav=YES;
    WEAK_SELF
    wkWeb.successBlock = ^{
            BICSWViewController * swViewVC = [[BICSWViewController alloc] initWithNibName:NSStringFromClass([BICSWViewController class]) bundle:nil];
            swViewVC.loginType = LoginRegType_Google;
            BICRegisterRequest * requsetModel = [[BICRegisterRequest alloc] init];
            requsetModel.tel = SDUserDefaultsGET(BICMOBILE);
            requsetModel.internationalCode = SDUserDefaultsGET(BICInternationalCode);
            requsetModel.googleKey = weakSelf.gooleKey;
            requsetModel.googleCode = weakSelf.gooleTex.text;
            requsetModel.password = weakSelf.passwordTex.text;
            swViewVC.requsestModel = requsetModel;
            [weakSelf.yq_viewController presentViewController:swViewVC animated:YES
                             completion:nil];
    };
    
    [self.viewController.navigationController pushViewController:wkWeb animated:YES];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.passwordLab.text = LAN(@"登录密码");
    self.gooleLab.text = LAN(@"谷歌验证码");

    self.gooleTex.placeholder = LAN(@"谷歌验证码");
    self.passwordTex.placeholder = LAN(@"登录密码");

}

+(instancetype)exitWithTableView:(UITableView*)tableView
{
    NSString* cellId = @"BICGoogleCodeCell";
    BICGoogleCodeCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
    }
    return cell;
}
@end

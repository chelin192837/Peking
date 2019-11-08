//
//  BICMineHeadView.m
//  Biconome
//
//  Created by 车林 on 2019/8/31.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICMineHeadView.h"
#import "BICLoginVC.h"
#import "UIImage+GIF.h"

@interface BICMineHeadView()

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *rightArrow;
@property (weak, nonatomic) IBOutlet UIImageView *profile_ripper;

@end

@implementation BICMineHeadView



- (IBAction)btnClick:(id)sender {
    
    if(self.presentItemOperationBlock){
        self.presentItemOperationBlock();
    }
    
    BICLoginVC * loginVC = [[BICLoginVC alloc] initWithNibName:@"BICLoginVC" bundle:nil];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
        
    }];
    
}

-(instancetype)initWithNib
{
    self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
    kADDNSNotificationCenter(NSNotificationCenterProfileHeader);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUI:) name:NSNotificationCenterUpdateUI object:nil];
    
    [self setupUI];
    return self;
}
-(void)updateUI:(NSNotification*)notify
{
    [self setupUI];
}

-(void)notify:(NSNotification*)notify
{
    [self setupUI];
}
-(void)setupUI
{
    NSString* appId = SDUserDefaultsGET(APPID);
    
    if (appId) {  //已经登陆了
        [self.loginBtn setTitle:SDUserDefaultsGET(BICNickName) forState:UIControlStateNormal];
        self.loginBtn.userInteractionEnabled = NO;
        self.titleLab.hidden = YES;
        self.rightArrow.hidden = YES;
    }else{ //还没有登陆
        self.loginBtn.userInteractionEnabled = YES;
        [self.loginBtn setTitle:LAN(@"登录") forState:UIControlStateNormal];
        self.titleLab.text = LAN(@"登录后可享受更多服务");
        self.titleLab.hidden = NO;
        self.rightArrow.hidden = NO;
    }
    
    [self.profile_ripper setImage:[UIImage sd_animatedGIFNamed:@"Profile_wave"]];

        
}
@end

//
//  BICInviteQRVC.m
//  Biconome
//
//  Created by 车林 on 2019/10/9.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICInviteQRVC.h"
#import "BICImageManager.h"
@interface BICInviteQRVC ()

@property (weak, nonatomic) IBOutlet UIImageView *qrCodeImg;

@property (weak, nonatomic) IBOutlet UILabel *registerLab;

@end

@implementation BICInviteQRVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.qrCodeImg.image =[BICImageManager QRTranThoughString:self.qrCode WithSize:200.f];
    
    [self initNavigationTitleViewLabelWithTitle:LAN(@"邀请二维码") titleColor:kBICWhiteColor IfBelongTabbar:NO];
    
    self.registerLab.text = [NSString stringWithFormat:@"%@ Biconomy",LAN(@"注册")];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromContextWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromContextWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
}
@end

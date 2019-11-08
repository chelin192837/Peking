//
//  BICInviteReturnHisVC.m
//  Biconome
//
//  Created by 车林 on 2019/8/21.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICInviteReturnHisView.h"
#import "BICInviteReturnHisVC.h"


@interface BICInviteReturnHisVC ()

@property(nonatomic,strong)BICInviteReturnHisView *mainListView;


@end

@implementation BICInviteReturnHisVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromContextWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];

    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];

    [self initNavigationTitleViewLabelWithTitle:LAN(@"历史记录") titleColor:kNVABICSYSTEMTitleColor IfBelongTabbar:NO];
    
    [self setupUI];
    
}

-(void)setupUI
{
    self.mainListView = [[BICInviteReturnHisView alloc] init];
    [self.view addSubview:self.mainListView];
    [self.mainListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    
    [self.mainListView setUITitleList];
    
    
}

@end


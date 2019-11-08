//
//  BICBasicInfoViewController.m
//  Biconome
//
//  Created by a on 2019/10/5.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "BICAddAddressInfoViewController.h"
#import "BICAddAddressInfoView.h"
@interface BICAddAddressInfoViewController ()
@property(nonatomic,strong)BICAddAddressInfoView *infoView;
@end

@implementation BICAddAddressInfoViewController
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if(self.backReloadOperationBlock){
        self.backReloadOperationBlock();
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];

    [self initNavigationTitleViewLabelWithTitle:LAN(@"住宅信息") titleColor:kNVABICSYSTEMTitleColor IfBelongTabbar:NO];
    
    [self.view addSubview:self.infoView];
}

-(void)setResponse:(BICAuthInfoResponse *)response{
    _response=response;
    self.infoView.response=response;
}
-(BICAddAddressInfoView *)infoView{
    if(!_infoView){
        _infoView=[[BICAddAddressInfoView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-kNavBar_Height)];
    }
    return _infoView;
}


@end

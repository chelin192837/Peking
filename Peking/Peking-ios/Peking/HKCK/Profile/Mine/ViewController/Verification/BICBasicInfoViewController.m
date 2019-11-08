//
//  BICBasicInfoViewController.m
//  Biconome
//
//  Created by a on 2019/10/5.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "BICBasicInfoViewController.h"
#import "BICBasicInfoView.h"
@interface BICBasicInfoViewController ()
@property(nonatomic,strong)BICBasicInfoView *infoView;
@end

@implementation BICBasicInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];

    [self initNavigationTitleViewLabelWithTitle:LAN(@"基本信息") titleColor:kNVABICSYSTEMTitleColor IfBelongTabbar:NO];
    
    [self.view addSubview:self.infoView];
}

-(void)setResponse:(BICAuthInfoResponse *)response{
    _response=response;
    self.infoView.response=response;
}

-(BICBasicInfoView *)infoView{
    if(!_infoView){
        _infoView=[[BICBasicInfoView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-kNavBar_Height)];
    }
    return _infoView;
}
 

@end

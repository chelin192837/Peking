//
//  BICSettingVC.m
//  Biconome
//
//  Created by 车林 on 2019/8/31.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICSettingVC.h"

#import "BICCommonSetVC.h"

#import "BICMineComCell.h"

#import "RSDHomeListWebVC.h"

#import "BICAboutUSVC.h"

#import "AppDelegate.h"
#import "SDArchiverTools.h"
@interface BICSettingVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)NSArray * titleArr;
@property(nonatomic,strong)UIButton * bottomBtn;

@property(nonatomic,strong)UIView * bottomV;
@end

@implementation BICSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBICMainListBGColor;
    
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];
    
    [self setupUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initNavigationTitleViewLabelWithTitle:LAN(@"设置") titleColor:kNVABICSYSTEMTitleColor IfBelongTabbar:NO];
    [self.bottomBtn setTitle:LAN(@"退出登录") forState:UIControlStateNormal];
    NSArray * titleArr = @[LAN(@"通用设置"),LAN(@"关于Biconomy")];
    self.titleArr = titleArr;
    [self.tableView reloadData];
    
    
}

-(void)setupUI
{
    [self initNavigationTitleViewLabelWithTitle:LAN(@"设置") titleColor:kNVABICSYSTEMTitleColor IfBelongTabbar:NO];
    
    NSArray * titleArr = @[LAN(@"通用设置"),LAN(@"关于Biconomy")];
    self.titleArr = titleArr;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 73, 0);     _tableView.backgroundColor=kBICHistoryCellBGColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;

        UIView * bottomV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 56.f+24.f)];
        self.bottomV = bottomV;
        [self.bottomV isYY];
        bottomV.backgroundColor = [UIColor clearColor];
        UIButton * bottomBtn = [[UIButton alloc] initWithFrame:CGRectMake(16,24.f, SCREEN_WIDTH-2*16,56.f)];
        self.bottomBtn = bottomBtn;
        bottomBtn.backgroundColor = kBICWhiteColor;
        bottomBtn.titleLabel.font = [UIFont systemFontOfSize:16.f weight:UIFontWeightMedium];
        [bottomBtn setTitle:LAN(@"退出登录") forState:UIControlStateNormal];
        [bottomBtn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
        [bottomBtn setTitleColor:hexColor(6653FF) forState:UIControlStateNormal];
        bottomBtn.layer.cornerRadius = 8.f;
        bottomBtn.layer.masksToBounds = YES;
        [bottomV addSubview:bottomBtn];
        _tableView.tableFooterView = bottomV;
        
    }
    
    self.bottomV.hidden = ![BICDeviceManager isLogin];

    return _tableView;
}

-(void)logout
{
    BICRegisterRequest * request = [[BICRegisterRequest alloc] init];
    [[BICProfileService sharedInstance] analyticallogoutData:request serverSuccessResultHandler:^(id response) {
        BICBaseResponse * responseM = (BICBaseResponse*)response;
        if(responseM.code==200){

            //清空缓存
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:APPID];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:BICMOBILE];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:BICNickName];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:BICCOINMONEY_];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:BICBindGoogleAuth];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:BICInternationalCode];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:BICInvitationCode];

            
            [SDArchiverTools deleteFileWithFileName:BICWALLETLISTOFMINE filePath:nil];


            //

            [[NSUserDefaults standardUserDefaults] synchronize];
            
            BaseTabBarController *nmTabBarVC = [[BaseTabBarController alloc] init];
            nmTabBarVC.delegate = nmTabBarVC;
            ((AppDelegate*)[UIApplication sharedApplication].delegate).mainController = nmTabBarVC;
            [nmTabBarVC setSelectedIndex:0];
            
            ((AppDelegate*)[UIApplication sharedApplication].delegate).window.rootViewController = nmTabBarVC;
            [((AppDelegate*)[UIApplication sharedApplication].delegate).window makeKeyAndVisible];
//            nmTabBarVC.delegate = (AppDelegate*)[UIApplication sharedApplication].delegate ;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:KUpdate_Token object:nil];
            
            kPOSTNSNotificationCenter(NSNotificationCenterProfileHeader, nil);
            kPOSTNSNotificationCenter(NSNotificationCenterLoginOut, nil);

            
            
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
    } failedResultHandler:^(id response) {
        
    } requestErrorHandler:^(id error) {
        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BICMineComCell * cell = [BICMineComCell exitWithTableView:tableView];

    cell.titleTexLab.text = self.titleArr[indexPath.row];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        
        BICCommonSetVC * commonSet = [[BICCommonSetVC alloc] init];
        
        [self.navigationController pushViewController:commonSet animated:YES];
    }
    
    if (indexPath.row==1) {
        
        BICAboutUSVC * usVC = [[BICAboutUSVC alloc] init];
        [self.navigationController pushViewController:usVC animated:YES];
        
    }

}


@end

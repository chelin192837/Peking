//
//  BICWalletCoinDetailVC.m
//  Biconome
//
//  Created by 车林 on 2019/9/3.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICWalletCoinDetailVC.h"
#import "BICCoinDetailCell.h"
#import "BICCoinDetailBottomView.h"
#import "BICWalletRechargeVC.h"
#import "BICWalletWithdrawVC.h"

@interface BICWalletCoinDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView*tableView;

@end

@implementation BICWalletCoinDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBICMainListBGColor;
    
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];
    
    [self initNavigationTitleViewLabelWithTitle:self.response.tokenSymbol titleColor:kNVABICSYSTEMTitleColor IfBelongTabbar:NO];
    
    [self.view addSubview:self.tableView];
    WEAK_SELF
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view).offset(-(kTabBar_Height+15));
    }];
    
    BICCoinDetailBottomView *bottom = [[BICCoinDetailBottomView alloc] initWithNibRecharge:^{
        BICWalletRechargeVC * rechargeVC = [[BICWalletRechargeVC alloc] init];
        rechargeVC.response = weakSelf.response;
        [weakSelf.navigationController pushViewController:rechargeVC animated:YES];
    } DrawBlock:^{
        BICWalletWithdrawVC * drawVC = [[BICWalletWithdrawVC alloc] init];
        drawVC.response = weakSelf.response;
        [weakSelf.navigationController pushViewController:drawVC animated:YES];
    }];
    [self.view addSubview:bottom];
    [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.view);
        make.height.equalTo(@(kTabBar_Height+15));
    }];
    //提币完成后刷新界面
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(withDrawBackRef:) name:NSNotificationCenterWithDrawBackRefWeb object:nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


//提币刷新 NSNotificationCenterWithDrawBackRefWeb
-(void)withDrawBackRef:(NSNotification *)notify
{
//    BICGetWalletsResponse *res=notify.object;
//    self.response=[res.data objectAtIndex:0];
//    [self.tableView reloadData];
    BICGetWalletsRequest *request = [[BICGetWalletsRequest alloc] init];
    request.walletType = @"CCT";
    [[BICWalletService sharedInstance] analyticalWalletUsergetWalletsNewData:request serverSuccessResultHandler:^(id response) {
        BICGetWalletsResponse  *responseM = (BICGetWalletsResponse*)response;
        if (responseM.code==200) {
            NSArray * arr = responseM.data;
            self.response=[arr objectAtIndex:self.indexRow];
            [self.tableView reloadData];
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
    } failedResultHandler:^(id response) {
    } requestErrorHandler:^(id error) {
    }];
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=kBICHistoryCellBGColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
   
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BICCoinDetailCell * cell = [BICCoinDetailCell exitWithTableView:tableView];
    cell.response = self.response;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 375.f;
}



@end

//
//  BICWSelectCoinTypeVC.m
//  Biconome
//
//  Created by 车林 on 2019/8/31.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICWSelectCoinTypeVC.h"
#import "BICGetWalletsRequest.h"


#import "BICWalSearHeaderView.h"
#import "BICMainWalletCell.h"
#import "BICWalletViewController.h"
@interface BICWSelectCoinTypeVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView*tableView;

@property(nonatomic,strong)BICGetWalletsRequest* request;

@property(nonatomic,strong)BICGetWalletsResponse* response;

@property(nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation BICWSelectCoinTypeVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kBICMainListBGColor;
    
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];
    
    [self initNavigationTitleViewLabelWithTitle:LAN(@"选择币种") titleColor:kNVABICSYSTEMTitleColor IfBelongTabbar:NO];
    
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 52)];
    BICWalSearHeaderView *searchHead = [[NSBundle mainBundle] loadNibNamed:@"BICWalSearHeaderView" owner:nil options:nil][0];
    searchHead.searchLab.text = LAN(@"搜索");
    searchHead.frame=CGRectMake(0, 0, SCREEN_WIDTH, 52);
    [headerView addSubview:searchHead];
    [self.view addSubview:headerView];
    
    [self.view addSubview:self.tableView];
    WEAK_SELF
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.view);
        make.top.equalTo(headerView.mas_bottom).offset(16);
    }];
    
    UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchTap:)];
    [searchHead addGestureRecognizer:tap];
    
    
    CustomGifHeader * header = [CustomGifHeader headerWithRefreshingBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [weakSelf setupData:weakSelf.request];
        });
        
    }];
    self.tableView.mj_header = header;
    
//    [self.tableView.mj_header beginRefreshing];
    [self setupRounteHUD];

}
-(void)setupRounteHUD
{
    [ODAlertViewFactory showLoadingViewWithView:self.view];
    [self setupData:self.request];
}
-(NSMutableArray*)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(void)searchTap:(UITapGestureRecognizer*)tap
{
    BICWalletViewController * walletSearchVC = [[BICWalletViewController alloc] init];
    walletSearchVC.pushType = WalletSearchType_detail;
    walletSearchVC.searchArray = self.dataArray.copy;
    [self.navigationController pushViewController:walletSearchVC animated:YES];
}
-(void)setupData:(BICGetWalletsRequest*)request
{
    WEAK_SELF
    [[BICWalletService sharedInstance] analyticalWalletUsergetWalletsNewData:request serverSuccessResultHandler:^(id response) {
        BICGetWalletsResponse  *responseM = (BICGetWalletsResponse*)response;
        if (responseM.code==200) {
            [weakSelf.dataArray removeAllObjects];
            [weakSelf.dataArray addObjectsFromArray:responseM.data];
            weakSelf.dataArray.count == 0 ? [weakSelf setupNoDataOfSearch:weakSelf.tableView] : [weakSelf hideNoDataOfSearch];
            weakSelf.dataArray.count == 0 ? [weakSelf.tableView.mj_footer setHidden:YES] : [weakSelf.tableView.mj_footer setHidden:NO];
            [weakSelf.tableView reloadData];
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
        [ODAlertViewFactory hideAllHud:weakSelf.view];
        [weakSelf.tableView.mj_header endRefreshing];
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
        [weakSelf.tableView.mj_header endRefreshing];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
        [weakSelf.tableView.mj_header endRefreshing];
        
    }];
}
//-(void)setupData:(BICGetWalletsRequest*)request
//{
//    [[BICWalletService sharedInstance] analyticalWalletUsergetWalletsData:request serverSuccessResultHandler:^(id response) {
//        BICGetWalletsResponse  *responseM = (BICGetWalletsResponse*)response;
//        if (responseM.code==200) {
//            NSArray * arr = responseM.data;
//            for (GetWalletsResponse* model in arr) {
//                model.walletGasType = @"BTC";
//            }
//            [self.dataArray addObjectsFromArray:arr];
//
//            [self setupDataETC:request];
//        }else{
//            [BICDeviceManager AlertShowTip:responseM.msg];
//            [self.tableView.mj_header endRefreshing];
//        }
//    } failedResultHandler:^(id response) {
//        [self.tableView.mj_header endRefreshing];
//
//    } requestErrorHandler:^(id error) {
//        [self.tableView.mj_header endRefreshing];
//
//    }];
//}
//
//-(void)setupDataETC:(BICGetWalletsRequest*)request
//{
//    [[BICWalletService sharedInstance] analyticalWalletUsergetWallets8201Data:request serverSuccessResultHandler:^(id response) {
//        BICGetWalletsResponse  *responseM = (BICGetWalletsResponse*)response;
//        if (responseM.code==200) {
//            NSArray * arr = responseM.data;
//            for (GetWalletsResponse* model in arr) {
//                model.walletGasType = @"ETH";
//            }
//            [self.dataArray addObjectsFromArray:arr];
//             self.dataArray.count == 0 ? [self setupNoDataOfSearch:self.tableView] : [self hideNoDataOfSearch];
//                         self.dataArray.count == 0 ? [self.tableView.mj_footer setHidden:YES] : [self.tableView.mj_footer setHidden:NO];
//            [self.tableView reloadData];
//        }else{
//            [BICDeviceManager AlertShowTip:responseM.msg];
//        }
//        [self.tableView.mj_header endRefreshing];
//    } failedResultHandler:^(id response) {
//        [self.tableView.mj_header endRefreshing];
//
//    } requestErrorHandler:^(id error) {
//        [self.tableView.mj_header endRefreshing];
//
//    }];
//}
-(BICGetWalletsRequest*)request
{
    if (!_request) {
        _request = [[BICGetWalletsRequest alloc] init];
    }
    _request.walletType = @"CCT";
    return _request;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=kBICHistoryCellBGColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BICMainWalletCell * cell = [BICMainWalletCell exitWithTableView:tableView];
    
    cell.response = self.dataArray[indexPath.row];
    
    cell.balanceLab.hidden = YES;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 68.f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GetWalletsResponse * response = self.dataArray[indexPath.row];
    
    if (self.selectBlock) {
        self.selectBlock(response);
    }
    [self.navigationController popViewControllerAnimated:YES];
}



@end

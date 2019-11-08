//
//  BICOrderDealVC.m
//  Biconome
//
//  Created by 车林 on 2019/8/23.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICOrderDealVC.h"


#import "BICEXCMainCell.h"

#import "BICListUserRequest.h"

#import "BICListUserResponse.h"
#import "BICHistoryDeleCell.h"

#import "BICDealListByUserResponse.h"
#import "BICDealListByUserRequest.h"
#import "BICOrderDealCell.h"
#import "BICHistoryDeleStopCell.h"

@interface BICOrderDealVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)BICDealListByUserRequest* request;
@property(nonatomic,strong)BICDealListByUserResponse* response;
@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation BICOrderDealVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WEAK_SELF
    self.view.backgroundColor = kBICHistoryCellBGColor;
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];
    [self initNavigationTitleViewLabelWithTitle:LAN(@"成交") titleColor:kNVABICSYSTEMTitleColor IfBelongTabbar:NO];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).offset(kBICMargin);
    }];
    CustomGifHeader * header = [CustomGifHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.request.pageNum=1;
            [weakSelf setupData:weakSelf.request];
        });
    }];
    self.tableView.mj_header = header;
    MJRefreshAutoNormalFooter*footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.request.pageNum++;
        [weakSelf setupData:weakSelf.request];
    }];
    self.tableView.mj_footer = footer;
    
    self.tableView.mj_footer.hidden = YES;

//    [self.tableView.mj_header beginRefreshing];
    [self setupRounteHUD];

}
-(void)setupRounteHUD
{
    [ODAlertViewFactory showLoadingViewWithView:self.view];
    self.request.pageNum=1;
    [self setupData:self.request];
}
-(NSMutableArray*)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(void)setupData:(BICDealListByUserRequest*)request
{
    WEAK_SELF
    [[BICOrderDelegateService sharedInstance] analyticalDealListByUserData:request serverSuccessResultHandler:^(id response) {
        weakSelf.response = (BICDealListByUserResponse*)response;
        if (request.pageNum==1) {
            [weakSelf.dataArray removeAllObjects];
        }
        if (weakSelf.response.data) {
            [weakSelf.dataArray addObjectsFromArray:weakSelf.response.data.rows];
        }
        weakSelf.dataArray.count == 0 ? [weakSelf setupNoDataOfSearch:weakSelf.tableView] : [weakSelf hideNoDataOfSearch];
             weakSelf.dataArray.count == 0 ? [weakSelf.tableView.mj_footer setHidden:YES] : [weakSelf.tableView.mj_footer setHidden:NO];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
        if(weakSelf.response.data.rows.count==0){
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [weakSelf.tableView.mj_footer endRefreshing];
        }
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } failedResultHandler:^(id response) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } requestErrorHandler:^(id error) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    }];
    
    
}

-(BICDealListByUserRequest*)request
{
    if (!_request) {
        _request = [[BICDealListByUserRequest alloc] init];
    }
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
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    BICOrderDealCell * cell = [BICOrderDealCell exitWithTableView:tableView];
    cell.response = self.dataArray[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 164.f;
}

@end

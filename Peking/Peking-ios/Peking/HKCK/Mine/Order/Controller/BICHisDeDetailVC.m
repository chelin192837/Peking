//
//  BICHisDeDetailVC.m
//  Biconome
//
//  Created by 车林 on 2019/8/29.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICHisDeDetailVC.h"
#import "BICHisDetailCell.h"
#import "BICHisDelTopView.h"
#import "BICListDetailByOrderIdRequest.h"
#import "BICListDetailByOrderIdResponse.h"

@interface BICHisDeDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView*tableView;

@property(nonatomic,strong)BICHisDelTopView *delTopView;

@property(nonatomic,strong)BICListDetailByOrderIdRequest* request;

@property(nonatomic,strong)BICListDetailByOrderIdResponse* response;

@property(nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation BICHisDeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = kBICHistoryCellBGColor;
    
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];
    
    [self initNavigationTitleViewLabelWithTitle:LAN(@"详情") titleColor:kNVABICSYSTEMTitleColor IfBelongTabbar:NO];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
    
    WEAK_SELF
    CustomGifHeader * header = [CustomGifHeader headerWithRefreshingBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            weakSelf.request.pageNum=1;
            weakSelf.request.orderId = weakSelf.orderId;
            [weakSelf setupData:self.request];
            
        });
        
    }];
    self.tableView.mj_header = header;
    
    MJRefreshAutoNormalFooter*footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        weakSelf.request.pageNum++;
        weakSelf.request.orderId = weakSelf.orderId;
        [weakSelf setupData:self.request];
    }];
    
    self.tableView.mj_footer = footer;
    
//    [self.tableView.mj_header beginRefreshing];
    
    [self setupRounteHUD];

}
-(void)setupRounteHUD
{
    [ODAlertViewFactory showLoadingViewWithView:self.view];
                self.request.pageNum=1;
    self.request.orderId = self.orderId;
    [self setupData:self.request];
}
-(NSMutableArray*)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(void)setupData:(BICListDetailByOrderIdRequest*)request
{
    WEAK_SELF
    [[BICOrderDelegateService sharedInstance] analyticalListDetailByOrderId:request serverSuccessResultHandler:^(id response) {
        weakSelf.response = (BICListDetailByOrderIdResponse*)response;
        if (request.pageNum==1) {
            [weakSelf.dataArray removeAllObjects];
        }
        
            if (weakSelf.response.data) {
                [weakSelf.dataArray addObjectsFromArray:weakSelf.response.data];
            }
        [weakSelf.tableView reloadData];
        weakSelf.delTopView.response = weakSelf.model;
        [weakSelf.tableView.mj_header endRefreshing];
        if(weakSelf.response.data.count==0){
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

-(BICListDetailByOrderIdRequest*)request
{
    if (!_request) {
        _request = [[BICListDetailByOrderIdRequest alloc] init];
    }
    return _request;
}

-(BICHisDelTopView *)delTopView
{
    if (!_delTopView) {
        _delTopView = [[BICHisDelTopView alloc] initWithNib];
        _delTopView.width=SCREEN_WIDTH;
    }
    return _delTopView;
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
        _tableView.tableHeaderView = self.delTopView;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BICHisDetailCell * cell = [BICHisDetailCell exitWithTableView:tableView];
    cell.headerResponse=self.model;
    cell.response = self.dataArray[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 231.f;
}



@end

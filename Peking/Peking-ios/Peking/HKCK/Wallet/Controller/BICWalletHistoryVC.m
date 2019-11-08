//
//  BICWalletHistoryVC.m
//  Biconome
//
//  Created by 车林 on 2019/8/23.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICWalletHistoryVC.h"
#import "BICEXCMainCell.h"
#import "BICListUserRequest.h"
#import "BICListUserResponse.h"
#import "BICHistoryDeleCell.h"
#import "BICDealListByUserResponse.h"
#import "BICDealListByUserRequest.h"
#import "BICOrderDealCell.h"
#import "BICWalletHistoryCell.h"
#import "BICpcGetTransferInOutRequest.h"
#import "BICpcGetTransferInOutResponse.h"
#import "BICHistoryDietaiVC.h"
@interface BICWalletHistoryVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableView;

@property(nonatomic,strong)BICpcGetTransferInOutRequest* request;

@property(nonatomic,strong)BICpcGetTransferInOutResponse* response;

@property(nonatomic,strong)NSMutableArray * dataArray;

@property(nonatomic,strong)NSString* transferTypeStr;

@end

@implementation BICWalletHistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kBICHistoryCellBGColor;
    
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];
    
    [self initNavigationTitleViewLabelWithTitle:LAN(@"历史") titleColor:kNVABICSYSTEMTitleColor IfBelongTabbar:NO];
    
    [self.view addSubview:self.tableView];
    
    WEAK_SELF
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).offset(kBICMargin);
    }];
    
    
    CustomGifHeader * header = [CustomGifHeader headerWithRefreshingBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            weakSelf.request.pageNum = 1;
            weakSelf.request.walletType = @"CCT";
            //            self.request.transferType = self.transferTypeStr;
            [weakSelf setupData:weakSelf.request];
        });
        
    }];
    self.tableView.mj_header = header;
    
    MJRefreshAutoNormalFooter*footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        weakSelf.request.pageNum++;
        //        self.request.transferType = self.transferTypeStr;
        [weakSelf setupData:weakSelf.request];
    }];
    
    self.tableView.mj_footer = footer;
    
//    [self.tableView.mj_header beginRefreshing];
    [self setupRounteHUD];
    
}
-(void)setTransferType:(TRANSFER_TYPE)transferType
{
    if (transferType==TRANSFER_TYPE_ALL) {
        self.transferTypeStr = @"";
    }else if(transferType==TRANSFER_TYPE_IN)
    {
        self.transferTypeStr = @"IN";
    }else if (transferType==TRANSFER_TYPE_OUT)
    {
        self.transferTypeStr = @"OUT";
    }
}
-(void)setupRounteHUD
{
    [ODAlertViewFactory showLoadingViewWithView:self.view];
    self.request.pageNum = 1;
    self.request.walletType = @"CCT";
    //self.request.transferType = self.transferTypeStr;
    [self setupData:self.request];
}
-(NSMutableArray*)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(void)setupData:(BICpcGetTransferInOutRequest*)request
{
    WEAK_SELF
    [[BICWalletService sharedInstance] analyticalPcGetTransferInOutData:request serverSuccessResultHandler:^(id response) {
        weakSelf.response = (BICpcGetTransferInOutResponse*)response;
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

-(BICpcGetTransferInOutRequest*)request
{
    if (!_request) {
        _request = [[BICpcGetTransferInOutRequest alloc] init];
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
    
    BICWalletHistoryCell * cell = [BICWalletHistoryCell exitWithTableView:tableView];
    
    cell.response = self.dataArray[indexPath.row];
    WEAK_SELF
    cell.cancelClickItemOperationBlock = ^{
        GetTransferInOutResponse * res=weakSelf.dataArray[indexPath.row];
        res.status=@"8";
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        res.createTime=[UtilsManager getUTCDateFormateLocalDate:[format stringFromDate:[NSDate date]]];
        [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    };
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 112.f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BICHistoryDietaiVC * detail = [[BICHistoryDietaiVC alloc] init];
    GetTransferInOutResponse *response = self.dataArray[indexPath.row];
    detail.response=response;
    [self.navigationController pushViewController:detail animated:YES];
}

@end

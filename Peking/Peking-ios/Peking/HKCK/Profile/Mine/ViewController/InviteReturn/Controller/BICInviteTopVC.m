//
//  BICInviteTopVC.m
//  Biconome
//
//  Created by 车林 on 2019/8/10.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICInviteTopVC.h"

#import "SDArchiverTools.h"

#import "BICReturnHisCell.h"
#import "BICInviteHisCell.h"
#import "BICInviteTopCell.h"
#import "BICInvitationInfoResponse.h"


@interface BICInviteTopVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property (nonatomic, strong) BICPageRequest * pageRequest;

@property(nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation BICInviteTopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBICMainListBGColor;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self.view);
    }];
    
    [self addRefresh];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}
-(NSMutableArray*)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(void)analyticalData:(BICPageRequest*)request
{
    WEAK_SELF
    [[BICProfileService sharedInstance] analytiRankInfo:request serverSuccessResultHandler:^(id response) {
        BICInvitationInfoResponse * responseM = (BICInvitationInfoResponse*)response;
        
        if (request.pageNum==1) {
            [weakSelf.dataArray removeAllObjects];
        }
        [weakSelf.dataArray addObjectsFromArray:responseM.data.rows];
        
        [weakSelf sortArray];
        
        weakSelf.dataArray.count==0 ? [weakSelf setupNoDataOfSearchBiconome:weakSelf.tableView With:((weakSelf.tableView.height-160)/2-20)]: [weakSelf hideNoDataOfSearchBiconome];
        weakSelf.dataArray.count == 0 ? [weakSelf.tableView.mj_footer setHidden:YES] : [weakSelf.tableView.mj_footer setHidden:NO];

        [weakSelf.tableView reloadData];
        
        [weakSelf.tableView.mj_header endRefreshing];
        if(responseM.data.rows.count==0){
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
-(void)sortArray
{
    for (int i=0; i<self.dataArray.count; i++) {
        InvitationInfo* model = self.dataArray[i];
        model.index = i+1;
    }
}
-(BICPageRequest*)pageRequest
{
    if (!_pageRequest) {
        _pageRequest = [[BICPageRequest alloc] init];
        _pageRequest.pageNum = 1;
    }
    return _pageRequest;
}

-(void)addRefresh{
    
    WEAK_SELF
    CustomGifHeader * header = [CustomGifHeader headerWithRefreshingBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.pageRequest.pageNum=1;
            [weakSelf analyticalData:weakSelf.pageRequest];
        });
        
    }];
    
    self.tableView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.pageRequest.pageNum++;
        [weakSelf analyticalData:weakSelf.pageRequest];
        
    }];
    self.tableView.mj_footer = footer;
    
    
//    [self.tableView.mj_header beginRefreshing];
    [self setupRounteHUD];

}

-(void)setupRounteHUD
{
    [ODAlertViewFactory showLoadingViewWithView:self.view];
    self.pageRequest.pageNum=1;
    [self analyticalData:self.pageRequest];
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor=[UIColor clearColor];
        _tableView.contentInset = UIEdgeInsetsMake(4,0,0, 0);
        
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BICInviteTopCell *cell = [BICInviteTopCell exitWithTableView:tableView];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88.f;
}

@end

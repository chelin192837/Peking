//
//  BICEXCNavigationVC.m
//  Biconome
//
//  Created by 车林 on 2019/8/10.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICEXCNavigationVC.h"
#import "BICEXCNavigationCell.h"
#import "BICTopListPageResponse.h"
#import "SDArchiverTools.h"
#import "BICSockJSRouter.h"
#import "BICCoinAndUnitResponse.h"
#import "BICMarketGetResponse.h"
#import "BICGetCoinPairConfigResponse.h"
@interface BICEXCNavigationVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property (nonatomic, strong) BICGetTopListRequest * topListRequest;

@property (nonatomic, strong) BICGetTopListResponse * topListResponse;

@property(nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation BICEXCNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self addRefresh];

    [self analyticalData];
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
-(void)analyticalData
{
    self.topListRequest.currency = self.currency;
//    [self.tableView.mj_header beginRefreshing];
    [self setupRounteHUD];

}
-(void)setupRounteHUD
{
    [ODAlertViewFactory showLoadingViewWithView:self.view];
    self.topListRequest.pageNum=1;
    self.topListRequest.currency = self.currency;
    [self setupMarketRefresh:self.topListRequest];
}
-(BICGetTopListRequest*)topListRequest
{
    if (!_topListRequest) {
        _topListRequest = [[BICGetTopListRequest alloc] init];
        _topListRequest.pageNum = 1;
    }
    return _topListRequest;
}
//行情页的列表
-(void)setupDataGetTopList:(BICGetTopListRequest*)request
{
    WEAK_SELF
    [[BICMarketService sharedInstance] analyticalgetTopListPageData:request serverSuccessResultHandler:^(id response) {
        BICTopListPageResponse * responseM = (BICTopListPageResponse*)response;
        if (request.pageNum==1) {
            [weakSelf.dataArray removeAllObjects];
        }
        [weakSelf.dataArray addObjectsFromArray:responseM.data.rows];
                
        weakSelf.dataArray.count==0 ? [weakSelf setupNoDataOfSearchBiconome:weakSelf.tableView With:((302-160)/2-20)]: [weakSelf hideNoDataOfSearchBiconome];
        
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
-(void)setupMarketRefresh:(BICGetTopListRequest*)request
{
    [self setupDataGetTopList:request];
}

-(void)addRefresh{
    
    WEAK_SELF
    CustomGifHeader * header = [CustomGifHeader headerWithRefreshingBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.topListRequest.pageNum=1;
            weakSelf.topListRequest.currency = weakSelf.currency;
            [weakSelf setupMarketRefresh:weakSelf.topListRequest];
        });
        
    }];
    
    self.tableView.mj_header = header;
    
    MJRefreshAutoFooter *footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        self.topListRequest.pageNum++;
        self.topListRequest.currency = self.currency;
        [self setupMarketRefresh:self.topListRequest];
        
    }];
    self.tableView.mj_footer = footer;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor=kBICWhiteColor;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BICEXCNavigationCell * cell = [BICEXCNavigationCell cellWithTableView:tableView];
    
    cell.model=self.dataArray[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    getTopListResponse *model = self.dataArray[indexPath.row];
    NSArray * arr = [model.currencyPair componentsSeparatedByString:@"-"];
    SDUserDefaultsSET(arr, BICEXCChangeCoinPair);
    
    //优化发通知 调用多次 进行一次缓存 其他地方直接调用 后接socket
//    kPOSTNSNotificationCenter(NSNotificationCenterCoinTransactionPair, self.dataArray[indexPath.row]);
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenterCoinTransactionPairNav object:nil];
    
    [self requestAndCacheData:model];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[BICSockJSRouter shareInstance] SockJSGlobeReStart];
    });
    
}


-(void)requestAndCacheData:(getTopListResponse *)model{
        //第一步创建队列
        dispatch_queue_t customQuue = dispatch_queue_create("com.manman.network", DISPATCH_QUEUE_CONCURRENT);
        //第二步创建组
        dispatch_group_t customGroup = dispatch_group_create();

        //第三步添加任务
        dispatch_group_async(customGroup, customQuue, ^{
            [self setupEntrustData:model group:customGroup];
        });

        dispatch_group_async(customGroup, customQuue, ^{
            [self setupSaleBuyData:customGroup];
        });
      
        dispatch_group_async(customGroup, customQuue, ^{
            [self loadBiTopMarketData:customGroup];
        });
       
        dispatch_group_async(customGroup, customQuue, ^{
            [self analyticalGetCoinByCurrencyPairData:customGroup];
        });
        
        //第四步通知
        dispatch_group_notify(customGroup, dispatch_get_main_queue(), ^{
            NSLog(@"任务完成");
            kPOSTNSNotificationCenter(NSNotificationCenterCoinTransactionPair, model);
        });
}

//请求委托信息
-(void)setupEntrustData:(getTopListResponse *)model group:(dispatch_group_t)group
{
    if (![BICDeviceManager isLogin]) {
        return;
    }
    dispatch_group_enter(group);
    NSArray * array = [model.currencyPair componentsSeparatedByString:@"-"];
    BICListUserRequest *request=[[BICListUserRequest alloc] init];
    request.coinName = [array objectAtIndex:0];
    request.unitName = [array objectAtIndex:1];
    request.pageNum=1;
    [[BICExchangeService sharedInstance] analyticalPCListUserOrderData:request serverSuccessResultHandler:^(id response) {
        BICListUserResponse *res = (BICListUserResponse*)response;
        NSMutableArray *dataArray = [NSMutableArray array];
        if (res.data) {
            [dataArray addObjectsFromArray:res.data.rows];
        }
        [SDArchiverTools archiverObject:dataArray ByKey:[NSString stringWithFormat:@"%@%@%@",BICCURRENTENTRUSTMESS,request.coinName,request.unitName]];
        dispatch_group_leave(group);
    } failedResultHandler:^(id response) {
        dispatch_group_leave(group);
    } requestErrorHandler:^(id error) {
        dispatch_group_leave(group);
    }];
}

//盘口信息
-(void)setupSaleBuyData:(dispatch_group_t)group
{
    dispatch_group_enter(group);
    BICLimitMarketRequest * request = [[BICLimitMarketRequest alloc] init];
    request.coinName = [BICDeviceManager GetPairCoinName];
    request.unitName = [BICDeviceManager GetPairUnitName];
    [[BICExchangeService sharedInstance] analyticalListOrderByCoinAndUnitData:request serverSuccessResultHandler:^(id response) {
        BICCoinAndUnitResponse *responseM = (BICCoinAndUnitResponse*)response;
        kPOSTNSNotificationCenter(NSNotificationCenterBICChangeSocketView, responseM);
//        [SDArchiverTools archiverObject:responseM ByKey:[NSString stringWithFormat:@"%@%@%@",BICCURRENPOSITIONMESS,request.coinName,request.unitName]];
        dispatch_group_leave(group);
    } failedResultHandler:^(id response) {
        dispatch_group_leave(group);
    } requestErrorHandler:^(id error) {
        dispatch_group_leave(group);
    }];
}

//请求交易对最新信息
- (void)loadBiTopMarketData:(dispatch_group_t)group
{
    dispatch_group_enter(group);
    BICKLineRequest * request = [[BICKLineRequest alloc] init];
    request.currencyPair = [NSString stringWithFormat:@"%@-%@",[BICDeviceManager GetPairCoinName],[BICDeviceManager GetPairUnitName]];
    [[BICExchangeService sharedInstance] analyticalMarketGetData:request serverSuccessResultHandler:^(id response) {
        BICMarketGetResponse * responseM =(BICMarketGetResponse*)response;
        [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenterMarketGet object:responseM];
//        [SDArchiverTools archiverObject:responseM ByKey:[NSString stringWithFormat:@"%@%@%@",BICCURRENTRSACTIONMESS,[BICDeviceManager GetPairCoinName],[BICDeviceManager GetPairUnitName]]];
        dispatch_group_leave(group);
    } failedResultHandler:^(id response) {
        dispatch_group_leave(group);
    } requestErrorHandler:^(id error) {
        dispatch_group_leave(group);
    }];
}

//请求币对配置信息
-(void)analyticalGetCoinByCurrencyPairData:(dispatch_group_t)group
{
    dispatch_group_enter(group);
    BICLimitMarketRequest * request = [[BICLimitMarketRequest alloc] init];
    request.coinName = [BICDeviceManager GetPairCoinName];
    request.unitName = [BICDeviceManager GetPairUnitName];
    [[BICExchangeService sharedInstance] analyticalGetCoinByCurrencyPairData:request serverSuccessResultHandler:^(id response) {
        BICGetCoinPairConfigResponse * responseM = (BICGetCoinPairConfigResponse*)response;
        kPOSTNSNotificationCenter(NSNotificationCenterBICChangePriceConfig, responseM);
//        [SDArchiverTools archiverObject:responseM ByKey:[NSString stringWithFormat:@"%@%@%@",BICCURRCONFIGMESS,[BICDeviceManager GetPairCoinName],[BICDeviceManager GetPairUnitName]]];
        dispatch_group_leave(group);
    } failedResultHandler:^(id response) {
        dispatch_group_leave(group);
    } requestErrorHandler:^(id error) {
        dispatch_group_leave(group);
    }];
    
    
    
}
@end

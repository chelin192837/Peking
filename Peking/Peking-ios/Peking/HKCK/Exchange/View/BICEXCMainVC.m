//
//  BICEXCMainVC.m
//  Biconome
//
//  Created by 车林 on 2019/8/23.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICEXCMainVC.h"
#import "BICEXCMiddenView.h"
#import "BICEXCMiddenCell.h"
#import "BICEXCMainCell.h"

#import "BICListUserRequest.h"
#import "BICListUserResponse.h"

#import "BICCoinAndUnitResponse.h"
#import "BICMarketGetResponse.h"

#import "BICGetCoinPairConfigResponse.h"
#import "BICMineOrderDeleVC.h"
#import "SDArchiverTools.h"
#import "BICSockJSRouter.h"
#import "BICEXCMainStopCell.h"
@interface BICEXCMainVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property(nonatomic,strong)UITableView*tableView;

@property(nonatomic,strong)BICEXCMiddenView* headerView;

@property(nonatomic,strong)BICListUserRequest* request;

@property(nonatomic,strong)BICListUserResponse* response;

@property(nonatomic,strong)getTopListResponse *topListResponse;

@property(nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation BICEXCMainVC


-(instancetype)init
{
    if (self = [super init]) {
        
        RSDLog(@"BICEXCMainVC__%@",self);
        
          //未登录-去登录成功回来启动当前委托socket
          [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessHandle) name:NSNotificationCenterLoginSucceed object:nil];
           
          //已登录-直接启动当前委托socket
          [self loginSuccessHandle];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBICMainListBGColor;
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    WEAK_SELF
    CustomGifHeader * header = [CustomGifHeader headerWithRefreshingBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            if([BICDeviceManager isLogin])
            {
                        weakSelf.request.pageNum=1;
            //            weakSelf.request.orderType = [weakSelf getPulishTypeStr:weakSelf.priceType];
            //            weakSelf.request.type = [weakSelf getOrderTypeStr:weakSelf.orderType];
                        [weakSelf setupData:weakSelf.request];
            }else{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.tableView.mj_header endRefreshing];
                });
            }
            
            

        });
        
    }];
    self.tableView.mj_header = header;
    
    
    MJRefreshAutoNormalFooter*footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{

        if([BICDeviceManager isLogin])
        {
            weakSelf.request.pageNum++;
            [weakSelf setupData:weakSelf.request];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
    }];
    
    self.tableView.mj_footer = footer;
    
    [self setupRounteHUD];

    
    kADDNSNotificationCenter(NSNotificationCenterCoinTransactionPair);
  
  
    
    //取消委托刷新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshDele:) name:NSNotificationCenterCurrentDelegateNotify object:nil];
    
    [self setupSaleBuyData];
    [self loadBiTopMarketData];
    [self analyticalGetCoinByCurrencyPairData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}



-(void)loginSuccessHandle{
    if ([BICDeviceManager isLogin]) {
        //启动当前委托socket当前委托
        [[BICSockJSRouter shareInstance] SockJSCurrentEntrustStart];
        
        //添加注册之前i移除
        [[NSNotificationCenter defaultCenter] removeObserver:self name:NSNotificationCenterCurrentEntrust object:nil];
        
         //添加 当前委托通知
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CurrentEntrustNotify:) name:NSNotificationCenterCurrentEntrust object:nil];
        
        
        [self setupRounteHUD];
    }
}

-(void)refreshDele:(NSNotification*)notify
{
    //又下拉刷新会有问题
    self.request.pageNum=1;
    [self setupData:self.request];
}

-(void)setupRounteHUD
{
//    [ODAlertViewFactory showLoadingViewWithView:self.view];
    if ([BICDeviceManager isLogin]) {
         self.request.pageNum=1;
        [self setupData:self.request];
    }else{
        [self.tableView reloadData];
    }

}
-(NSString*)getPulishTypeStr:(ChangePriceType)type
{
    if (type==ChangePriceType_Buy) {
        return @"BUY";
    }
    if (type==ChangePriceType_Sale) {
        return @"SELL";
    }
    return @"";
}
-(NSString*)getOrderTypeStr:(ChangeOrderType)type
{
    if (type==ChangeOrderType_Market) {
        return @"MARKET";

    }
    if (type==ChangeOrderType_Limit) {
        return @"LIMIT";
    }
    return @"";
}
-(NSMutableArray*)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(void)setPriceType:(ChangePriceType)priceType
{
    _priceType = priceType;
}

//请求委托信息
-(void)setupData:(BICListUserRequest*)request
{
    
    WEAK_SELF
    [[BICExchangeService sharedInstance] analyticalPCListUserOrderData:request serverSuccessResultHandler:^(id response) {
        weakSelf.response = (BICListUserResponse*)response;
        if (request.pageNum==1) {
            [weakSelf.dataArray removeAllObjects];
        }
        if (weakSelf.response.data) {
            [weakSelf.dataArray addObjectsFromArray:weakSelf.response.data.rows];
        }

        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
        if(weakSelf.response.data.rows.count>0){
            [weakSelf.tableView.mj_footer endRefreshing];
        }else{
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}
//当前委托通知
-(void)CurrentEntrustNotify:(NSNotification*)notify{
    ListUserRowsResponse *rowRes = notify.object;
    
        //更新数据
        for(int j=0;j<self.dataArray.count;j++){
            ListUserRowsResponse *currentRowRes=[self.dataArray objectAtIndex:j];
            if([currentRowRes.id isEqualToString:rowRes.id]){
                NSMutableArray *mutabArray=[self.dataArray mutableCopy];
                if([rowRes.lastNum doubleValue]==0){
                    [mutabArray removeObjectAtIndex:j];
                }else{
                    [mutabArray replaceObjectAtIndex:j withObject:rowRes];
                }
                self.dataArray=mutabArray;
                break;
            }
        }
        //更新cell
        for(int t=0;t<self.tableView.visibleCells.count;t++){
            UITableViewCell *cell=[self.tableView.visibleCells objectAtIndex:t];
            if([cell isKindOfClass:[BICEXCMainStopCell class]]){
                BICEXCMainStopCell *exccell=(BICEXCMainStopCell *)cell;
                if([exccell.response.id isEqualToString:rowRes.id]){
                    if([rowRes.lastNum doubleValue]==0){
//                        [self.tableView deleteRowsAtIndexPaths:@[[self.tableView indexPathForCell:cell]] withRowAnimation:UITableViewRowAnimationLeft];
                        [self.tableView reloadData];
                    }else{
                        exccell.response=rowRes;
                    }
                    break;
                }
            }
            if([cell isKindOfClass:[BICEXCMainCell class]]){
               BICEXCMainCell *exccell=(BICEXCMainCell *)cell;
               if([exccell.response.id isEqualToString:rowRes.id]){
                   if([rowRes.lastNum doubleValue]==0){
//                       [self.tableView deleteRowsAtIndexPaths:@[[self.tableView indexPathForCell:cell]] withRowAnimation:UITableViewRowAnimationLeft];
                       [self.tableView reloadData];
                   }else{
                       exccell.response=rowRes;
                   }
                   break;
               }
            }
    }
}

//切换币对通知
-(void)notify:(NSNotification*)notify
{
    self.topListResponse = notify.object;
    NSArray * arr;
    if (self.topListResponse) {
        arr=[self.topListResponse.currencyPair componentsSeparatedByString:@"-"];
    }
    if (arr.count>1) {
        self.request.coinName = arr[0];
        self.request.unitName = arr[1];
    }
//    [self.tableView.mj_header beginRefreshing];
    //请求数组后通知刷新数据
    [self notifySetupData];
    [self notifySetupSaleBuyData];
    [self notifyLoadBiTopMarketData];
    [self nofifyAnalyticalGetCoinByCurrencyPairData];
    
//    [self setupSaleBuyData];
//    [self loadBiTopMarketData];
//    [self analyticalGetCoinByCurrencyPairData];
}

//委托信息
-(void)notifySetupData{
    self.dataArray=[SDArchiverTools unarchiverObjectByKey:[NSString stringWithFormat:@"%@%@%@",BICCURRENTENTRUSTMESS,self.request.coinName,self.request.unitName]];
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
}
//盘口信息
-(void)notifySetupSaleBuyData
{
//    BICCoinAndUnitResponse *responseM = [SDArchiverTools unarchiverObjectByKey:[NSString stringWithFormat:@"%@%@%@",BICCURRENPOSITIONMESS,self.request.coinName,self.request.unitName]];;
//    kPOSTNSNotificationCenter(NSNotificationCenterBICChangeSocketView, responseM);
}
//请求交易对最新信息
- (void)notifyLoadBiTopMarketData
{
//    BICMarketGetResponse * responseM =[SDArchiverTools unarchiverObjectByKey:[NSString stringWithFormat:@"%@%@%@",BICCURRENTRSACTIONMESS,self.request.coinName,self.request.unitName]];;
//    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenterMarketGet object:responseM];
    
}
//请求币对配置信息
-(void)nofifyAnalyticalGetCoinByCurrencyPairData
{
//    BICGetCoinPairConfigResponse * responseM = [SDArchiverTools unarchiverObjectByKey:[NSString stringWithFormat:@"%@%@%@",BICCURRCONFIGMESS,self.request.coinName,self.request.unitName]];;
//    kPOSTNSNotificationCenter(NSNotificationCenterBICChangePriceConfig, responseM);
}
//请求币对配置信息
-(void)analyticalGetCoinByCurrencyPairData
{
    BICLimitMarketRequest * request = [[BICLimitMarketRequest alloc] init];
    request.coinName = [BICDeviceManager GetPairCoinName];
    request.unitName = [BICDeviceManager GetPairUnitName];
   
    [[BICExchangeService sharedInstance] analyticalGetCoinByCurrencyPairData:request serverSuccessResultHandler:^(id response) {
                
        BICGetCoinPairConfigResponse * responseM = (BICGetCoinPairConfigResponse*)response;
        
        kPOSTNSNotificationCenter(NSNotificationCenterBICChangePriceConfig, responseM);

        
    } failedResultHandler:^(id response) {
        
        
    } requestErrorHandler:^(id error) {
        
        
    }];
}
//盘口
-(void)setupSaleBuyData
{
    BICLimitMarketRequest * request = [[BICLimitMarketRequest alloc] init];
    request.coinName = [BICDeviceManager GetPairCoinName];
    request.unitName = [BICDeviceManager GetPairUnitName];
    
    [[BICExchangeService sharedInstance] analyticalListOrderByCoinAndUnitData:request serverSuccessResultHandler:^(id response) {
        BICCoinAndUnitResponse *responseM = (BICCoinAndUnitResponse*)response;
        kPOSTNSNotificationCenter(NSNotificationCenterBICChangeSocketView, responseM);
        
    } failedResultHandler:^(id response) {
        
    } requestErrorHandler:^(id error) {
        
    }];
}

//请求交易对最新信息
- (void)loadBiTopMarketData
{
    BICKLineRequest * request = [[BICKLineRequest alloc] init];
    request.currencyPair = [NSString stringWithFormat:@"%@-%@",[BICDeviceManager GetPairCoinName],[BICDeviceManager GetPairUnitName]];
    [[BICExchangeService sharedInstance] analyticalMarketGetData:request serverSuccessResultHandler:^(id response) {
        
        BICMarketGetResponse * responseM =(BICMarketGetResponse*)response;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenterMarketGet object:responseM];
        
    } failedResultHandler:^(id response) {
        
    } requestErrorHandler:^(id error) {
        
    }];
    
}


-(BICListUserRequest*)request
{
    if (!_request) {
        _request = [[BICListUserRequest alloc] init];
        _request.coinName = @"BTC";
        _request.unitName = @"USDT";
    }
    return _request;
}
-(BICEXCMiddenView*)headerView
{
    if (!_headerView) {
        _headerView = [[BICEXCMiddenView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 397) With:_priceType OrderType:_orderType];
    }
    return _headerView;
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=[UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.tableHeaderView = self.headerView;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0,kTabBar_Height+20, 0);
        _tableView.showsVerticalScrollIndicator = NO;
        self.headerView.vc = self;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataArray.count==0) {
        return 2;
    }
    return self.dataArray.count+1;
}
-(void)setupRefresh
{
//    [self.tableView.mj_header beginRefreshing];
    [self setupRounteHUD];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell * celled = [tableView dequeueReusableCellWithIdentifier:@"cell__"];
    if (!celled) {
        celled = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell__"];
        celled.selectionStyle = UITableViewCellSelectionStyleNone;
        celled.backgroundColor = kBICMainListBGColor;
    }
    
    
    if (indexPath.row==0) {
        
        BICEXCMiddenCell *cell = [BICEXCMiddenCell exitWithTableView:tableView];
        return cell;
        
    }
    if (self.dataArray.count==0) {
        
        UIView * bgView = [[UIView alloc] init];
        bgView.backgroundColor =kBICWhiteColor;
        bgView.layer.cornerRadius = 8.f;
        [bgView isYY];
//        bgView.layer.masksToBounds = YES;
        [celled addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(celled).offset(kBICMargin);
            make.right.equalTo(celled).offset(-kBICMargin);
            make.top.equalTo(celled);
            make.height.equalTo(@280);
        }];
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"list_null"];
        [bgView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@160);
            make.top.equalTo(bgView).offset(60);
            make.centerX.equalTo(celled);
        }];
        
        return celled;
    }
    
    ListUserRowsResponse * responseM =[self.dataArray objectAtIndex:indexPath.row-1];
    
    if ([responseM.publishType isEqualToString:@"STOP"]) {
            BICEXCMainStopCell * cell = [BICEXCMainStopCell exitWithTableView:tableView];
            cell.response = self.dataArray[indexPath.row-1];
            WEAK_SELF
            cell.cancelBlock = ^(ListUserRowsResponse * _Nonnull response) {
                [weakSelf.dataArray removeObject:response];
                [weakSelf.tableView reloadData];
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:ISNeedUpdateExchangeView];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                
                [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenterCurrentDelegateNotify object:nil];

            };
            return cell;
    }
    
        BICEXCMainCell * cell = [BICEXCMainCell exitWithTableView:tableView];
        cell.response = self.dataArray[indexPath.row-1];
        WEAK_SELF
        cell.cancelBlock = ^(ListUserRowsResponse * _Nonnull response) {
            [weakSelf.dataArray removeObject:response];
            [weakSelf.tableView reloadData];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:ISNeedUpdateExchangeView];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenterCurrentDelegateNotify object:nil];

        };
        return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 60.f;
    }
    if (self.dataArray.count==0) {
        return 280.f+12;
    }
    if (indexPath.row>0) {
        ListUserRowsResponse * responseM = self.dataArray[indexPath.row-1];
        if ([responseM.publishType isEqualToString:@"STOP"]) {
            return 143.f;
        }
    }
    return 123.f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        if (![BICDeviceManager isLogin]) {
            [BICDeviceManager PushToLoginView];
            return;
        }
        kPOSTNSNotificationCenter(NSNotificationCenterOpenOrdersToAll, nil);
    }
    if (self.dataArray.count==0) {
        if (indexPath.row==1) {
            return;
        }
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView                                               // any offset changes
{
        
    kPOSTNSNotificationCenter(NSNotificationCenterExchangeScrollerToNav, @(scrollView.contentOffset.y));

}


@end

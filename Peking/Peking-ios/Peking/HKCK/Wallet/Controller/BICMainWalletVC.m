//
//  BICMainWalletVC.m
//  Biconome
//
//  Created by 车林 on 2019/8/23.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICMainWalletVC.h"

#import "BICEXCMainCell.h"

#import "BICListUserRequest.h"

#import "BICListUserResponse.h"

#import "BICWASearchHeaderView.h"

#import "BICMainWaHeader.h"

#import "BICMainWalletCell.h"

#import "BICGetWalletsRequest.h"

#import "BICWalletHistoryVC.h"

#import "BICWalletViewController.h"

#import "BICWalletRechargeVC.h"

#import "BICWalletWithdrawVC.h"

#import "BICWalletCoinDetailVC.h"

#import "SDArchiverTools.h"

#import "BICGetWalletsResponse.h"

#import "BICMarketGetResponse.h"

@interface BICMainWalletVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView*tableView;

@property(nonatomic,strong) BICGetWalletsRequest* request;

@property(nonatomic,strong) BICGetWalletsResponse* response;

@property(nonatomic,strong) BICMainWaHeader *waHeader;

@property(nonatomic,strong) NSMutableArray * dataArray;

@property(nonatomic,strong) NSArray* array;


@end

@implementation BICMainWalletVC
 
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = kBICHistoryCellBGColor;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateRate:) name:NSNotificationCenterBICRateConfig object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSucceed:) name:NSNotificationCenterLoginSucceed object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginOut:) name:NSNotificationCenterLoginOut object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBalance:) name:NSNotificationCenterWallectUpdate object:nil];

    BICWASearchHeaderView *nav = [[BICWASearchHeaderView alloc] initWithNib:^{
        if (![BICDeviceManager isLogin]) {
            [BICDeviceManager PushToLoginView];
            return;
        }
        BICWalletViewController * walletSearchVC = [[BICWalletViewController alloc] init];
        walletSearchVC.pushType = WalletSearchType_wallet;
        walletSearchVC.searchArray = self.dataArray.copy;
        [self.navigationController pushViewController:walletSearchVC animated:YES];
    } RightBlock:^{
        if (![BICDeviceManager isLogin]) {
            [BICDeviceManager PushToLoginView];
            return;
        }
        BICWalletHistoryVC * historyVC = [[BICWalletHistoryVC alloc] init];
        historyVC.transferType = TRANSFER_TYPE_ALL;
        [self.navigationController pushViewController:historyVC animated:YES];
    }];
    nav.frame=CGRectMake(0, 0, SCREEN_WIDTH, kNavBar_Height);
    [self.view addSubview:nav];

    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(kNavBar_Height);
    }];
    
//    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 197)];
//    [headerView addSubview:self.waHeader];
//    self.tableView.tableHeaderView = headerView;
        
    WEAK_SELF
    CustomGifHeader * header = [CustomGifHeader headerWithRefreshingBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [weakSelf.waHeader updateTopUI];
            if ([BICDeviceManager isLogin]) {
                if([BICDeviceManager GetBICToUSDT]==0)
                   {
                    [self loadBiTopMarketData];
                }
                [weakSelf setupData:self.request];
             
            }else{
                [self constructorData];
                [self.tableView reloadData];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.tableView.mj_header endRefreshing];
                });
            }
        
        });
        
    }];
    self.tableView.mj_header = header;
    
//    [self.tableView.mj_header beginRefreshing];
    [self setupRounteHUD];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    if([[[NSUserDefaults standardUserDefaults] objectForKey:ISNeedUpdateExchangeView] boolValue]){
        [self setupRounteHUD];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:ISNeedUpdateExchangeView];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}
-(void)setupRounteHUD
{
    [ODAlertViewFactory showLoadingViewWithView:self.view];
    [self.waHeader updateTopUI];
    if ([BICDeviceManager isLogin]) {
        if([BICDeviceManager GetBICToUSDT]==0)
           {
            [self loadBiTopMarketData];
        }
        [self setupData:self.request];
        
    }else{
        [self constructorData];
        [self.tableView reloadData];
        WEAK_SELF
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [ODAlertViewFactory hideAllHud:weakSelf.view];
        });
    }
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    if(self.dataArray.count>0){
//        return self.waHeader;
//    }else{
//        UIView * view = [UIView new];
//        view.backgroundColor = [UIColor clearColor];
//        return view;
//    }
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 197;
//}

-(void)loginSucceed:(NSNotification*)notify
{
//    [self.tableView.mj_header beginRefreshing];
    [self setupRounteHUD];

}
-(void)loginOut:(NSNotification*)notify
{
//    [self.tableView.mj_header beginRefreshing];
    [self setupRounteHUD];

}
-(void)updateRate:(NSNotification*)notify
{
//    [self.tableView.mj_header beginRefreshing];
    [self setupRounteHUD];

}

-(BICMainWaHeader*)waHeader
{
    if (!_waHeader) {
        _waHeader = [[BICMainWaHeader alloc] initWithNib:^{
            BICWalletRechargeVC * recharge = [[BICWalletRechargeVC alloc] init];
            [self.navigationController pushViewController:recharge animated:YES];
        } RightBlock:^{
           
            BICWalletWithdrawVC * recharge = [[BICWalletWithdrawVC alloc] init];
            
            [self.navigationController pushViewController:recharge animated:YES];
            
        }];
        _waHeader.frame=CGRectMake(0, 0, SCREEN_WIDTH, 197);
    }
    return _waHeader;
}


-(NSMutableArray*)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(void)constructorData
{
    NSArray * titleArr = @[@"BTC",@"USDT",@"ETH"];
    NSArray * logoArr = @[@"currency/btc.png",@"currency/usdt.png",@"currency/eth.png"];
    [self.dataArray removeAllObjects];
    for (int i=0; i<titleArr.count; i++) {
        GetWalletsResponse * model = [[GetWalletsResponse alloc] init];
        model.tokenSymbol = titleArr[i];
        model.balance = @"0.00000000";
        model.logoAddr = logoArr[i];
        [self.dataArray addObject:model];
    }
}
-(void)setupData:(BICGetWalletsRequest*)request
{
    WEAK_SELF
    [[BICWalletService sharedInstance] analyticalWalletUsergetWalletsNewData:request serverSuccessResultHandler:^(id response) {
        BICGetWalletsResponse  *responseM = (BICGetWalletsResponse*)response;
        if (responseM.code==200) {
            [weakSelf.dataArray removeAllObjects];
            NSArray * arr = responseM.data;
             [weakSelf.dataArray addObjectsFromArray:arr];
             if(weakSelf.dataArray.count==0)
               {
                  [weakSelf constructorData];
                  [weakSelf.tableView reloadData];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf.tableView.mj_header endRefreshing];
                   });
               }else{
                    [weakSelf setHeaderData:weakSelf.dataArray];
                    [weakSelf.tableView reloadData];
               }
//             self.dataArray.count == 0 ? [self setupNoDataOfSearch:self.tableView] : [self hideNoDataOfSearch];
     
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
        [ODAlertViewFactory hideAllHud:weakSelf.view];
        [weakSelf.tableView.mj_header endRefreshing];
    } failedResultHandler:^(id response) {
        [weakSelf.tableView.mj_header endRefreshing];

    } requestErrorHandler:^(id error) {
        [weakSelf.tableView.mj_header endRefreshing];

    }];
}

//-(void)setupData:(BICGetWalletsRequest*)request
//{
//    [[BICWalletService sharedInstance] analyticalWalletUsergetWalletsData:request serverSuccessResultHandler:^(id response) {
//        BICGetWalletsResponse  *responseM = (BICGetWalletsResponse*)response;
//        if (responseM.code==200) {
//            [self.dataArray removeAllObjects];
//            NSArray * arr = responseM.data;
//            for (GetWalletsResponse* model in arr) {
//                model.walletGasType = @"BTC";
//            }
//            [self.dataArray addObjectsFromArray:arr];
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
//            self.dataArray.count == 0 ? [self setupNoDataOfSearch:self.tableView] : [self hideNoDataOfSearch];
//
//            [self.tableView reloadData];
//        }else{
//            [BICDeviceManager AlertShowTip:responseM.msg];
//        }
//        [self setHeaderData:self.dataArray.copy];
//        [self.tableView.mj_header endRefreshing];
//    } failedResultHandler:^(id response) {
//        [self.tableView.mj_header endRefreshing];
//
//    } requestErrorHandler:^(id error) {
//        [self.tableView.mj_header endRefreshing];
//
//    }];
//}

-(void)setHeaderData:(NSArray*)array
{
    _array = array;
    
    double btcValue = 0.f;
    double balance = 0.f;
    if (array.count>0) {
        for (int i=0; i<array.count; i++) {
            GetWalletsResponse * wallet = array[i];
            btcValue = btcValue+wallet.btcValue.doubleValue;
            
            // balance = balance+wallet.balance.floatValue;
        }
        //计算 BTC 对 美元或者人民币
        balance = [BICDeviceManager GetBICToUSDT]*btcValue;
        
        SDUserDefaultsSET(@(btcValue), BICWalletBtcValue);

       double num = [BICDeviceManager GetUSDTToYuan];
        if ([[BICDeviceManager getCurrentRate] isEqualToString:@"CNY"]) {
            balance = balance * num;
        }

        NSArray* arr = @[
                         [NSString stringWithFormat:@"%.8lf",btcValue],
                         [NSString stringWithFormat:@"%.2f",balance]
                         ];
        self.waHeader.arrValue = arr;
        
        [SDArchiverTools archiverObject:array ByKey:BICWALLETLISTOFMINE];
        
        kPOSTNSNotificationCenter(NSNotificationCenterBICWalletList, nil);

    }

}
-(void)updateBalance:(NSNotification*)notify
{
    
        double btcValue = [BICDeviceManager GetWalletBtcValue];
        double balance = [BICDeviceManager GetBICToUSDT]*btcValue;
           
        RSDLog(@"--btcValue---%lf",btcValue);

          double num = [BICDeviceManager GetUSDTToYuan];
           if ([[BICDeviceManager getCurrentRate] isEqualToString:@"CNY"]) {
               balance = balance * num;
           }

           NSArray* arr = @[
                            [NSString stringWithFormat:@"%.8lf",btcValue],
                            [NSString stringWithFormat:@"%.2f",balance]
                            ];
           self.waHeader.arrValue = arr;
}
//请求交易对最新信息
- (void)loadBiTopMarketData
{
    BICKLineRequest * request = [[BICKLineRequest alloc] init];
    request.currencyPair = @"BTC-USDT";
    [[BICExchangeService sharedInstance] analyticalMarketGetData:request serverSuccessResultHandler:^(id response) {
        
        BICMarketGetResponse * responseM =(BICMarketGetResponse*)response;
        
        SDUserDefaultsSET(@(responseM.data.cnyAmount.doubleValue), BICUSDTYANG);
        
        SDUserDefaultsSET(@(responseM.data.amount.doubleValue), BICBTCTOUSDT);
     
         [self setHeaderData:_array];
        
    } failedResultHandler:^(id response) {
        
    } requestErrorHandler:^(id error) {
        
    }];
    
}

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
        _tableView.backgroundColor=[UIColor clearColor];
//        _tableView.backgroundColor=kBICWhiteColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;

    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.dataArray.count>0){
        return self.dataArray.count+1;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row==0) {
      NSString * cellId = @"cell__";
      UITableViewCell * celled = [tableView dequeueReusableCellWithIdentifier:cellId];
      if (!celled) {
        celled = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
          celled.backgroundColor = [UIColor clearColor];
          celled.selectionStyle = UITableViewCellSelectionStyleNone;
      }
        [celled addSubview:self.waHeader];
        [self.waHeader mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(celled);
        }];
        return celled;
    }
    BICMainWalletCell * cell = [BICMainWalletCell exitWithTableView:tableView];
    cell.response = self.dataArray[indexPath.row-1];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 197.f;
    }
    return 68.f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![BICDeviceManager isLogin]) {
        [BICDeviceManager PushToLoginView];
        return;
    }
    if (indexPath.row==0) {
        return;
    }
    
    BICWalletCoinDetailVC * vc = [[BICWalletCoinDetailVC alloc] init];
    
    GetWalletsResponse* response = self.dataArray[indexPath.row-1];
    vc.indexRow=(int)indexPath.row;
    vc.response = response;
    
    [self.navigationController pushViewController:vc animated:YES];

}


@end

//
//  BICExchangeVC.m
//  Biconome
//
//  Created by 车林 on 2019/8/23.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICExchangeVC.h"
#import "BICExchangeListView.h"
#import "BICExcMainListView.h"
#import "BICEXCNavigation.h"
#import "BICNavCointListView.h"
#import "BICNavMainView.h"
#import "BTStockChartViewController.h"
#import "BICLimitMarketRequest.h"
#import "BICCoinAndUnitResponse.h"
#import "BICMarketGetResponse.h"
#import "BICMineOrderDeleVC.h"

#define MainListHeight SCREEN_HEIGHT - kNavBar_Height - kTabBar_Height

@interface BICExchangeVC ()

@property(nonatomic,strong)BICExcMainListView* mainListView;

@property(nonatomic,strong)BICMainCurrencyResponse * resopnseM;

@property(nonatomic,strong)BICEXCNavigation * nav;

@end

@implementation BICExchangeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBICWhiteColor;
    
//    [self initNavigationTitleViewLabelWithTitle:LAN(@"交易") titleColor:kNVABICSYSTEMTitleColor IfBelongTabbar:NO];

    [self setupUI];
    
    kADDNSNotificationCenter(NSNotificationCenterOpenOrdersToAll);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUI:) name:NSNotificationCenterUpdateUI object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollToNav:) name:NSNotificationCenterExchangeScrollerToNav object:nil];

}
-(void)scrollToNav:(NSNotification*)notify
{
    NSNumber * off_Y = notify.object;
    CGFloat offY = [off_Y floatValue];
    
    if ( offY < 44+20) {
        [self.nav mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(-offY);
        }];
        self.nav.alpha = (64 - offY) / 64.f ;
    }else{
//        self.nav.alpha = 0.f ;
    }
    
    [self.view layoutIfNeeded];
}
-(void)updateUI:(NSNotification*)notify
{
    [self setupUI];
}

//请求行情
-(void)setupDataGetHomeList
{
    BICBaseRequest * request = [[BICBaseRequest alloc] init];
    [[BICMarketService sharedInstance] analyticalgetQuoteCurrencyData:request serverSuccessResultHandler:^(id response) {
        self.resopnseM = (BICMainCurrencyResponse*)response;
        
    } failedResultHandler:^(id response) {
        
    } requestErrorHandler:^(id error) {
        
    }];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self loadBiTopMarketData];
    [self.navigationController.navigationBar setHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}
-(void)setupUI
{
    
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    [self setupDataGetHomeList];

    WEAK_SELF
    BICEXCNavigation * nav = [[BICEXCNavigation alloc] initWithNibTitleBlock:^{
        
        [[BICNavMainView sharedInstance] show:weakSelf.resopnseM SuperView:self];
        
    } RightBlock:^{
      
        BTStockChartViewController * stockChart = [[BTStockChartViewController alloc] init];
        getTopListResponse * model = [[getTopListResponse alloc] init];
        model.currencyPair = [NSString stringWithFormat:@"%@-%@",[BICDeviceManager GetPairCoinName],[BICDeviceManager GetPairUnitName]];
        stockChart.model = model;
         [weakSelf.navigationController pushViewController:stockChart animated:YES];
   
    }];
    self.nav = nav;
    [self.view addSubview:nav];
    [nav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@(kNavBar_Height));
    }];
    
    self.mainListView = [[BICExcMainListView alloc] init];
    [self.view addSubview:self.mainListView];
    [self.mainListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(nav.mas_bottom);
        
//        make.bottom.equalTo(self.view);
        make.height.equalTo(@(MainListHeight+60));
    }];
    
    [self.mainListView setUITitleList];
    
    
}


-(void)notify:(NSNotification*)notify
{
    BICMineOrderDeleVC * deleVC = [[BICMineOrderDeleVC alloc] init];
    
    [self.navigationController pushViewController:deleVC animated:YES];
    
}





@end

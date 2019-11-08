//
//  BICMarketMainVC.m
//  Biconome
//
//  Created by 车林 on 2019/8/21.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICMarketMainVC.h"
#import "BICMarketListView.h"
#import "BICMSearchHeaderView.h"
#import "BICMainCurrencyResponse.h"
#import "BICMarketViewController.h"
#import "BTStockChartViewController.h"

@interface BICMarketMainVC ()

@property(nonatomic,strong)BICMarketListView *mainListView;

@property(nonatomic,strong)BICMSearchHeaderView* headV;


@end

@implementation BICMarketMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUI) name:NSNotificationCenterUpdateUI object:nil];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToKline:) name:NSNotificationCenterkLinePushIMP object:nil];

    [self setupUI];

}
-(void)pushToKline:(NSNotification*)notify
{
    NSDictionary * dic = notify.object;
    if (dic) {
        if ([[dic allKeys] containsObject:@(100)]) {
            getTopListResponse * model = dic[@(100)];
            BTStockChartViewController * stockChart = [[BTStockChartViewController alloc] init];
            stockChart.model = model;
            [self.navigationController pushViewController:stockChart animated:YES];
        }
    }
}

-(void)updateUI
{
    self.headV.searchLab.text = LAN(@"搜索");
    
}
-(void)setupUI
{
    BICMSearchHeaderView* headV = [[NSBundle mainBundle] loadNibNamed:@"BICMSearchHeaderView" owner:nil options:nil][0];
    self.headV=headV;
    headV.searchLab.text = LAN(@"搜索");
    headV.frame=CGRectMake(0, 0, SCREEN_WIDTH, kNavBar_Height);
    [self.view addSubview:headV];
    UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headTap:)];
    [headV addGestureRecognizer:tap];
    
    self.mainListView = [[BICMarketListView alloc] init];
    
    [self.view addSubview:self.mainListView];
    [self.mainListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(headV.mas_bottom);
    }];
    
    [self.mainListView setUITitleList:nil];

    [self setupDataGetHomeList];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}
-(void)headTap:(UITapGestureRecognizer*)tap
{
    BICMarketViewController * marketVC = [[BICMarketViewController alloc] init];
    [self.navigationController pushViewController:marketVC animated:YES];
}
-(void)setupDataGetHomeList
{
    BICBaseRequest * request = [[BICBaseRequest alloc] init];
    [[BICMarketService sharedInstance] analyticalgetQuoteCurrencyData:request serverSuccessResultHandler:^(id response) {
        BICMainCurrencyResponse * resopnseM = (BICMainCurrencyResponse*)response;
        
        [self.mainListView setUITitleList:resopnseM];
        
        
    } failedResultHandler:^(id response) {
        
    } requestErrorHandler:^(id error) {
        
    }];
    
}
@end

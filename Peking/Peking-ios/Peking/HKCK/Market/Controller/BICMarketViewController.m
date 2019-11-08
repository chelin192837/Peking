//
//  BICBICMarketViewController.m
//  Biconome
//
//  Created by 车林 on 2019/8/20.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICMarketViewController.h"
#import "BICSearchNavigation.h"
#import "BICSearchBtcCell.h"

#import "BICSearchCurrencyRequest.h"
#import "BICMainCurrencyResponse.h"
#import "BTStockChartViewController.h"
@interface BICMarketViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) BICSearchNavigation * searchHeader;

@property(nonatomic,strong) UITableView*tableView;

@property(nonatomic,strong) BICSearchCurrencyRequest*request;

@property(nonatomic,strong) BICMainCurrencyResponse * response;


@end

@implementation BICMarketViewController

 
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kBICWhiteColor;
    
    WEAK_SELF
    BICSearchNavigation * searchNav = [[BICSearchNavigation alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kNavBar_Height) WithName:LAN(@"搜索") WithBeginSearch:^{
        
    } WithSearchResult:^(NSString * _Nonnull str) {
        weakSelf.tableView.hidden = NO;
        
        NSLog(@"---%@",str);
        if (str.length>0) {
            
            weakSelf.request.currency = str;
            [weakSelf setupData:weakSelf.request];
        }
    } WithCancel:^{
        [weakSelf.navigationController.navigationBar setHidden:NO];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } WithType:SRARCH_NAV_WHITE WithSuperView:weakSelf];
    
    [self.view addSubview:searchNav];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.view);
        make.top.equalTo(searchNav.mas_bottom);
    }];
    
    self.tableView.hidden = YES;
    
}


-(BICSearchCurrencyRequest*)request
{
    if (!_request) {
        _request = [[BICSearchCurrencyRequest alloc] init];
    }
    return _request;
}
-(void)setupData:(BICSearchCurrencyRequest*)requset
{
    WEAK_SELF
    [[BICMarketService sharedInstance] analyticalSearchCurrencyData:requset serverSuccessResultHandler:^(id response) {
        BICMainCurrencyResponse * responseM = (BICMainCurrencyResponse*)response;
        weakSelf.response = responseM;
        weakSelf.response.data.count == 0 ? [weakSelf setupNoDataOfSearch:weakSelf.tableView] : [weakSelf hideNoDataOfSearch];
        [weakSelf.tableView reloadData];
    } failedResultHandler:^(id response) {
        
    } requestErrorHandler:^(id error) {
        
    }];
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=kBICWhiteColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _tableView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.response.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BICSearchBtcCell * cell = [BICSearchBtcCell cellWithTableView:tableView];
    NSString* str = self.response.data[indexPath.row];
    cell.titleLab.text = [str stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self writeToFile:self.response.data[indexPath.row]];
    getTopListResponse * model = [[getTopListResponse alloc] init];
    model.currencyPair = self.response.data[indexPath.row];
    BTStockChartViewController * stockChart = [[BTStockChartViewController alloc] init];
    stockChart.model = model;
    [self.navigationController pushViewController:stockChart animated:YES];
}
#pragma mark -- 写入历史记录
- (void)writeToFile:(NSString*)str
{
    NSString* filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask ,YES).firstObject;
    
    NSString * fileName = [filePath stringByAppendingPathComponent:kHistoryName];
    
    NSArray * arr =  [NSKeyedUnarchiver unarchiveObjectWithFile:fileName]; ;
    
    NSMutableArray * historyArray = [NSMutableArray arrayWithArray:arr];
    
    if ([arr containsObject:str]) {
        [historyArray removeObject:str];
    }
    
    [historyArray addObject:str];
    
    if (historyArray.count > 9) {
        
        [historyArray removeObject:historyArray.firstObject];
    }
    
    [NSKeyedArchiver archiveRootObject:historyArray toFile:fileName];
    
}


@end

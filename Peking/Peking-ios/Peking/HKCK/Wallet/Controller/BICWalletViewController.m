//
//  BICBICWalletViewController.m
//  Biconome
//
//  Created by 车林 on 2019/8/20.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICWalletViewController.h"
#import "BICSearchNavigation.h"
#import "BICSearchBtcCell.h"

#import "BICSearchCurrencyRequest.h"
#import "BICMainCurrencyResponse.h"
#import "BICMainWalletCell.h"

#import "BICGetWalletsResponse.h"
#import "BICWalletRechargeVC.h"
#import "BICWalletWithdrawVC.h"
#import "BICWalletCoinDetailVC.h"
@interface BICWalletViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) BICSearchNavigation * searchHeader;

@property(nonatomic,strong) UITableView*tableView;

@property(nonatomic,strong) BICMainCurrencyResponse * response;

@property(nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation BICWalletViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kBICWhiteColor;
    
    WEAK_SELF
    BICSearchNavigation * searchNav = [[BICSearchNavigation alloc] initNoHisWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kNavBar_Height) WithName:LAN(@"搜索") WithBeginSearch:^{
        
    } WithSearchResult:^(NSString * _Nonnull str) {
        weakSelf.tableView.hidden = NO;
        
        //        NSLog(@"---%@",str);
        if (str.length>0) {
            
            [weakSelf setupData:str];
            
        }
    } WithCancel:^{
        [weakSelf.navigationController setNavigationBarHidden:NO animated:NO];;
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
-(NSMutableArray*)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(void)setupData:(NSString*)requset
{
    [self.dataArray removeAllObjects];
    for (GetWalletsResponse* response in self.searchArray) {
        if ([response.tokenSymbol containsString:requset] || [response.tokenSymbol containsString:requset.uppercaseString]) {
            [self.dataArray addObject:response];
        }
    }
    self.dataArray.count == 0 ? [self setupNoDataOfSearch:self.tableView] : [self hideNoDataOfSearch];
    
    [self.tableView reloadData];
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
        _tableView.contentInset=UIEdgeInsetsMake(kBICMargin,0, 0, 0);
    }
    return _tableView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BICMainWalletCell * cell = [BICMainWalletCell exitWithTableView:tableView];
    
    cell.response = self.dataArray[indexPath.row];
    
    cell.balanceLab.hidden = YES ;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GetWalletsResponse* response  = self.dataArray[indexPath.row];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenterSelectCoinToDrawRecharge object:response];
    
    if (self.pushType==WalletSearchType_wallet) {
        
        BICWalletCoinDetailVC * vc = [[BICWalletCoinDetailVC alloc] init];
        
        vc.response = response;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (self.pushType==WalletSearchType_detail) {
        for (UIViewController*vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[BICWalletRechargeVC class]] ||
                [vc isKindOfClass:[BICWalletWithdrawVC class]]) {
                [self.navigationController popToViewController:vc animated:YES];
            }
        }
        
    }
}

@end

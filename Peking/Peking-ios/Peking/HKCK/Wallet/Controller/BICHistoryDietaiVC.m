//
//  BICHistoryDietaiVC.m
//  Biconome
//
//  Created by 车林 on 2019/9/3.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICHistoryDietaiVC.h"
#import "BICRechargeDetailBottomView.h"
#import "BICWalletRechargeVC.h"
#import "BICWalletWithdrawVC.h"
#import "BICRechargeDetailCell.h"
#import "RSDHomeListWebVC.h"

#define ETH_ADD @"https://etherscan.io/tx/"
#define BTC_ADD @"https://www.blockchain.com/btc/address/"

@interface BICHistoryDietaiVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView*tableView;

@end

@implementation BICHistoryDietaiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBICMainListBGColor;
    
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];
    NSString * titleStr = @"";
    if ([self.response.transferType isEqualToString:@"IN"]) {
        titleStr = LAN(@"充值");
    }
    if ([self.response.transferType isEqualToString:@"OUT"]) {
        titleStr = LAN(@"提币");
    }
    
    [self initNavigationTitleViewLabelWithTitle:[NSString stringWithFormat:@"%@%@",titleStr,self.response.tokenSymbol] titleColor:kNVABICSYSTEMTitleColor IfBelongTabbar:NO];
    
    [self.view addSubview:self.tableView];
    WEAK_SELF
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view).offset(-kNavBar_Height);
    }];
    
    BICRechargeDetailBottomView *bottom = [[BICRechargeDetailBottomView alloc] initWithNibRecharge:^{
        if (weakSelf.response.khash) {
            [BICDeviceManager pasteboard:weakSelf.response.khash];
            [BICDeviceManager AlertShowTip:LAN(@"复制成功")];
        }else{
//            [ODAlertViewFactory showToastWithMessage:@"无效链接"];
            [BICDeviceManager AlertShowTip:LAN(@"无效链接")];
        }
    } DrawBlock:^{
        RSDHomeListWebVC * webVC = [[RSDHomeListWebVC alloc] init];
        
        if ([weakSelf.response.transferType isEqualToString:@"IN"]) {
            
        }
        if ([weakSelf.response.transferType isEqualToString:@"OUT"]) {
            
        }
        
        NSString * baseUrl = @"";
        if ([weakSelf.response.gasTokenSymbol isEqualToString:@"ETH"]) {
            baseUrl = @"https://etherscan.io/tx/";
        }
        //omni -->btc
        if ([weakSelf.response.gasTokenSymbol isEqualToString:@"BTC"]) {
            baseUrl = @"https://btc.com/";
        }
        
        if ([weakSelf.response.gasTokenSymbol isEqualToString:@"USDT"]) {
            
            if([weakSelf.response.chainType isEqualToString:@"omni"]){
                baseUrl = @"https://btc.com/";
            }else{
                baseUrl = @"https://etherscan.io/tx/";
            }
                   
        }
        if(weakSelf.response.khash){
            webVC.listWebStr = [NSString stringWithFormat:@"%@%@",baseUrl,weakSelf.response.khash];
            [weakSelf.navigationController pushViewController:webVC animated:YES];
        }else{
//            [ODAlertViewFactory showToastWithMessage:@"无效链接"];
            [BICDeviceManager AlertShowTip:LAN(@"无效链接")];
        }
        
    }];
    if(!weakSelf.response.khash){
        bottom.hidden=YES;
    }
    [self.view addSubview:bottom];
    [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.tableView.mas_bottom);
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BICRechargeDetailCell * cell = [BICRechargeDetailCell exitWithTableView:tableView];
    cell.response = self.response;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 644.f-44.f;
}



@end

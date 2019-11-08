//
//  BICWalletWithdrawVC.m
//  Biconome
//
//  Created by 车林 on 2019/8/31.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICWalletWithdrawVC.h"

#import "BICSelectCoinVC.h"
#import "BICWalletDrawNumCell.h"
#import "BICWalletDrawTypeCell.h"


#import "BICWSelectCoinTypeVC.h"

#import "BICGetCurrencyConfigRequest.h"
#import "BICGetCurrencyConfigResponse.h"
#import "BICPauseRechargeCell.h"
#import "BICWalletHistoryVC.h"

#import "BICGetGasConfigResponse.h"
#import "BICGetOutQuotaResponse.h"


@interface BICWalletWithdrawVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableView;



@end

@implementation BICWalletWithdrawVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];
    
    [self initNavigationTitleViewLabelWithTitle:LAN(@"提币") titleColor:kNVABICSYSTEMTitleColor IfBelongTabbar:NO];
    
    [self initNavigationRightButtonWithTitle:LAN(@"历史") titileColor:kNVABICSYSTEMTitleColor];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getDataResponseNoti:) name:NSNotificationCenterSelectCoinToDrawRecharge object:nil];

    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];
    
}
-(void)doRightBtnAction
{
    BICWalletHistoryVC * historyVC = [[BICWalletHistoryVC alloc] init];
    historyVC.transferType = TRANSFER_TYPE_OUT;
    [self.navigationController pushViewController:historyVC animated:YES];
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
//查询币种是否允许充值、提现、是否需要备注
-(void)getCurrencyConfig:(NSString*)currencyName
{
    WEAK_SELF
    BICGetCurrencyConfigRequest * request = [[BICGetCurrencyConfigRequest alloc] init];
    request.currencyName = currencyName;
    [ODAlertViewFactory showLoadingViewWithView:self.view];
    [[BICWalletService sharedInstance] analyticalGetCurrencyConfigData:request serverSuccessResultHandler:^(id response) {
        BICGetCurrencyConfigResponse *responseM = (BICGetCurrencyConfigResponse*)response;
        if (responseM) {
            weakSelf.response.isRemark = responseM.data.isRemark;
            weakSelf.response.isRecharge = responseM.data.isRecharge;
            weakSelf.response.isWithdrawal = responseM.data.isWithdrawal;
            weakSelf.response.isBlackWithdrawal = responseM.data.isBlackWithdrawal;
        }
        //允许提现
        if(responseM.data.isWithdrawal){
            [weakSelf analyticalGetOutQuotaData];
        }else{
            [weakSelf.tableView reloadData];
        }
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    }];
}
-(void)setResponse:(GetWalletsResponse *)response
{
    _response = response;
    [self getCurrencyConfig:response.tokenSymbol];
}
//新：获取币种对应手续费，最小提币额度
-(void)requestWalletGetGasConfig{
    WEAK_SELF
    BICGetCurrencyConfigRequest * request = [[BICGetCurrencyConfigRequest alloc] init];
    [ODAlertViewFactory showLoadingViewWithView:self.view];
    request.tokenSymbol=self.response.tokenSymbol;
    [[BICWalletService sharedInstance] analyticalNewGetGasConfigData:request serverSuccessResultHandler:^(id response) {
        BICGetGasConfigResponse *responseM = (BICGetGasConfigResponse*)response;
        if (responseM) {
            weakSelf.response.gasPrice = responseM.data.gasPrice?:@"0";
            weakSelf.response.minWdAmount = responseM.data.minWdAmount;
        }
        [weakSelf.tableView reloadData];
        [ODAlertViewFactory hideAllHud:weakSelf.view];
//        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    }];
}

//获取限额
-(void)analyticalGetOutQuotaData
{
    BICBaseRequest * request = [[BICBaseRequest alloc] init];
    
    [[BICWalletService sharedInstance] analyticalGetOutQuotaData:request serverSuccessResultHandler:^(id response) {
        BICGetOutQuotaResponse * responseM = (BICGetOutQuotaResponse*)response;
        if (responseM) {
            NSDictionary* dic = [responseM.data mj_keyValues];
            self.response.limitPrice = [dic objectForKey:self.response.tokenSymbol]?:@"0";
            [self requestWalletGetGasConfig];
//            [self.tableView reloadData];
//            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }
    } failedResultHandler:^(id response) {
        
    } requestErrorHandler:^(id error) {
        
    }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //判断是否暂停提币
    if (!self.response) {
        return 1;
    }
    if (!self.response.isWithdrawal) {
        return 2;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellId = @"cell__";
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    switch (indexPath.row) {
        case 0:
        {
            BICSelectCoinVC * cell = [BICSelectCoinVC exitWithTableView:tableView];
            cell.response= self.response;
            return cell;
        }
            break;
        case 1:
        {
            if (!self.response.isWithdrawal) {
                BICPauseRechargeCell * cell = [BICPauseRechargeCell exitWithTableView:tableView];
                cell.type = Pause_Type_WithDraw;
                return cell;
            }
            BICWalletDrawTypeCell * cell = [BICWalletDrawTypeCell exitWithTableView:tableView];
            cell.response= self.response;
            return cell;
        }
            break;
        case 2:
        {
            BICWalletDrawNumCell * cell = [BICWalletDrawNumCell exitWithTableView:tableView];
            cell.response= self.response;
            return cell;
        }
            break;
        
            
        default:
            break;
    }
    
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            return 88.f;
        }
            break;
        case 1:
        {
            if (!self.response.isWithdrawal) {
                return SCREEN_HEIGHT-kNavBar_Height-88.f;
            }
            if ((!self.response.isRemark) && (![self.response.tokenSymbol isEqualToString:@"USDT"])) {
                
                return 328.f - 96.f - 96.f + 16;
            }else if((![self.response.tokenSymbol isEqualToString:@"USDT"]) ||
                     (!self.response.isRemark)) {
                
                return 328.f - 96.f + 16;

            }else{
                
                return 328.f;
            }
            
            return 328.f;
        }
            break;
        case 2:
        {
            return 340.f;
            
        }
            break;
    
            
        default:
            break;
    }
    
    
    return 0.f;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        BICWSelectCoinTypeVC * selectCoinKind = [[BICWSelectCoinTypeVC alloc] init];
        WEAK_SELF
        selectCoinKind.selectBlock = ^(GetWalletsResponse * _Nonnull response) {
            weakSelf.response = response;
            [weakSelf getCurrencyConfig:response.tokenSymbol];
        };
        
        [self.navigationController pushViewController:selectCoinKind animated:YES];
    }
    
    
}

-(void)getDataResponseNoti:(NSNotification*)notify;
{
    GetWalletsResponse *response = notify.object;
    
    if (response) {
        self.response = response;
        [self getCurrencyConfig:response.tokenSymbol];
        
    }
}




@end

//
//  BICWalletRechargeVC.m
//  Biconome
//
//  Created by 车林 on 2019/8/31.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICWalletRechargeVC.h"

#import "BICSelectCoinVC.h"
#import "BICQRCodeCell.h"
#import "BICWalAddressCell.h"
#import "BICWallSaveCell.h"
#import "BICWalletBomCell.h"

#import "BICWSelectCoinTypeVC.h"

#import "BICGetCurrencyConfigRequest.h"
#import "BICGetCurrencyConfigResponse.h"
#import "BICPauseRechargeCell.h"
#import "BICWalletHistoryVC.h"
#import "BICLinkTypeViewCell.h"
@interface BICWalletRechargeVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableView;



@end

@implementation BICWalletRechargeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];
//    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiBlack" titleColor:nil];


    [self initNavigationTitleViewLabelWithTitle:LAN(@"充值") titleColor:kNVABICSYSTEMTitleColor IfBelongTabbar:NO];
    
    [self initNavigationRightButtonWithTitle:LAN(@"历史") titileColor:kNVABICSYSTEMTitleColor];

    [self.view addSubview:self.tableView];
    WEAK_SELF
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view);
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
    historyVC.transferType = TRANSFER_TYPE_IN;
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
-(void)getCurrencyConfig:(NSString*)currencyName
{
    BICGetCurrencyConfigRequest * request = [[BICGetCurrencyConfigRequest alloc] init];
    request.currencyName = currencyName;
    WEAK_SELF
    [ODAlertViewFactory showLoadingViewWithView:self.view];
    [[BICWalletService sharedInstance] analyticalGetCurrencyConfigData:request serverSuccessResultHandler:^(id response) {
        BICGetCurrencyConfigResponse *responseM = (BICGetCurrencyConfigResponse*)response;
        if (responseM) {
            weakSelf.response.isRemark = responseM.data.isRemark;
            weakSelf.response.isRecharge = responseM.data.isRecharge;
        }
        [weakSelf.tableView reloadData];
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //判断是否暂停充值
    if (!self.response) {
        return 1;
    }
    //充值暂停
    if (!self.response.isRecharge) {
        return 2;
    }

    return 7;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellId = @"cell__";
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    WEAK_SELF
    switch (indexPath.row) {
        case 0:
        {
            //选币cell
            BICSelectCoinVC * cell = [BICSelectCoinVC exitWithTableView:tableView];
            cell.response= self.response;
            return cell;
        }
            break;
        case 1:
        {
            //充值暂停cell
            if (!self.response.isRecharge) {
                BICPauseRechargeCell * cell = [BICPauseRechargeCell exitWithTableView:tableView];
                cell.type = Pause_Type_Recharge;
                return cell;
            }
            //链类型cell
            if([self.response.tokenSymbol isEqualToString:@"USDT"]){
                BICLinkTypeViewCell *cell=[BICLinkTypeViewCell cellWithTableView:tableView];
                cell.typeSelectItemOperationBlock = ^(int index) {
                    weakSelf.response.addrIndex=index;
                    [weakSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:2 inSection:0],[NSIndexPath indexPathForRow:3 inSection:0],nil] withRowAnimation:UITableViewRowAnimationNone];
                };
                return cell;
            }else{
                return cell;
            }
        }
            break;
        case 2:
        {
            //二维码cell
            BICQRCodeCell * cell = [BICQRCodeCell exitWithTableView:tableView];
            cell.response= self.response;
            return cell;
        }
            break;
        case 3:
        {
            //地址cell
            BICWalAddressCell * cell = [BICWalAddressCell exitWithTableView:tableView];
            cell.addressTitle.text = LAN(@"地址");
            cell.response= self.response;
            return cell;
        }
            break;
        case 4:
        {
            //备注cell
            BICWalAddressCell * cell = [BICWalAddressCell exitWithTableView:tableView];
            cell.addressTitle.text = LAN(@"备注");
            cell.hidden = !self.response.isRemark;
            
            return cell;
        }
            break;
        case 5:
        {
            //保存按钮cell
            BICWallSaveCell * cell = [BICWallSaveCell exitWithTableView:tableView];
            cell.response = self.response;
            return cell;
        }
            break;
        case 6:
        {
            //提示cell
            BICWalletBomCell * cell = [BICWalletBomCell exitWithTableView:tableView];
            cell.titleTextLab.text = [NSString stringWithFormat:@"%@%@,%@",LAN(@"此地址只可接收"),self.response.tokenSymbol,LAN(@"充值其他资产将不可找回")];
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
            if (!self.response.isRecharge) {
                return SCREEN_HEIGHT-kNavBar_Height-88.f;
            }
            
            if([self.response.tokenSymbol isEqualToString:@"USDT"]){
                return 105;
            }else{
                return 0.1;
            }
        }
            break;
        case 2:
        {
            return 285.f;
        }
            break;
        case 3:
        {
            return 105.f;

        }
            break;
        case 4:
        {
            if (self.response.isRemark) {
                return 105.f;
            }
            return 0.01;
        }
            break;
        case 5:
        {
            return 92.f;

        }
            break;
        case 6:
        {
            return 166.f;

        }
            break;
            
        default:
            break;
    }
    
    
    return 0.f;
    
}
-(void)setResponse:(GetWalletsResponse *)response
{
    _response = response;
    [self getCurrencyConfig:response.tokenSymbol];
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

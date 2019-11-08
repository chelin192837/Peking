//
//  BICInviteReturnVC.m
//  Biconome
//
//  Created by 车林 on 2019/10/5.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICInviteReturnVC.h"
#import "BICInviteReturnView.h"
#import "BICInviteReturnHisVC.h"
#import "BICRelationResponse.h"
#import "BICInvitationInfoResponse.h"
#import "BICInviteReturnModel.h"
#import "BICInvitationConfigResponse.h"
#define InviteLink @"https://www.biconomy.com/en/register?ref="

@interface BICInviteReturnVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)BICInviteReturnView * headerView;

@property(nonatomic,strong)BICInviteReturnModel * inviteReturnModel;

@end

@implementation BICInviteReturnVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self initNavigationRightButtonWithBackImage:[UIImage imageNamed:@"icon_navigation_history"]];
        
    [self analyData];
}

-(void)setupUI
{
    [self.view addSubview:self.tableView];

}
-(void)analyData
{
    self.inviteReturnModel = [[BICInviteReturnModel alloc] init];
    [self analytiInvitationInfo];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromContextWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromContextWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
}
-(void)analytiInvitationInfo
{
    WEAK_SELF
    BICBaseRequest * request = [[BICBaseRequest alloc] init];
    [[BICProfileService sharedInstance] analytiCalinvitationConfigInfo:request serverSuccessResultHandler:^(id response) {
        BICInvitationConfigResponse * responseM = (BICInvitationConfigResponse*)response;
        if (responseM.code==200) {
            weakSelf.inviteReturnModel.titlePrecent = responseM.data.directPercent;
            [weakSelf relationInfo];
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
    } failedResultHandler:^(id response) {
        
    } requestErrorHandler:^(id error) {
        
    }];
}
-(void)relationInfo
{
    BICBaseRequest * request = [[BICBaseRequest alloc] init];
    WEAK_SELF
    [[BICProfileService sharedInstance] analytiRelationInfo:request serverSuccessResultHandler:^(id response) {
        BICRelationResponse * responseM = (BICRelationResponse*)response;
        if (responseM.code==200) {
            weakSelf.inviteReturnModel.returnPrice =responseM.data.commission;
            weakSelf.inviteReturnModel.directInviter =responseM.data.directPerson;
            weakSelf.inviteReturnModel.indirectInviter =responseM.data.indirectPerson;
            weakSelf.inviteReturnModel.inviterLink =[NSString stringWithFormat:@"%@%@",InviteLink,SDUserDefaultsGET(BICInvitationCode)];
            weakSelf.inviteReturnModel.inviterCode = SDUserDefaultsGET(BICInvitationCode);
            weakSelf.headerView.inviteReturnModel = weakSelf.inviteReturnModel;
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
    } failedResultHandler:^(id response) {
        
    } requestErrorHandler:^(id error) {
        
    }];
}
-(void)doRightBtnAction
{
    BICInviteReturnHisVC * inviteVC = [[BICInviteReturnHisVC alloc] init];
    [self.navigationController pushViewController:inviteVC animated:YES];
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,-kNavBar_Height, SCREEN_WIDTH, SCREEN_HEIGHT+kNavBar_Height) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=kBICHistoryCellBGColor;
        //        _tableView.backgroundColor=kBICWhiteColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _headerView  = [[BICInviteReturnView alloc] initWithNib];
        _tableView.tableHeaderView = _headerView;
        
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellId = @"cell__";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 0.01;
}



@end

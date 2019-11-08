//
//  BICMineVC.m
//  Biconome
//
//  Created by 车林 on 2019/8/31.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICMineVC.h"
#import "BICMineHeadView.h"
#import "BICMineCell.h"
#import "BICLoginVC.h"
#import "BICMineOrderDeleVC.h"
#import "BICHistoryDeleVC.h"
#import "BICOrderDealVC.h"
#import "BICSettingVC.h"
#import "RSDHomeListWebVC.h"
#import "BICMineNewCell.h"
#import "BICAccountSafeVC.h"
#import "BICVerificationVC.h"
#import "BICInviteReturnVC.h"
#import "BICAuthInfoResponse.h"
@interface BICMineVC ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)NSArray * titleArr;
@property(nonatomic,strong)NSArray * imageArr;
//@property(nonatomic,assign)BOOL isPresent;
@property(nonatomic,assign)BOOL animated;
@property(nonatomic,strong)BICAuthInfoResponse *response;
@end

@implementation BICMineVC

- (void)navigationController:(UINavigationController*)navigationController willShowViewController:(UIViewController*)viewController animated:(BOOL)animated
{
    if (viewController == self) {
        [self.navigationController setNavigationBarHidden:YES animated:self.animated];
    }else{
        [self.navigationController setNavigationBarHidden:NO animated:self.animated];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBICMainListBGColor;
    self.navigationController.navigationBar.hidden=YES;
    self.navigationController.delegate=self;
    [self setupUI];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.animated=animated;
    NSArray * titleArr = @[LAN(@"身份认证"),LAN(@"邀请返佣"),LAN(@"当前委托"),LAN(@"历史委托"),LAN(@"成交"),LAN(@"账户安全"),LAN(@"帮助与反馈"),LAN(@"设置")];
    self.titleArr = titleArr;
//    [self.tableView reloadData];
    if (![BICDeviceManager isLogin]) {
        [self.tableView reloadData];
    }else{
        if([self.response.data.status isEndWithString:@"Y"]){
            [self.tableView reloadData];
        }else{
              [self.tableView reloadData];
              //测试实名认证是放开
//            [self requestAuthInfo];
        }
    }
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.animated=animated;
    [super viewWillDisappear:animated];
}
-(void)setupUI
{
    NSArray * titleArr = @[LAN(@"身份认证"),LAN(@"邀请返佣"),LAN(@"当前委托"),LAN(@"历史委托"),LAN(@"成交"),LAN(@"账户安全"),LAN(@"帮助与反馈"),LAN(@"设置")];
    NSArray * imageArr = @[@"icon_identity_authentication",@"icon_profile_rakeback",@"list_current_delegation",@"list_historical_entrustment",@"list_deal",@"list_account_security",@"list_help_feedback",@"list_setting"];

    self.imageArr = imageArr;
    self.titleArr = titleArr;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-kTabBar_Height);
        make.top.equalTo(self.view).offset(-kStatusBar_Height);
    }];
}
-(void)updateUI:(NSNotification*)notify
{
    [self setupUI];
}


-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 73, 0);     _tableView.backgroundColor=kBICHistoryCellBGColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.showsVerticalScrollIndicator = NO;

        UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 268)];
        BICMineHeadView * headView = [[BICMineHeadView alloc] initWithNib];
        headView.frame=CGRectMake(0, 0, SCREEN_WIDTH, 268);
        headView.presentItemOperationBlock = ^{
             
        };
        [head addSubview:headView];
        _tableView.tableHeaderView = head;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if(indexPath.row==0){
        BICMineNewCell *cell=[BICMineNewCell cellWithTableView:tableView];
        cell.titleTexLab.text = self.titleArr[indexPath.row];
        cell.titleImg.image = [UIImage imageNamed:self.imageArr[indexPath.row]];
        cell.response=self.response;
        if (![BICDeviceManager isLogin]) {
             cell.detailLabel.text=@"";
        }
        cell.ishaveTop=YES;
        cell.ishaveBottom=NO;
        
        
        cell.hidden = YES ;
        return cell;
    }
    
    BICMineCell * cell = [BICMineCell exitWithTableView:tableView];

    if (indexPath.row==1) {
        cell.hidden = YES;
        
        }
    
//    if (indexPath.row==2) {
//        cell.bottomView.hidden = NO;
//    }else{
//        cell.bottomView.hidden = YES;
//    }
//    if (indexPath.row==3) {
//        cell.topView.hidden = NO;
//    }else{
//        cell.topView.hidden = YES;
//    }
    
    cell.titleTexLab.text = self.titleArr[indexPath.row];
    cell.titleImg.image = [UIImage imageNamed:self.imageArr[indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0 ||
        indexPath.row==1) {
        return 0.f;
    }
    
//    if (indexPath.row==3) {
//        return 56.f;
//    }
    return 68;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAK_SELF
    if (indexPath.row==0 ||
        indexPath.row==1 ||
        indexPath.row==2 ||
        indexPath.row==3 ||
        indexPath.row==4 ||
        indexPath.row==5) {
        if (![BICDeviceManager isLogin]) {
            [BICDeviceManager PushToLoginView];
            return;
        }
    }
    if (indexPath.row==0) {
        BICVerificationVC *vc=[[BICVerificationVC alloc] init];
        vc.backReloadOperationBlock = ^{
            [weakSelf requestAuthInfo];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==1) { // 邀请返佣
        BICInviteReturnVC * inviteReturnVC = [[BICInviteReturnVC alloc] init];
        [self.navigationController pushViewController:inviteReturnVC animated:YES];
    }else if (indexPath.row==2) {
        BICMineOrderDeleVC * vc = [[BICMineOrderDeleVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexPath.row==3){
        BICHistoryDeleVC * vc = [[BICHistoryDeleVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexPath.row==4){
        BICOrderDealVC * vc = [[BICOrderDealVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if(indexPath.row==5){ //账户安全
        BICAccountSafeVC * safeVC = [[BICAccountSafeVC alloc] init];
        [self.navigationController pushViewController:safeVC animated:YES];
    }else if(indexPath.row==6){ //帮助与反馈
        RSDHomeListWebVC * webVC = [[RSDHomeListWebVC alloc] init];
        webVC.navigationShow = NO;
        webVC.naviStr=LAN(@"帮助与反馈");
        webVC.listWebStr = @"https://biconomy.zendesk.com/hc/en-us";
        [self.navigationController pushViewController:webVC animated:YES];
    }else if (indexPath.row==7) {
        BICSettingVC * settingVC = [[BICSettingVC alloc] init];
        [self.navigationController pushViewController:settingVC animated:YES];
    }
}

-(void)requestAuthInfo{
    WEAK_SELF
    BICBaseRequest *request = [[BICBaseRequest alloc] init];
    [[BICProfileService sharedInstance] analyticalAuthInfo:request serverSuccessResultHandler:^(id response) {
           weakSelf.response = (BICAuthInfoResponse*)response;
           [weakSelf.tableView reloadData];
       } failedResultHandler:^(id response) {
           [weakSelf.tableView reloadData];
       } requestErrorHandler:^(id error) {
           [weakSelf.tableView reloadData];
       }];
}

-(BICAuthInfoResponse *)response{
    if(!_response){
        _response=[[BICAuthInfoResponse alloc] init];
    }
    return _response;
}
@end

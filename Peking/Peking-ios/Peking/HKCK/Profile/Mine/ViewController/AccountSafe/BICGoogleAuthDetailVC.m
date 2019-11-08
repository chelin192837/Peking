//
//  BICGoogleAuthDetailVC.m
//  Biconome
//
//  Created by 车林 on 2019/9/4.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICGoogleAuthDetailVC.h"
#import "BICGoogleAuthQRCell.h"
#import "BICGoogleCodeCell.h"
#import "BICBindGoogleResponse.h"
@interface BICGoogleAuthDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)NSArray * titleArr;
@property(nonatomic,strong)BICBindGoogleResponse * response;
@end

@implementation BICGoogleAuthDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBICMainListBGColor;
    
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];
    
    [self initNavigationTitleViewLabelWithTitle:LAN(@"谷歌验证") titleColor:kNVABICSYSTEMTitleColor IfBelongTabbar:NO];

    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    [self setupData];
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
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 73, 0);     _tableView.backgroundColor=kBICHistoryCellBGColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        
    }
    return _tableView;
}
-(void)setupData
{
    WEAK_SELF
    BICRegisterRequest * request = [[BICRegisterRequest alloc] init];
    [[BICProfileService sharedInstance] analyticalGetGoogleKeyData:request serverSuccessResultHandler:^(id response) {
        BICBindGoogleResponse * responseM = (BICBindGoogleResponse*)response;
        if (responseM.code==200) {
            weakSelf.response = responseM;
            [weakSelf.tableView reloadData];
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
        
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    }];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        BICGoogleAuthQRCell * cell = [BICGoogleAuthQRCell exitWithTableView:tableView];
        cell.response = self.response;
        return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 450.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
}


@end




//
//  BICGooglePasswordVC.m
//  Biconome
//
//  Created by 车林 on 2019/8/31.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICGooglePasswordVC.h"

#import "BICGoogleCodeCell.h"

#import "BICGoogleAuthDetailVC.h"
#import "BICGoogleAuthVC.h"
@interface BICGooglePasswordVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableView;

@end

@implementation BICGooglePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBICMainListBGColor;
    
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];
    
    [self initNavigationTitleViewLabelWithTitle:LAN(@"谷歌验证") titleColor:kNVABICSYSTEMTitleColor IfBelongTabbar:NO];
    
    [self.view addSubview:self.tableView];
    WEAK_SELF
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view);
    }];
    kADDNSNotificationCenter(NSNotificationCenterBindGoogleSucceed);
    
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BICGoogleCodeCell * cell = [BICGoogleCodeCell exitWithTableView:tableView];
    cell.gooleKey = self.gooleKey;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 316.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

}

-(void)notify:(NSNotification*)notify
{
    BICGoogleAuthVC * authVC;
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[BICGoogleAuthVC class]]) {
            authVC = (BICGoogleAuthVC*)vc;
        }
    }
    if (authVC) {
        [self.navigationController popToViewController:authVC animated:YES];
    }
    
}
@end

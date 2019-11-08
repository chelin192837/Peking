//
//  BICGoogleAuthVC.m
//  Biconome
//
//  Created by 车林 on 2019/8/31.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICGoogleAuthVC.h"

#import "BICMineComCell.h"

#import "BICGoogleAuthDetailVC.h"

@interface BICGoogleAuthVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)NSArray * titleArr;

@end

@implementation BICGoogleAuthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBICMainListBGColor;
    
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];
    
    [self initNavigationTitleViewLabelWithTitle:LAN(@"谷歌验证") titleColor:kNVABICSYSTEMTitleColor IfBelongTabbar:NO];
    
    NSArray * titleArr = @[LAN(@"谷歌验证or")];
    self.titleArr = titleArr;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.tableView) {
        [self.tableView reloadData];
    }
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
    
    BICMineComCell * cell = [BICMineComCell exitWithTableView:tableView];
    
    cell.titleTexLab.text = self.titleArr[indexPath.row];
    NSNumber* index = SDUserDefaultsGET(BICBindGoogleAuth);
    if (index.boolValue) { //已经绑定了
        cell.rightLab.text = LAN(@"已启用");
        cell.rightLab.textColor= kBICBindedColor;
        cell.rightLab.hidden = NO;
    }else{//没有绑定
        cell.rightLab.text = LAN(@"启用");
        cell.rightLab.textColor= kBICNoBindColor;
        cell.rightLab.hidden = NO;
//        cell.rightLab.hidden = YES;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==0) {
        NSNumber* index = SDUserDefaultsGET(BICBindGoogleAuth);
        if (index.boolValue) { //已经绑定了

        }else{
            BICGoogleAuthDetailVC *detailVC = [[BICGoogleAuthDetailVC alloc] init];
            
            [self.navigationController pushViewController:detailVC animated:YES];
        }
    }
    
}


@end

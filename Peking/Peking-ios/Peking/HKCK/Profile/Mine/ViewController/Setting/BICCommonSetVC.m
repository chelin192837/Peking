//
//  BICCommonSetVC.m
//  Biconome
//
//  Created by 车林 on 2019/8/31.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICCommonSetVC.h"

#import "RSDCLSelectPage.h"

#import "BICMineComCell.h"

@interface BICCommonSetVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)NSArray * titleArr;

@end

@implementation BICCommonSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBICMainListBGColor;
    
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];
    
    [self setupUI];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initNavigationTitleViewLabelWithTitle:LAN(@"通用设置") titleColor:kNVABICSYSTEMTitleColor IfBelongTabbar:NO];

    NSArray * titleArr = @[LAN(@"语言选择"),LAN(@"汇率")];
    self.titleArr = titleArr;
    [self.tableView reloadData];
}
-(void)setupUI
{
    [self initNavigationTitleViewLabelWithTitle:LAN(@"通用设置") titleColor:kNVABICSYSTEMTitleColor IfBelongTabbar:NO];
    
    NSArray * titleArr = @[LAN(@"语言选择"),LAN(@"汇率")];
    self.titleArr = titleArr;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BICMineComCell * cell = [BICMineComCell exitWithTableView:tableView];
    
    cell.titleTexLab.text = self.titleArr[indexPath.row];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        RSDCLSelectPage * selectPage = [[RSDCLSelectPage alloc] init];
        selectPage.titleStr = LAN(@"语言选择");
        selectPage.dateItemArray = @[@"简体中文",@"English"];
        selectPage.selectPageType = SelectPage_Type_Language;
        [self.navigationController pushViewController:selectPage animated:YES];
    }
    
    if (indexPath.row==1) {
        RSDCLSelectPage * selectPage = [[RSDCLSelectPage alloc] init];
        selectPage.selectPageType = SelectPage_Type_Rate;
        selectPage.titleStr = LAN(@"汇率");
        selectPage.dateItemArray = @[@"CNY",@"USD"];
        [self.navigationController pushViewController:selectPage animated:YES];
    }
    
}


@end

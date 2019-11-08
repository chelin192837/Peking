//
//  XWCountryCodeController.m
//  XWCountryCodeDemo
//
//  Created by 邱学伟 on 16/4/19.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "XWCountryCodeController.h"
#import "BICSearchHeaderView.h"
#import "RSDSearchNavigation.h"
#import "BICXWTabelCell.h"
#import "UIView+Extension.h"


static NSString * const identifier = @"cornerRadiusCell";

@interface XWCountryCodeController () <UITableViewDataSource,UITableViewDelegate> {
    UITableView *_tableView;
    NSDictionary *_sortedNameDict;
    NSArray *_indexArray;
    NSMutableArray *_results;
}

@property(nonatomic,strong)RSDSearchNavigation * searchNav;
@property(nonatomic,assign)BOOL  isActive;


@end


@implementation XWCountryCodeController

#pragma mark - system
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if(self.isWhiteNavBg){
        [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];
        [self initNavigationTitleViewLabelWithTitle:LAN(@"选择国家和地区") titleColor:kNVABICSYSTEMTitleColor IfBelongTabbar:NO];
    }else{
        self.navigationItem.title = LAN(@"选择国家和地区");
        [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"back" titleColor:nil];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromContextWithColor:[UIColor colorWithHexColorString:@"6653FF"]] forBarMetrics:UIBarMetricsDefault];
    }
    
    [self creatSubviews];
    
}


#pragma mark - private
 //创建子视图
- (void)creatSubviews{
    _results = [NSMutableArray arrayWithCapacity:1];
    
    if (self.type==XWCountry_type_Other) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height-kNavBar_Height) style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 44.0;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        BICSearchHeaderView* headV = [[NSBundle mainBundle] loadNibNamed:@"BICSearchHeaderView" owner:nil options:nil][0];
        if(self.isWhiteNavBg){
            headV.backgroundColor=[UIColor whiteColor];
        }
        headV.searchLab.text = LAN(@"搜索");
        headV.frame=CGRectMake(0, 0, SCREEN_WIDTH, 44);
        
        UITapGestureRecognizer *headTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headTap:)];
        [headV addGestureRecognizer:headTap];
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.bounds.size.width, 44)];
        [headerView addSubview:headV];
        _tableView.tableHeaderView = headerView;
    
        self.isActive = NO;
    }else if(self.type==XWCountry_type_Nav)
    {
//        [self.navigationController.navigationBar setHidden:YES];
        WEAK_SELF
        RSDSearchNavigation * searchNav = [[RSDSearchNavigation alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kNavBar_Height) WithName:LAN(@"请输入国名或国际区号进行搜索") WithSearchResult:^(NSString * _Nonnull str) {
                    NSLog(@"---%@",str);
            weakSelf.isActive = YES;
            [weakSelf updateSearchResultsForSearch:str];
            
        } WithCancel:^{
//            [weakSelf.navigationController.navigationBar setHidden:NO];
            [weakSelf.navigationController setNavigationBarHidden:NO animated:NO];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } WithType:SRARCH_NAV_WHITE];
        
        [self.view addSubview:searchNav];
        if(self.isWhiteNavBg){
            [searchNav.cancelBtn setTitleColor:UIColorWithRGB(0x6653FF) forState:UIControlStateNormal];
            searchNav.backgroundColor=[UIColor whiteColor];
        }
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,kNavBar_Height, self.view.bounds.size.width, self.view.bounds.size.height-kNavBar_Height) style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.rowHeight = 44.0;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.isActive = YES;

    }
    
    _tableView.backgroundColor = [UIColor colorWithHexColorString:@"EEF0F6"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //判断当前系统语言
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"language_type"] isEqualToString:@"en"]) {
        NSString *plistPathEN = [[NSBundle mainBundle] pathForResource:@"sortedNameEN" ofType:@"plist"];
        _sortedNameDict = [[NSDictionary alloc] initWithContentsOfFile:plistPathEN];
        _indexArray = [[NSArray alloc] initWithArray:[[_sortedNameDict allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 compare:obj2];
        }]];
        
    }else{
        NSString *plistPathCH = [[NSBundle mainBundle] pathForResource:@"sortedNameCH" ofType:@"plist"];
        _sortedNameDict = [[NSDictionary alloc] initWithContentsOfFile:plistPathCH];
        _indexArray = [[NSArray alloc] initWithArray:[[_sortedNameDict allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 compare:obj2];
        }]];
        
        NSMutableArray * indexMul = [NSMutableArray array];
        [indexMul addObject:_indexArray.lastObject];
        [indexMul addObjectsFromArray:_indexArray];
        [indexMul removeLastObject];
        _indexArray=indexMul.copy;
    }
    
   
    
}

- (NSString *)showCodeStringIndex:(NSIndexPath *)indexPath {
    NSString *showCodeSting;
    if (self.isActive) {
        if (_results.count > indexPath.row) {
            showCodeSting = [_results objectAtIndex:indexPath.row];
        }
    } else
    {
        if (_indexArray.count > indexPath.section) {
            NSArray *sectionArray = [_sortedNameDict valueForKey:[_indexArray objectAtIndex:indexPath.section]];
            if (sectionArray.count > indexPath.row) {
                showCodeSting = [sectionArray objectAtIndex:indexPath.row];
            }
        }
    }
    return showCodeSting;
}

-(void)headTap:(UITapGestureRecognizer*)tap
{
  
    XWCountryCodeController *CountryCodeVC = [[XWCountryCodeController alloc] init];
//    [self.navigationController.navigationBar setHidden:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    CountryCodeVC.type=XWCountry_type_Nav;
    if(self.isWhiteNavBg){
        CountryCodeVC.backType=XWCountry_Back_Type_Varidate;
    }else{
        CountryCodeVC.backType=XWCountry_Back_Type_Register;

    }

    CountryCodeVC.isWhiteNavBg=self.isWhiteNavBg;
    
    WEAK_SELF
    CountryCodeVC.returnCountryCodeBlock = ^(NSString *countryName, NSString *code) {
        if(weakSelf.returnCountryCodeBlock){
            weakSelf.returnCountryCodeBlock(countryName, code);
        }
    };
    [self.navigationController pushViewController:CountryCodeVC animated:NO];

}
- (void)selectCodeIndex:(NSIndexPath *)indexPath {
    
    NSString * originText = [self showCodeStringIndex:indexPath];
    NSArray  * array = [originText componentsSeparatedByString:@"+"];
    NSString * countryName = [array.firstObject stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString * code = array.lastObject;
    
    if (self.deleagete && [self.deleagete respondsToSelector:@selector(returnCountryName:code:)]) {
        [self.deleagete returnCountryName:countryName code:code];
    }
    
    if (self.returnCountryCodeBlock != nil) {
        self.returnCountryCodeBlock(countryName,code);
    }
    
    if (self.backType==XWCountry_Back_Type_Register) {
        if (self.isActive==YES) {
//            [self.navigationController.navigationBar setHidden:NO];
            [self.navigationController setNavigationBarHidden:NO animated:NO];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"__IMP__AREA__" object:@{@"countryName":countryName,@"code":code}];
            [self.navigationController popToRootViewControllerAnimated:NO];
            return;
        }
    }
    
    if(self.isWhiteNavBg==YES){
//        [self.navigationController.navigationBar setHidden:NO];
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
        return;
    }
    

    
    self.isActive = NO;

    if (self.navigationController) {
//        [self.navigationController.navigationBar setHidden:NO];
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        [self.navigationController popViewControllerAnimated:YES];
        
    } else {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
    
    NSLog(@"选择国家: %@   代码: %@",countryName,code);
}
- (void)updateSearchResultsForSearch:(NSString *)search {
    
    if (_results.count > 0) {
        [_results removeAllObjects];
    }
    NSString *inputText = search;
    __weak __typeof(self)weakSelf = self;
    [_sortedNameDict.allValues enumerateObjectsUsingBlock:^(NSArray * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj containsString:inputText]) {
                __strong __typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf->_results addObject:obj];
            }
        }];
    }];
    
    
    [_tableView reloadData];
}


#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.isActive) {
        return 1;
    } else {
        return [_sortedNameDict allKeys].count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isActive) {
         return [_results count];
    } else {
        if (_indexArray.count > section) {
            NSArray *array = [_sortedNameDict objectForKey:[_indexArray objectAtIndex:section]];
            return array.count;
        }
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    BICXWTabelCell *cell = [BICXWTabelCell exitWithTableView:tableView];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
//    CGRect rect = cell.topBgView.frame;

    // 每组第一行cell
    if (indexPath.row == 0) {

        cell.topBgView.layer.cornerRadius = 10.f;
        cell.layer.masksToBounds = YES;
        UIView* bottomV1 = [[UIView alloc] init];
        bottomV1.backgroundColor = [UIColor whiteColor];
        [cell.topBgView addSubview:bottomV1];
        [bottomV1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(cell.topBgView);
            make.height.equalTo(@10);
        }];
    }
    
    // 每组最后一行cell
    if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1) {
        cell.topBgView.layer.cornerRadius = 10.f;
        cell.layer.masksToBounds = YES;
        UIView* bottomV2 = [[UIView alloc] init];
        bottomV2.backgroundColor = [UIColor whiteColor];
        [cell.topBgView addSubview:bottomV2];
        [bottomV2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(cell.topBgView);
            make.height.equalTo(@10);
        }];
    }
    
    NSString* str = [self showCodeStringIndex:indexPath];
    
    NSArray * arr = [str componentsSeparatedByString:@" "];
    
    cell.countryNameLab.text = arr[0];
    
    if (arr.count>1) {
        cell.codeLab.text = arr[1];
    }
    
    return cell;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (tableView == _tableView) {
        NSMutableArray* arr = [NSMutableArray arrayWithArray:_indexArray];
        [arr replaceObjectAtIndex:0 withObject:@"#"];
        return arr;
    }else{
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    if (tableView == _tableView) {
        return index;
    } else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == _tableView) {
        if (section == 0) {
            if (self.isActive) {
                return 30;
            }
            return 30;
        }
        return 30;
    } else {
        return 0;
    }
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.textColor = [UIColor colorWithHexColorString:@"95979D"];
    header.textLabel.font = [UIFont systemFontOfSize:14.f];
    header.contentView.backgroundColor = [UIColor colorWithHexColorString:@"EEF0F6"];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (_indexArray.count && _indexArray.count > section) {
        if (self.isActive) {
            return @"   ";
        }
        return [_indexArray objectAtIndex:section];
    }
    return @"  ";
}

#pragma mark - 选择国际获取代码
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self selectCodeIndex:indexPath];
}

@end

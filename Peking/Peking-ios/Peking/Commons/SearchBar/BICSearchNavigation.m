//
//  BICSearchNavigation.m
//  Agent
//
//  Created by qsm on 2018/12/6.
//  Copyright © 2018年 七扇门. All rights reserved.
//

#import "BICSearchNavigation.h"
#import "BICHistoryView.h"

@interface BICSearchNavigation()<UISearchBarDelegate>

@property (nonatomic,copy) SearchBlock searchBlock;

@property (nonatomic,copy) CancelBlock cancelBlock;

@property (nonatomic,copy) BeginBlock beginBlock;

@property (nonatomic,strong) NSString * nameStr ;

@property (nonatomic,assign) SEARCHNAVTYPE type ;

@property(nonatomic,strong) BICHistoryView * historyView;

@property(nonatomic,strong) UIViewController * superView;

@property(nonatomic,strong) NSMutableArray *historyDataArray;

@property(nonatomic,strong) UIButton * cancelBtn;

@end

@implementation BICSearchNavigation


-(instancetype)initWithFrame:(CGRect)frame WithName:(NSString*)str WithSearchResult:(SearchBlock)searchBlock WithCancel:(CancelBlock)cancelBlock
{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = kBICWhiteColor;
        
        _searchBlock = searchBlock ;
        
        _cancelBlock = cancelBlock ;
        
        _nameStr = str ;
        
        [self setupUI];
        
    }
    return self ;
}

-(instancetype)initWithFrame:(CGRect)frame WithName:(NSString*)str WithSearchResult:(SearchBlock)searchBlock WithCancel:(CancelBlock)cancelBlock WithType:(SEARCHNAVTYPE)type
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = kBICWhiteColor;
        
        _searchBlock = searchBlock ;
        
        _cancelBlock = cancelBlock ;
        
        _nameStr = str ;
        
        _type = type;
        
        [self setupUI];
        
    }
    
    return self ;
    
}
-(instancetype)initWithFrame:(CGRect)frame
                    WithName:(NSString*)str
             WithBeginSearch:(BeginBlock)beginBlock
            WithSearchResult:(SearchBlock)searchBlock
                  WithCancel:(CancelBlock)cancelBlock
                    WithType:(SEARCHNAVTYPE)type
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = kBICWhiteColor;
        
        _searchBlock = searchBlock ;
        
        _cancelBlock = cancelBlock ;
        
        _beginBlock = beginBlock ;
        
        _nameStr = str ;
        
        _type = type;
        
        [self setupUI];
        
    }
    
    return self ;
}
-(instancetype)initWithFrame:(CGRect)frame
                    WithName:(NSString*)str
             WithBeginSearch:(BeginBlock)beginBlock
            WithSearchResult:(SearchBlock)searchBlock
                  WithCancel:(CancelBlock)cancelBlock
                    WithType:(SEARCHNAVTYPE)type
               WithSuperView:(UIViewController*)superView
{
    if (self = [super initWithFrame:frame]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUI) name:NSNotificationCenterUpdateUI object:nil];
        
        self.backgroundColor = kBICWhiteColor;
        
        _searchBlock = searchBlock ;
        
        _cancelBlock = cancelBlock ;
        
        _beginBlock = beginBlock ;
        
        _nameStr = str ;
        
        _type = type;
        
        _superView = superView;
        
        [self setupUI];
        
    }
    
    return self ;
}
-(instancetype)initNoHisWithFrame:(CGRect)frame
                    WithName:(NSString*)str
             WithBeginSearch:(BeginBlock)beginBlock
            WithSearchResult:(SearchBlock)searchBlock
                  WithCancel:(CancelBlock)cancelBlock
                    WithType:(SEARCHNAVTYPE)type
               WithSuperView:(UIViewController*)superView
{
    if (self = [super initWithFrame:frame]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUI) name:NSNotificationCenterUpdateUI object:nil];
        
        self.backgroundColor = kBICWhiteColor;
        
        _searchBlock = searchBlock ;
        
        _cancelBlock = cancelBlock ;
        
        _beginBlock = beginBlock ;
        
        _nameStr = str ;
        
        _type = type;
        
        _superView = superView;
        
        [self setupNoHisUI];
        
    }
    
    return self ;
}
-(void)updateUI
{
    [self setupUI];
}
-(void)setupUI
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //取消按钮
    UIButton * cancelBtn = [[UIButton alloc] init];
    [cancelBtn setTitle:LAN(@"取消") forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:17.f];
    [cancelBtn setTitleColor:kBICSYSTEMBGColor forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelTap:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-14);
        make.bottom.equalTo(self).offset(-2);
        make.width.equalTo(@(LanguageIsChinese?40:55));
        make.height.equalTo(@40);
    }];
    
    //搜索 _UISearchBarSearchFieldBackgroundView
    UISearchBar * searchBar = [[UISearchBar alloc] init];
    self.searchBar = searchBar;
    searchBar.placeholder = LAN(self.nameStr);
    searchBar.barTintColor = [UIColor whiteColor];
    searchBar.layer.cornerRadius = kBICCornerRadius;
    searchBar.layer.masksToBounds = YES ;
    
    searchBar.backgroundImage = [UIImage imageFromContextWithColor:kBICHomeBGColor];
    
    UITextField * textField;
    if (@available(iOS 13.0, *)) {
         // 调用方法
         textField = (UITextField *)[self findViewWithClassName:@"UITextField" inView:searchBar];
     } else {
        textField = [searchBar valueForKey:@"_searchField"];
     }
    [searchBar setImage:[UIImage imageNamed:@"search_market"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [textField setTextColor:kBICTitleTextColor];
    textField.font = [UIFont systemFontOfSize:16.f];
    textField.backgroundColor = [UIColor clearColor] ;
    searchBar.delegate = self ;
    [self addSubview:searchBar];
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(cancelBtn.mas_left).offset(-10);
        make.left.equalTo(self).offset(14);
        make.centerY.equalTo(cancelBtn);
        make.height.equalTo(@30);
    }];

    self.historyView = [[BICHistoryView alloc] initWithFrame:CGRectMake(0,kNavBar_Height, SCREEN_WIDTH, SCREEN_HEIGHT-kNavBar_Height)];
   WEAK_SELF
    self.historyView.clearBlock = ^{
        [weakSelf clearBtnClick];
        weakSelf.historyView.hidden = YES;
    };
    
    [self.superView.view addSubview:self.historyView];
    
    [textField becomeFirstResponder] ;
    
    if (textField) {
        
        //searchField.frame = CGRectMake(0, 0, 50, 50);
        
        UIImage *image = [UIImage imageNamed: @"search_market"];
        
        UIImageView *iView = [[UIImageView alloc] initWithImage:image];
        
        iView.frame = CGRectMake(0,10, 20, 20);
        
        UIView *myview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 40)];
        
        [myview addSubview:iView];
        
        textField.leftView = myview;
        
        
    }
    
    self.historyView.historyDataArray = [self historyDataArray];
    
}
// 替代方案 2，遍历获取指定类型的属性
- (UIView *)findViewWithClassName:(NSString *)className inView:(UIView *)view{
    Class specificView = NSClassFromString(className);
    if ([view isKindOfClass:specificView]) {
        return view;
    }
 
    if (view.subviews.count > 0) {
        for (UIView *subView in view.subviews) {
            UIView *targetView = [self findViewWithClassName:className inView:subView];
            if (targetView != nil) {
                return targetView;
            }
        }
    }
    
    return nil;
}
-(void)setupNoHisUI
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //取消按钮
    UIButton * cancelBtn = [[UIButton alloc] init];
    [cancelBtn setTitle:LAN(@"取消") forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:17.f];
    [cancelBtn setTitleColor:kBICSYSTEMBGColor forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelTap:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-14);
        make.bottom.equalTo(self).offset(-2);
        make.width.equalTo(@(LanguageIsChinese?40:55));
        make.height.equalTo(@40);
    }];
    
    //搜索 _UISearchBarSearchFieldBackgroundView
    UISearchBar * searchBar = [[UISearchBar alloc] init];
    self.searchBar = searchBar;
    searchBar.placeholder = LAN(self.nameStr);
    searchBar.barTintColor = [UIColor whiteColor];
    searchBar.layer.cornerRadius = kBICCornerRadius;
    searchBar.layer.masksToBounds = YES ;
    
    searchBar.backgroundImage = [UIImage imageFromContextWithColor:kBICHomeBGColor];
//    UITextField * textField = [searchBar valueForKey:@"_searchField"];
    
    UITextField * textField;
    if (@available(iOS 13.0, *)) {
        // 调用方法
        textField = (UITextField *)[self findViewWithClassName:@"UITextField" inView:searchBar];
    } else {
       textField = [searchBar valueForKey:@"_searchField"];
    }
    
    
    [searchBar setImage:[UIImage imageNamed:@"search_market"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
    [textField setTextColor:kBICTitleTextColor];
    textField.font = [UIFont systemFontOfSize:16.f];
    textField.backgroundColor = [UIColor clearColor] ;
    searchBar.delegate = self ;
    [self addSubview:searchBar];
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(cancelBtn.mas_left).offset(-10);
        make.left.equalTo(self).offset(14);
        make.centerY.equalTo(cancelBtn);
        make.height.equalTo(@30);
    }];
    [textField becomeFirstResponder] ;
    
    

    if (textField) {
        
        //searchField.frame = CGRectMake(0, 0, 50, 50);
        
        UIImage *image = [UIImage imageNamed: @"search_market"];

        UIImageView *iView = [[UIImageView alloc] initWithImage:image];
        
        iView.frame = CGRectMake(0,10, 20, 20);
        
        UIView *myview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 40)];

        [myview addSubview:iView];
        
        textField.leftView = myview;
        
        
    }
    
}

-(void)cancelTap:(UIButton*)sender{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (self.searchBlock) {
        
        self.historyView.hidden = YES;
        
        self.searchBlock(searchText);
    }
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    if (self.beginBlock) {
        self.beginBlock();
    }
}

#pragma mark -- 获取//$$$历史记录数据
- (NSMutableArray *)historyDataArray{
    _historyDataArray = [NSMutableArray array];
    [_historyDataArray addObjectsFromArray:[self searchDataArray]];
    return _historyDataArray;
}


-(NSMutableArray*)searchDataArray
{
    NSMutableArray *array = [NSMutableArray array];
    NSString *filePath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES).firstObject;
    NSString *fileName=[filePath stringByAppendingPathComponent:kHistoryName];
    // 反归档
    array=[NSKeyedUnarchiver unarchiveObjectWithFile:fileName];
    NSMutableArray* mutalArray = [NSMutableArray arrayWithArray:array];
    return mutalArray;
}

#pragma mark -- 清空//$$$历史记录数据
- (void)clearBtnClick{

    NSString* filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask ,YES).firstObject;

    NSString * fileName = [filePath stringByAppendingPathComponent:kHistoryName];

    NSArray * array = [NSKeyedUnarchiver unarchiveObjectWithFile:fileName];

    NSMutableArray* historyArray = [NSMutableArray arrayWithArray:array];

    [historyArray removeAllObjects];

    [NSKeyedArchiver archiveRootObject:historyArray.copy toFile:fileName];
}



#pragma mark -- 写入历史记录
- (void)writeToFile:(NSString*)str
{
    NSString* filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask ,YES).firstObject;

    NSString * fileName = [filePath stringByAppendingPathComponent:kHistoryName];

    NSArray * arr =  [NSKeyedUnarchiver unarchiveObjectWithFile:fileName]; ;

    NSMutableArray * historyArray = [NSMutableArray arrayWithArray:arr];

    [historyArray addObject:str];

    if (historyArray.count > 10) {
        [historyArray removeObject:historyArray.firstObject];
    }

    [NSKeyedArchiver archiveRootObject:historyArray toFile:fileName];

}


@end


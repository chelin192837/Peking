//
//  RSDSearchNavigation.m
//  Agent
//
//  Created by qsm on 2018/12/6.
//  Copyright © 2018年 七扇门. All rights reserved.
//

#import "RSDSearchNavigation.h"

@interface RSDSearchNavigation()<UISearchBarDelegate>

@property (nonatomic,copy) SearchBlock searchBlock;

@property (nonatomic,copy) CancelBlock cancelBlock;

@property (nonatomic,copy) BeginBlock beginBlock;

@property (nonatomic,strong) NSString * nameStr ;

@property (nonatomic,assign) SEARCHNAVTYPE type ;


@end
@implementation RSDSearchNavigation


-(instancetype)initWithFrame:(CGRect)frame WithName:(NSString*)str WithSearchResult:(SearchBlock)searchBlock WithCancel:(CancelBlock)cancelBlock
{

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = kBICMainBGColor;
        
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
        
        self.backgroundColor = kBICMainBGColor;
        
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
        
        self.backgroundColor = kBICMainBGColor;
        
        _searchBlock = searchBlock ;
        
        _cancelBlock = cancelBlock ;
        
        _beginBlock = beginBlock ;
        
        _nameStr = str ;
        
        _type = type;
        
        [self setupUI];
        
    }
    
    return self ;
}

-(void)setupUI
{
    //取消按钮
    UIButton * cancelBtn = [[UIButton alloc] init];
    self.cancelBtn=cancelBtn;
    [cancelBtn setTitle:LAN(@"取消") forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:17.f];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
    searchBar.placeholder = self.nameStr ;
    searchBar.barTintColor = [UIColor whiteColor];
    searchBar.layer.cornerRadius = [self getLayerCornerRadius:_type];
    searchBar.layer.masksToBounds = YES ;
    
    searchBar.backgroundImage = [UIImage imageFromContextWithColor:[UIColor colorWithHexColorString:@"000000" alpha:0.2]];
    
    UITextField * textField;
    if (@available(iOS 13.0, *)) {
        // 调用方法
        textField = (UITextField *)[self findViewWithClassName:@"UITextField" inView:searchBar];
    } else {
       textField = [searchBar valueForKey:@"_searchField"];
    }
    
    [searchBar setImage:[UIImage imageNamed:@"search"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
    [textField setTextColor:[UIColor whiteColor]];
    textField.font = [UIFont systemFontOfSize:12.f];
    textField.backgroundColor = [UIColor clearColor] ;
    searchBar.delegate = self ;
    [self addSubview:searchBar];
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(cancelBtn.mas_left).offset(-10);
        make.left.equalTo(self).offset(14);
        make.centerY.equalTo(cancelBtn);
        make.height.equalTo(@30);
    }];
    
    //底线
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = [self getBottomLineColor:_type];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@1);
    }];
    
    [textField becomeFirstResponder] ;
    
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
-(void)cancelTap:(UIButton*)sender{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (self.searchBlock) {
        self.searchBlock(searchText);
    }
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    if (self.beginBlock) {
        self.beginBlock();
    }
}


-(CGFloat)getLayerCornerRadius:(SEARCHNAVTYPE)type{
    switch (type) {
        case SRARCH_NAV_GREEN:
        {
            return 15.f;
        }
            break;
        case SRARCH_NAV_WHITE:
        {
            return kLayer_CornerRadius;
        }
            break;
            
        default:
            break;
    }
    return kLayer_CornerRadius;
}

- (UIColor*)getBackColor:(SEARCHNAVTYPE)type{
    
    switch (type) {
        case SRARCH_NAV_GREEN:
        {
            return [UIColor colorWithPatternImage:[UIImage imageNamed:@"biaoqianlanBg"]];
        }
            break;
        case SRARCH_NAV_WHITE:
        {
            return [UIColor whiteColor];
        }
            break;
            
        default:
            break;
    }
    return [UIColor whiteColor];

}
- (UIColor*)getCancelBtnColor:(SEARCHNAVTYPE)type{
    
    switch (type) {
        case SRARCH_NAV_GREEN:
        {
            return [UIColor whiteColor];
        }
            break;
        case SRARCH_NAV_WHITE:
        {
            return rgb(102, 102, 102);
        }
            break;
            
        default:
            break;
    }
    return rgb(102, 102, 102);
    
}
-(UIColor*)getBottomLineColor:(SEARCHNAVTYPE)type{
    switch (type) {
        case SRARCH_NAV_GREEN:
        {
            return [UIColor whiteColor];
        }
            break;
        case SRARCH_NAV_WHITE:
        {
            return rgb(237, 237, 237);
        }
            break;
            
        default:
            break;
    }
    return [UIColor whiteColor];
    
}

@end

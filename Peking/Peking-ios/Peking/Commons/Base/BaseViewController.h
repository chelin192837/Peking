//
//  BaseViewController.h
//  OneDoor
//
//  Created by coderGL on 16/7/12.
//  Copyright © 2016年 Yujing. All rights reserved.
//


#import <UIKit/UIKit.h>
//#import "RSDLocationCityToolResponse.h"
//#import "SDSmallSevenButton.h"
#import "UIScrollView+EmptyDataSet.h"

#define BottomBarViewHeight 49



@interface BaseViewController : UIViewController<DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

//空数据页面的title -- 可不传，默认为：暂无任何数据
@property(nonatomic,strong) NSString *noDataTitle;
//空数据页面的图片 -- 可不传，默认图片为：NoData
@property(nonatomic,strong) NSString *noDataImgName;

@property(nonatomic,assign)BOOL isNotEnableClick;
/// 无数据时占位图(v4.3)
@property (nonatomic,strong) UIImageView *noDataImage;
/// 当前栏目为本地城市，且没有筛选时，无数据时占位图(v4.3.2)
@property (nonatomic,strong) UIView *noDataImageNew;

@property (nonatomic,strong) UIView * noDataOfSearch;

@property (nonatomic,strong) UIView * noDataOfSearchNormal;

@property (nonatomic,strong) UIView * noDataOfNoteSearch;

@property (nonatomic,strong) UIView * noDataOfNoteMainVC;

@property (nonatomic,strong) UIView * noDataOfNoteScreenVC;

//base类里面 带有Button的类 placeholder empty
@property (nonatomic,strong) UIView * noDataLabel_Image_Button;

@property (nonatomic,strong) UIView * emptyPlaceHolderView;

//无网络页面
@property (nonatomic, strong) UIButton *noNetworkRefreshButton;
- (void)setupNoNetworkHalfBgView:(UIView *)currentView halfOfHeight:(CGFloat)height;
- (void)hideNoNetworkBgView;
- (void)noNetworkRefreshClick;


/// 当前选择的城市
//@property (nonatomic,strong) RSDLocationCityToolModel *selectedCityModel;
///// 定位的区域
//@property (nonatomic,strong) RSDLocationCityToolModel *locationAreaModel;
/// 认证通过
@property (nonatomic,assign) BOOL isAudited;
/// 浮动GIF
//@property (nonatomic, strong) SDSmallSevenButton *sevenBtn;

@property (nonatomic, strong) UIButton        *navigationLeftBtn;//导航栏左侧返回按钮
@property (nonatomic, strong) UIButton        *navigationRightBtn;//导航栏右侧按钮
@property (nonatomic, strong) UIBarButtonItem *navigationRight;//导航栏右侧按钮
@property (nonatomic, strong) UILabel         *navigationTitleLabel;
@property (nonatomic, strong) UIButton        *bottomBtn;//底部按钮
@property (nonatomic, strong) UIView          *bottomBgView;//底部按钮背景view
/// 下拉刷新 GIF图 数组
@property (nonatomic,strong) NSArray *refreshImageArray;

///滚动到底部
- (void)scrollViewToBottom:(UITableView*)tableView;

#pragma mark - 导航栏返回按钮
/**
 *  初始化导航栏返回按钮及标题
 *
 *  @param title      返回标题
 *  @param imagename  按钮箭头
 *  @param titleColor 标题颜色
 *  @param ifBelong   是否为Tabbarcontroller
 */
-(void)initNavigationLeftButtonBackWithTitle:(NSString *)title imagename:(NSString *)imagename titleColor:(NSString *)titleColor IfBelongTabbar:(BOOL)ifBelong;
/**
 *  初始化导航栏返回按钮及标题
 *
 *  @param title    返回标题
 *  @param ifBelong 是否为Tabbarcontroller
 */
-(void)initNavigationLeftButtonBackWithTitle:(NSString *)title IfBelongTabbar:(BOOL)ifBelong;
/**
 *  更新导航栏左边按钮标题
 *
 *  @param title e
 */
-(void)updateNavLeftButtonTitle:(NSString *)title;
/**
 *  初始化导航栏返回按钮及标题
 *
 *  @param title      返回标题
 *  @param isNeed     是否需要图片
 *  @param imagename  图片名字
 *  @param titleColor 标题颜色
 */
-(void)initNavigationLeftBtnWithTitle:(NSString *)title isNeedImage:(BOOL)isNeed andImageName:(NSString *)imagename titleColor:(NSString *)titleColor;

#pragma mark - 导航栏右侧按钮
/**
 *  导航栏右侧按钮
 */
- (void)initNavigationRightButtonWithImageArray:(NSArray *)imageArray;
- (void)initNavigationRightButtonWithTitle:(NSString *)rightTitle backColor:(UIColor *)backColor;
/// 用文字以及字体颜色设置导航栏右上角按钮
-(void)initNavigationRightButtonWithTitle:(NSString *)title titileColor:(UIColor *)titleColor;
/// 用图片设置导航栏右上角按钮
- (void)initNavigationRightButtonWithImage:(NSString *)imageName;
- (void)initNavigationRightButtonWithTitle:(NSString *)title titileColor:(UIColor *)titleColor WithImage:(UIImage *)image withHighLightImage:(UIImage *)highImage;
- (void)initNavigationRightButtonWithTitle:(NSString *)title titileColor:(UIColor *)titleColor WithBackImage:(UIImage *)image;
- (void)initNavigationRightButtonWithBackImage:(UIImage *)image;
-(void)updateNavRightButtonTitle:(NSString *)title;
-(void)doRightBtnAction;
- (void)doRightBtnClick:(UIButton *)sender;
-(void)backTo;


/**
 Created by qhy
 */

- (void)initNavLeftAndRightBtnWithTitle:(NSString *)title 
                             titleColor:(UIColor *)color 
                              titlefont:(float)font 
                               leftSide:(BOOL)leftSide;

- (void)initNavLeftAndRightBtnWithImage:(UIImage *)image 
                               leftSide:(BOOL)leftSide;

/**
 *  带有boder边的style
 *
 *  @param title 
 */
- (void)initNavigationRightButtonWithBoderStyleAndTitle:(NSString *)title;

#pragma mark -  导航栏标题
/**
 *  初始化导航栏标题
 *
 *  @param title    标题
 *  @param ifBelong
 */
-(void)initNavigationTitleViewLabelWithTitle:(NSString *)title IfBelongTabbar:(BOOL)ifBelong;
-(void)initNavigationTitleViewLabelWithTitle:(NSString *)title titleColor:(UIColor *)titleColor IfBelongTabbar:(BOOL)ifBelong;
- (void)initNavRightBtnWithTitle:(NSString *)title titleColor:(UIColor *)color titleFont:(CGFloat)font btnImage:(NSString *)imageStr;
#pragma mark - tableView
/**
 *  去除tableview多余cell的分割线小技巧
 *
 *  @param tableView
 */
-(void)setExtraCellLineHidden: (UITableView *)tableView;
/**
 *  给tableview添加‘无内容’代理
 *
 *  @param tab
 */
-(void)addDefaultEmptyDataSet:(UITableView *)ableView;
-(void)removeDefaultEmptyDataSet:(UITableView *)ableView;

#pragma mark - bottomBtn
-(void)addBottomBtnWithTitle:(NSString *)title titleColor:(UIColor *)titleColor bgColor:(UIColor *)bgColor andImage:(UIImage *)image;

- (void)doBottomAction;

/**
 调用这两个方法必须调用上面的 添加bottomBtn方法添加button addBottomBtnWithTitle
 设置bottomBtn 状态  
 */
- (void) setBottomBtnEnable:(BOOL) enable;

/**
 @param color a
 @param enableBgColor a
 @param disableTitleColor  a
 @param disableBGColor a
 */
- (void) setBottomBtnEnableTitleColor:(UIColor *)color enableBgColor:(UIColor *) enableBgColor disableTitleColor:(UIColor *) disableTitleColor disableBGColor:(UIColor *) disableBGColor;

#pragma makr - 设置无数据时占位图

- (void)setupNoDataImageView:(UIView *)currentView;
- (void)hideNoDataImageView;

//首页楼盘定位失败时，去跳转页面
- (void)setupNoDataImageViewNew:(UIView *)currentView;
- (void)hideNoDataImageViewNew;

- (void)setupNoDataLabel_Image_Button:(UIView *)currentView
                                 Text:(NSString*)text
                                Image:(NSString*)image
                               Button:(NSString*)buttonTitle;
- (void)hideNoDataLabel_Image_Button ;

//emptyPlaceHolderView 初始化方法和隐藏方法
- (void)setupEmptyPlaceHolderView:(UIView *)currentView
                                 ImageName:(NSString*)imageName
                                 ImageMargin:(CGFloat)imageMargin
                                 MainTitle:(NSString*)mainTitle
                                 MainTitleMargin:(CGFloat)mainTitleMargin
                                 MainTitleWidth:(CGFloat)mainTitleWidth
                                 Subtitle:(NSString*)subtitle
                                 SubtitleMargin:(CGFloat)subtitleMargin
                                 SubTitleWidth:(CGFloat)subTitleWidth
                                 Button:(NSString*)buttonTitle
                                 ButtonMargin:(CGFloat)buttonMargin
                                 ButtonWidth:(CGFloat)buttonWidth
                                 ButtonHeight:(CGFloat)buttonHeight;

- (void)hideEmptyPlaceHolderView ;

//目前通用
- (void)setupNoDataOfSearch:(UIView *)currentView;
- (void)hideNoDataOfSearch;


//Biconome占位图
- (void)setupNoDataOfSearchBiconome:(UIView *)currentView With:(CGFloat)topMargin;
- (void)hideNoDataOfSearchBiconome;




- (void)setupNoDataOfSearchNormal:(UIView *)currentView;
- (void)hideNoDataOfSearchNormal;

- (void)setupNoDataOfNoteSearch:(UIView *)currentView Text:(NSString*)text ;
- (void)hideNoDataOfNoteSearch;

- (void)setupNoDataOfNoteScreen:(UITableView *)currentView;
- (void)hideNoDataOfNoteScreen;



//见客笔记主页的无数据占位图
- (void)setupNoDataOfNoteMain:(UIView *)currentView ;

- (void)hideNoDataOfNoteMain;

//无数据时，点击button时跳转的方法 ;
-(void)EmptyBtnClick;


//无数据时，点击button时跳转的方法 ～～ 通用
-(void)EmptyButtonClick;


#pragma makr - 设置小七按钮
- (void)setupSevenBtnDIF;
- (void)redPackageButtonTouchAction;

/**
 键盘事件监听

 @param open 
 */
- (void) setupIQKbordManager:(BOOL)open;

- (void) setHidenNavTitle:(NSString *) title;

/**
 禁止右滑手势

 @param enable 
 */
- (void) interactivePopGestureRecognizer:(BOOL) enable;

-(void)dismissToRootViewController;


@end

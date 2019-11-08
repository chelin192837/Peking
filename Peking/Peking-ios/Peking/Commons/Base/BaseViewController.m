//
//  BaseViewController.m
//  OneDoor
//
//  Created by coderGL on 16/7/12.
//  Copyright © 2016年 Yujing. All rights reserved.
//

#import "BaseViewController.h"
#import "NSString+Extend.h"
#import "UIColor+Extend.h"
#import "UIImage+BSExtension.h"
#import <ImageIO/ImageIO.h>
#import "UIButton+WHButton.h"

//#import "RSDLouPanVC.h"
//#import "RSDAddNoteController.h"
@interface BaseViewController ()
{
    UIColor *bottomTitleColor;
    UIColor *bottomBGColor;
    UIColor *bottomDisableTitleColor;
    UIColor *bottomDisableBGColor;
}

//无网络页面
@property (nonatomic, strong) UIImageView *noNetworkBgImg;
@property (nonatomic, strong) UILabel *noNetworkDescriLabel;
@property (nonatomic, strong) UIView *customNav;// 自定义透明nav
@property (nonatomic, strong) UILabel *customTitleLab;// title

@end

@implementation BaseViewController

#pragma mark - tableView
/// 去除tableview多余cell的分割线小技巧
-(void)setExtraCellLineHidden: (UITableView *)tableView{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
/// 给tableview添加‘无内容’代理
-(void)addDefaultEmptyDataSet:(UITableView *)tableView{
    if (tableView) {
        tableView.emptyDataSetDelegate=self;
        tableView.emptyDataSetSource=self;
    }
}
-(void)removeDefaultEmptyDataSet:(UITableView *)tableView{
    if (tableView) {
        tableView.emptyDataSetDelegate=nil;
        tableView.emptyDataSetSource=nil;
    }
}
#pragma mark -- DZNEmptyDataSet -- 
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    
    if (self.noDataImgName) {
        return [UIImage imageNamed:self.noDataImgName];
    }
    return [UIImage imageNamed:@"fenleiWeikongyeIcon"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSString *title = @"暂无任何数据";
    if (self.noDataTitle) {
        title = self.noDataTitle;
    }
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName:SDColorGrayAAAAAA
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}


- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}
#pragma makr - 滚动到底部
- (void)scrollViewToBottom:(UITableView*)tableView;
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (tableView.contentSize.height > tableView.frame.size.height)
        {
            CGPoint offset = CGPointMake(0, tableView.contentSize.height -tableView.frame.size.height);
            
            [tableView setContentOffset:offset animated:YES];
        }
    });
}


#pragma MLFloatButtonDelegate
-(void)redPackageButtonTouchAction{

}
#pragma makr - 无网络时占位图
- (UIImageView *)noNetworkBgImg{
    if (!_noNetworkBgImg) {
        _noNetworkBgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"picNone"]];
        _noNetworkBgImg.frame = CGRectMake(0, 0, kScreenWidth, 290);
    }
    return _noNetworkBgImg;
}

- (UIButton *)noNetworkRefreshButton{
    if (!_noNetworkRefreshButton) {
        _noNetworkRefreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _noNetworkRefreshButton.frame = CGRectMake((kScreenWidth-124)/2, 50+30+160+52+25, 124, 36);
        _noNetworkRefreshButton.layer.masksToBounds = YES;
        _noNetworkRefreshButton.layer.cornerRadius = 3.0;
        _noNetworkRefreshButton.layer.borderWidth = 1.0;
        _noNetworkRefreshButton.layer.borderColor = DefaultColorOfGreen.CGColor;
        _noNetworkRefreshButton.backgroundColor = rgba(255, 255, 255, 0.5);
        [_noNetworkRefreshButton setTitleColor:DefaultColorOfGreen forState:UIControlStateNormal];
        [_noNetworkRefreshButton setTitle:@"点击刷新" forState:UIControlStateNormal];
        [_noNetworkRefreshButton addTarget:self action:@selector(noNetworkRefreshClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _noNetworkRefreshButton;
}
- (UILabel *)noNetworkDescriLabel{
    if (!_noNetworkDescriLabel) {
        _noNetworkDescriLabel = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth-280)/2, 50+30+160+52+25+36+30, 280, 100)];
        _noNetworkDescriLabel.font = [UIFont systemFontOfSize:14];
        _noNetworkDescriLabel.textAlignment = NSTextAlignmentCenter;
        _noNetworkDescriLabel.textColor = hexColor(aaaaaa);
        _noNetworkDescriLabel.numberOfLines = 5;
        _noNetworkDescriLabel.text = @"七扇门是中国第一家房产经纪人生态平台。解决房产经纪人手中浪费资源变现问题，同时解决开发商、代理公司、装修公司、金融机构的精准拓客问题。打造中国最具专业性、影响力的独立经纪人平台。";
    }
    return _noNetworkDescriLabel;
}

- (void)noNetworkRefreshClick{
    
}
- (void)setupNoNetworkHalfBgView:(UIView *)currentView halfOfHeight:(CGFloat)height{
//    currentView.backgroundColor = SDColorBGGrayF3F4F5 ;
    [currentView addSubview:self.noNetworkBgImg];
    [currentView addSubview:self.noNetworkRefreshButton];
    [currentView addSubview:self.noNetworkDescriLabel];
    [self.noNetworkBgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(currentView);
        make.top.equalTo(currentView.mas_top).offset(height);
        make.height.equalTo(@(290));
    }];
    [self.noNetworkRefreshButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(currentView.mas_centerX);
        make.top.equalTo(self.noNetworkBgImg.mas_bottom).offset(25);
        make.width.equalTo(@125);
        make.height.equalTo(@36);
    }];
    if (is_iPhoneX) {
        [self.noNetworkRefreshButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.noNetworkBgImg.mas_bottom).offset(66);
        }];
    }
    [self.noNetworkDescriLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(currentView.mas_centerX);
        make.top.equalTo(self.noNetworkRefreshButton.mas_bottom).offset(35);
        make.width.equalTo(@(280*kScaleWidth));
        make.height.equalTo(@(100));
    }];
}
- (void)hideNoNetworkBgView{
    [self.noNetworkBgImg removeFromSuperview];
    [self.noNetworkRefreshButton removeFromSuperview];
    [self.noNetworkDescriLabel removeFromSuperview];
}

#pragma makr - 设置无数据时占位图 v423发现
- (UIImageView *)noDataImage{
    if (!_noDataImage) {
        _noDataImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fenleiWeikongyeIcon"]];
//        _noDataImage.frame = CGRectMake((kScreenWidth - 133*kScaleWidth)/2 *kScaleWidth, (kScreenHeight - 125*kScaleHeight - 180)/2 *kScaleHeight, 133*kScaleWidth, 125*kScaleHeight);
        _noDataImage.frame = CGRectMake(0, 0, kScreenWidth, 265*kScaleWidth);
    }
    return _noDataImage;
}
- (void)setupNoDataImageView:(UIView *)currentView{
    if (![self.noDataImage isMemberOfClass:[currentView class]]) {
        currentView.backgroundColor = kGrayBacground ;
        [currentView addSubview:self.noDataImage];
    }
}
-(void)hideNoDataImageView {
    
    [self.noDataImage removeFromSuperview];
    self.noDataImage = nil ;
}


-(UIView*)noDataImageNew
{
    if (!_noDataImageNew) {
        
        _noDataImageNew = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _noDataImageNew.backgroundColor = [UIColor whiteColor] ;
        
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill ;
        imageView.image = [UIImage imageNamed:@"homeBendiloupanWeikongBg"];
        [_noDataImageNew addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_noDataImageNew);
            make.top.equalTo(_noDataImageNew);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 310)) ;
        }];
        
//        UILabel * label = [[UILabel alloc] init];
//        label.text = @"您所选的城市还未拥有楼盘快去发布楼盘吧！" ;
//        label.font = [UIFont systemFontOfSize:18];
//        label.numberOfLines = 0 ;
//        label.textAlignment = NSTextAlignmentCenter ;
//        label.textColor = rgb(170, 170, 170) ;
//        [_noDataImageNew addSubview:label];
//        [label mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(_noDataImageNew);
//            make.top.equalTo(imageView.mas_bottom).offset(37*kScaleHeight);
//            make.width.mas_equalTo(217*kScaleWidth);
//        }];
        
        UIButton * button = [[UIButton alloc] init];
        button.backgroundColor = SDColorOfGreen00AF36 ;
        [button addTarget:self action:@selector(ToRelease:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"去发布" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.layer.cornerRadius = 3.0 ;
        button.layer.masksToBounds = YES ;
        [_noDataImageNew addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_noDataImageNew);
            make.top.equalTo(imageView.mas_bottom).offset(32*kScaleHeight);
            make.size.mas_equalTo(CGSizeMake(227*kScaleWidth, 42*kScaleHeight));
        }];
    }
    return _noDataImageNew;
}
- (void)setupNoDataImageViewNew:(UIView *)currentView
{
    currentView.backgroundColor = SDColorBGGrayF3F4F5 ;
    [currentView addSubview:self.noDataImageNew] ;
}
- (void)hideNoDataImageViewNew
{
    [self.noDataImageNew removeFromSuperview];
    self.noDataImageNew = nil;
}

//带Button的
-(UIView*)noDataLabel_Image_ButtonText:(NSString*)text
                                 Image:(NSString*)image
                                Button:(NSString*)buttonTitle
{
    if (!_noDataLabel_Image_Button) {
        
        _noDataLabel_Image_Button = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBar_Height)];
        
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:image];
        [_noDataLabel_Image_Button addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_noDataLabel_Image_Button);
            make.top.equalTo(_noDataLabel_Image_Button).offset(106*kScaleHeight);
            make.size.mas_equalTo(CGSizeMake(133*kScaleWidth, 125*kScaleHeight)) ;
        }];
        
        UILabel * label = [[UILabel alloc] init];
        label.text = text ;
        label.font = [UIFont systemFontOfSize:18];
        label.numberOfLines = 0 ;
        label.textAlignment = NSTextAlignmentCenter ;
        label.textColor = rgb(170, 170, 170) ;
        [_noDataLabel_Image_Button addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_noDataLabel_Image_Button);
            make.top.equalTo(imageView.mas_bottom).offset(37*kScaleHeight);
            make.width.mas_equalTo(217*kScaleWidth);
        }];
        
        UIButton * button = [[UIButton alloc] init];
        button.backgroundColor = SDColorOfGreen00AF36 ;
        [button addTarget:self action:@selector(EmptyBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:buttonTitle forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.layer.cornerRadius = 3.0 ;
        button.layer.masksToBounds = YES ;
        [_noDataImageNew addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_noDataLabel_Image_Button);
            make.top.equalTo(label.mas_bottom).offset(60*kScaleHeight);
            make.size.mas_equalTo(CGSizeMake(227*kScaleWidth, 42*kScaleHeight));
        }];
    }
    return _noDataLabel_Image_Button;
}

-(void)EmptyBtnClick
{
    
}
- (void)setupNoDataLabel_Image_Button:(UIView *)currentView
                                  Text:(NSString*)text
                                Image:(NSString*)image
                               Button:(NSString*)buttonTitle
{
    currentView.backgroundColor = SDColorBGGrayF3F4F5 ;
    [currentView addSubview:[self noDataLabel_Image_ButtonText:text Image:image Button:buttonTitle]];
}
- (void)hideNoDataLabel_Image_Button
{
    [self.noDataLabel_Image_Button removeFromSuperview];
    self.noDataLabel_Image_Button = nil;
}


//通用为空页方法
- (UIView*)emptyPlaceHolderView:(UIView *)currentView
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
                   ButtonHeight:(CGFloat)buttonHeight
{
    if (!_emptyPlaceHolderView) {
        
        _emptyPlaceHolderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBar_Height)];
        
 
       
        //图片
        UIImageView *imageView=[[UIImageView alloc] init];
        
        if(imageName){
            imageView.image=[UIImage imageNamed:imageName];
            imageView.frame=CGRectMake((KScreenWidth-160)/2, imageMargin, 160, 160);
            [_emptyPlaceHolderView addSubview:imageView];
        }
 
        
        //主标题
        UILabel * mainTitleL = [[UILabel alloc] init];
        mainTitleL.text = mainTitle?:@"";
        mainTitleL.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
        mainTitleL.numberOfLines = 0 ;
        mainTitleL.textAlignment = NSTextAlignmentCenter ;
        mainTitleL.textColor = kBoardTextColor ;
        if (mainTitle) {
            mainTitleL.frame=CGRectMake((KScreenWidth-mainTitleWidth)/2, CGRectGetMaxY(imageView.frame)+mainTitleMargin, mainTitleWidth, 20);
            [_emptyPlaceHolderView addSubview:mainTitleL];
        }

        
        //副标题
        UILabel * subTitleL = [[UILabel alloc] init];
        subTitleL.text = subtitle?:@"";
        subTitleL.font = [UIFont systemFontOfSize:14];
        subTitleL.numberOfLines = 0 ;
        subTitleL.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        subTitleL.textAlignment = NSTextAlignmentCenter ;
        subTitleL.textColor = kBICGetHomeBtcKindColor ;
        if (subtitle) {
            subTitleL.frame=CGRectMake((KScreenWidth-subTitleWidth)/2, CGRectGetMaxY(mainTitleL.frame)+subtitleMargin, subTitleWidth, 20);
            [_emptyPlaceHolderView addSubview:subTitleL];
        }
        
        
        //底部按钮
        UIButton * button = [[UIButton alloc] init];
        button.backgroundColor = [UIColor clearColor] ;
        button.layer.borderWidth=1.f;
        button.layer.borderColor = kBICGetHomeBtcKindColor.CGColor;
        [button addTarget:self action:@selector(EmptyButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:buttonTitle forState:UIControlStateNormal];
        [button setTitleColor:kBoardTextColor forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16.f];
        button.layer.cornerRadius = 4.0 ;
        button.layer.masksToBounds = YES ;
        if (buttonTitle) {
            button.frame=CGRectMake((KScreenWidth-buttonWidth)/2, CGRectGetMaxY(subTitleL.frame)+buttonMargin, buttonWidth, buttonHeight);
            [_emptyPlaceHolderView addSubview:button];
        }
    }
    return _emptyPlaceHolderView;
}

-(void)EmptyButtonClick
{
    
}
//self setupEmptyPlaceHolderView:
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
                     ButtonHeight:(CGFloat)buttonHeight

{
    currentView.backgroundColor = SDColorBGGrayF3F4F5 ;
    [currentView addSubview:[self emptyPlaceHolderView:currentView ImageName:imageName ImageMargin:imageMargin MainTitle:mainTitle MainTitleMargin:mainTitleMargin MainTitleWidth:mainTitleWidth Subtitle:subtitle SubtitleMargin:subtitleMargin SubTitleWidth:subTitleWidth Button:buttonTitle ButtonMargin:buttonMargin ButtonWidth:buttonWidth ButtonHeight:buttonHeight]];
}
- (void)hideEmptyPlaceHolderView
{
    [self.emptyPlaceHolderView removeFromSuperview];
    self.emptyPlaceHolderView = nil;
}
////
////
////
////
////

////？？？
- (UIView *)noDataOfSearch:(UIView *)currentView
{
    if (!_noDataOfSearch) {
        _noDataOfSearch = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, currentView.height)];
        _noDataOfSearch.backgroundColor = [UIColor whiteColor];
        [currentView addSubview:_noDataOfSearch];
//        [_noDataOfSearch mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(currentView);
//            make.top.equalTo(currentView).offset(-20);
//            make.left.right.bottom.equalTo(currentView);
//        }];
        
        UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list_null"]];
        [_noDataOfSearch addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self->_noDataOfSearch);
            make.top.equalTo(self->_noDataOfSearch).offset(124);
            make.width.equalTo(@160);
            make.height.equalTo(@(160));
            
        }];
        
        UILabel * label = [[UILabel alloc] init];
        label.hidden = YES;
        label.text = LAN(@"暂无搜索结果") ;
        label.textColor = hexColor(95979D);
        label.font = [UIFont systemFontOfSize:14.f weight:UIFontWeightMedium];
        [_noDataOfSearch addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self->_noDataOfSearch);
            make.top.equalTo(imageView.mas_bottom).offset(2);
        }];
    }
    return _noDataImage;
}

////normal
- (UIView *)noDataOfSearchNormal:(UIView *)currentView
{
    if (!_noDataOfSearchNormal) {
        _noDataOfSearchNormal = [[UIView alloc] init];
        _noDataOfSearchNormal.backgroundColor = [UIColor clearColor];
        [currentView addSubview:_noDataOfSearchNormal];
        [_noDataOfSearchNormal mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(currentView);
            make.top.equalTo(currentView).offset(0);
            make.left.right.bottom.equalTo(currentView);
        }];
        
        UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fenleiWeikongyeIcon"]];
        [_noDataOfSearchNormal addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_noDataOfSearchNormal);
            make.top.equalTo(_noDataOfSearchNormal).offset(0);
            make.width.equalTo(@(kScreenWidth));
            make.height.equalTo(@(265*kScaleWidth));
            
        }];
        
        UILabel * label = [[UILabel alloc] init];
        label.text = @"未找到您搜索的相关信息" ;
        label.textColor = rgb(204, 204, 204);
        label.font = [UIFont systemFontOfSize:18.f weight:UIFontWeightMedium];
        [_noDataOfSearchNormal addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_noDataOfSearchNormal);
            make.top.equalTo(imageView.mas_bottom).offset(15);
        }];
    }
    return _noDataImage;
}

#pragma mark---- main bg -- Biconome ---
- (void)setupNoDataOfSearch:(UIView *)currentView
{
    if (![self.noDataOfSearch isMemberOfClass:[currentView class]]) {
        currentView.backgroundColor = [UIColor whiteColor] ;
        currentView.superview.backgroundColor = [UIColor whiteColor] ;
        [self noDataOfSearch:currentView];
    }
}

- (void)hideNoDataOfSearch
{
    self.noDataOfSearch.superview.superview.backgroundColor =kBICMainListBGColor ;
    [self.noDataOfSearch removeFromSuperview];
    self.noDataOfSearch = nil;
}
///////////////
#pragma mark---- main bg -- Biconome ---
- (void)setupNoDataOfSearchBiconome:(UIView *)currentView With:(CGFloat)topMargin
{
    if (![self.noDataOfSearch isMemberOfClass:[currentView class]]) {
        currentView.backgroundColor = [UIColor whiteColor] ;
        currentView.superview.backgroundColor = [UIColor whiteColor] ;
        [self noDataOfSearchBiconome:currentView With:topMargin];
    }
}
- (void)hideNoDataOfSearchBiconome
{
    self.noDataOfSearch.superview.superview.backgroundColor =kBICMainListBGColor ;
    [self.noDataOfSearch removeFromSuperview];
    self.noDataOfSearch = nil;
}

///////////////
////？？？
- (UIView *)noDataOfSearchBiconome:(UIView *)currentView With:(CGFloat)topMargin
{
    if (!_noDataOfSearch) {
        _noDataOfSearch = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, currentView.height)];
        _noDataOfSearch.backgroundColor = [UIColor whiteColor];
        [currentView addSubview:_noDataOfSearch];
   
        UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list_null"]];
        [_noDataOfSearch addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self->_noDataOfSearch);
            make.top.equalTo(self->_noDataOfSearch).offset(topMargin);
            make.width.equalTo(@160);
            make.height.equalTo(@(160));
            
        }];
        
        UILabel * label = [[UILabel alloc] init];
        label.hidden = YES;
        label.text = LAN(@"暂无搜索结果") ;
        label.textColor = hexColor(95979D);
        label.font = [UIFont systemFontOfSize:14.f weight:UIFontWeightMedium];
        [_noDataOfSearch addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self->_noDataOfSearch);
            make.top.equalTo(imageView.mas_bottom).offset(2);
        }];
    }
    return _noDataImage;
}

///////////////
- (void)setupNoDataOfSearchNormal:(UIView *)currentView
{
    if (![self.noDataOfSearchNormal isMemberOfClass:[currentView class]]) {
        currentView.backgroundColor = SDColorBGGrayF3F4F5 ;
        [self noDataOfSearchNormal:currentView];
    }
}
- (void)hideNoDataOfSearchNormal
{
    [self.noDataOfSearchNormal removeFromSuperview];
    self.noDataOfSearchNormal = nil;
}


- (void)setupNoDataOfNoteScreen:(UITableView *)currentView
{
    if (![self.noDataOfNoteScreenVC isMemberOfClass:[currentView class]]) {
//        currentView.backgroundColor = SDColorBGGrayF3F4F5 ;
        [self noDataOfNoteScreen:currentView];
    }
}
- (void)hideNoDataOfNoteScreen
{
    [self.noDataOfNoteScreenVC removeFromSuperview];
    self.noDataOfNoteScreenVC = nil;
}
- (void)noDataOfNoteScreen:(UITableView *)currentView
{
    if (!_noDataOfNoteScreenVC) {
        _noDataOfNoteScreenVC = [[UIView alloc] initWithFrame:CGRectMake(0, currentView.tableHeaderView.frame.size.height, currentView.frame.size.width, currentView.frame.size.height)];
        _noDataOfNoteScreenVC.backgroundColor = SDColorBGGrayF3F4F5;
        [currentView addSubview:_noDataOfNoteScreenVC];
//        [_noDataOfNoteScreenVC mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.equalTo(currentView);
//            make.top.equalTo(currentView);
//            make.bottom.equalTo(currentView);
//            make.centerX.equalTo(currentView);
//        }];
        
        UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fenleiWeikongyeIcon"]];
        [_noDataOfNoteScreenVC addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_noDataOfNoteScreenVC);
            make.top.equalTo(_noDataOfNoteScreenVC).offset(0);
            make.width.equalTo(@(kScreenWidth));
            make.height.equalTo(@(265*kScaleWidth));
        }];
        
        UILabel * label = [[UILabel alloc] init];
        NSString *str = @"没有对应筛选内容～";
        label.text = str ;
        label.numberOfLines = 0 ;
        label.textColor = rgb(170, 170, 170);
        label.textAlignment = NSTextAlignmentCenter ;
        label.font = [UIFont systemFontOfSize:16.f weight:UIFontWeightMedium];
        [_noDataOfNoteScreenVC addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_noDataOfNoteScreenVC);
            make.width.equalTo(@222.5);
            make.top.equalTo(imageView.mas_bottom).offset(27*kScaleHeight);
        }];

    }
}
//抱歉！列表内没有关于“王成芳”的相关
//搜索项，您可以重新搜索其他内容～
#pragma mark -- 见客笔记的搜索占位页
- (void)setupNoDataOfNoteSearch:(UIView *)currentView Text:(NSString*)text
{
    if (![self.noDataOfNoteSearch isMemberOfClass:[currentView class]]) {
//        currentView.backgroundColor = SDColorBGGrayF3F4F5 ;
        [self noDataOfNoteSearch:currentView Text:(NSString*)text];
    }
}

- (void)hideNoDataOfNoteSearch
{
    [self.noDataOfNoteSearch removeFromSuperview];
    self.noDataOfNoteSearch = nil;
}
- (UIView *)noDataOfNoteSearch:(UIView *)currentView Text:(NSString*)text
{
    if (!_noDataOfNoteSearch) {
        _noDataOfNoteSearch = [[UIView alloc] init];
        _noDataOfNoteSearch.backgroundColor = [UIColor clearColor];
        [currentView addSubview:_noDataOfNoteSearch];
        [_noDataOfNoteSearch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(currentView);
            make.centerX.equalTo(currentView);
            make.top.equalTo(currentView).offset(0);
        }];
        
        UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fenleiWeikongyeIcon"]];
        [_noDataOfNoteSearch addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_noDataOfNoteSearch);
            make.top.equalTo(_noDataOfNoteSearch).offset(0);
            make.left.right.equalTo(_noDataOfNoteSearch);
            make.height.equalTo(@(265*kScaleWidth));
        }];
        
        UILabel * label = [[UILabel alloc] init];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"抱歉！列表内没有关于“%@”的相关搜索项，您可以重新搜索其他内容～",text]];
        [str addAttribute:NSForegroundColorAttributeName value:rgb(204, 204, 204) range:NSMakeRange(0,10)];
        [str addAttribute:NSForegroundColorAttributeName value:SDColorOfGreen00AF36 range:NSMakeRange(10,text.length+2)];
        [str addAttribute:NSForegroundColorAttributeName value:rgb(204, 204, 204) range:NSMakeRange(10+text.length+2,19)];
        label.attributedText = str ;
        label.numberOfLines = 0 ;
        label.textAlignment = NSTextAlignmentCenter ;
        label.font = [UIFont systemFontOfSize:16.f weight:UIFontWeightMedium];
        [_noDataOfNoteSearch addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_noDataOfNoteSearch);
            make.width.equalTo(@274);
            make.top.equalTo(imageView.mas_bottom).offset(37*kScaleHeight);
        }];
    }
    return _noDataImage;
}
//见客笔记主页的无数据占位图 noDataOfNoteMainVC
#pragma mark -- 见客笔记主页的占位页
- (void)setupNoDataOfNoteMain:(UIView *)currentView
{
//    if (![self.noDataOfNoteMainVC isMemberOfClass:[currentView class]]) {
//        currentView.backgroundColor = SDColorBGGrayF3F4F5 ;
        [self noDataOfNoteMainVC:currentView];
//    }
}
- (void)hideNoDataOfNoteMain
{
    self.noDataOfNoteMainVC.hidden = YES ;
    [self.noDataOfNoteMainVC removeFromSuperview];
    self.noDataOfNoteMainVC = nil;
}
-(UIView*)noDataOfNoteMainVC
{
    if (!_noDataOfNoteMainVC) {
        _noDataOfNoteMainVC = [[UIView alloc] init];
        
        objc_setAssociatedObject(_noDataOfNoteMainVC, @"ViewName", @"noDataOfNoteMainVC", OBJC_ASSOCIATION_RETAIN_NONATOMIC) ;
        
    }
    return _noDataOfNoteMainVC;
}

- (UIView *)noDataOfNoteMainVC:(UIView *)currentView
{
    if (!_noDataOfNoteMainVC) {
        self.noDataOfNoteMainVC.backgroundColor = SDColorBGGrayF3F4F5;
        [currentView addSubview:self.noDataOfNoteMainVC];
        [self.noDataOfNoteMainVC mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(currentView);
            make.top.equalTo(currentView);
            make.bottom.equalTo(currentView);
            make.centerX.equalTo(currentView);
        }];
        
        UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fenleiWeikongyeIcon"]];
        [self.noDataOfNoteMainVC addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.noDataOfNoteMainVC);
            make.top.equalTo(self.noDataOfNoteMainVC);
            make.width.equalTo(@(kScreenWidth));
            make.height.equalTo(@(265*kScaleWidth));
        }];
        
        UILabel * label = [[UILabel alloc] init];
        NSString *str = @"快来完善客户资源银行，再也不用担心你的见客笔记丢失了。";
        label.text = str ;
        label.numberOfLines = 0 ;
        label.textColor = rgb(170, 170, 170);
        label.textAlignment = NSTextAlignmentCenter ;
        label.font = [UIFont systemFontOfSize:16.f weight:UIFontWeightMedium];
        [_noDataOfNoteMainVC addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_noDataOfNoteMainVC);
//            make.width.equalTo(@(222.5 * kScaleWidth));
            make.left.equalTo(_noDataOfNoteMainVC).offset(72);
            make.right.equalTo(_noDataOfNoteMainVC).offset(-72);
            make.top.equalTo(imageView.mas_bottom).offset(15*kScaleWidth);
        }];
        
        UIButton * button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"bijiTianjiabijiBtn"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(noteBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_noDataOfNoteMainVC addSubview:button];
        
        objc_setAssociatedObject(button, @"currentView", currentView, OBJC_ASSOCIATION_ASSIGN);
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_noDataOfNoteMainVC).offset(-23);
            make.centerX.equalTo(_noDataOfNoteMainVC);
            make.width.height.equalTo(@90);
        }];
        
                UILabel * addL = [[UILabel alloc] init];
                NSString *str1 = @"添加见客笔记";
                addL.text = str1 ;
                addL.numberOfLines = 0 ;
                addL.textColor = SDColorOfGreen00AF36 ;
                addL.textAlignment = NSTextAlignmentCenter ;
                addL.font = [UIFont systemFontOfSize:12.f];
                [_noDataOfNoteMainVC addSubview:addL];
                [addL mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(_noDataOfNoteMainVC);
                    make.bottom.equalTo(button.mas_top).offset(-5*kScaleHeight);
                }];
        
    }
    return _noDataImage;
}


//- (NSArray *)refreshImageArray{
//    if (!_refreshImageArray) {
//        NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"Loading24" withExtension:@"gif"];//newRefreshGif  refreshGif
//        CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef)fileUrl, NULL);
//        size_t frameCout = CGImageSourceGetCount(gifSource);
//        NSMutableArray *frames = [[NSMutableArray alloc] init];
//        for (size_t i=0;i< frameCout;i++){
//            CGImageRef imageRef=CGImageSourceCreateImageAtIndex(gifSource, i, NULL);
//            UIImage* imageName=[UIImage imageWithCGImage:imageRef];
//            [frames addObject:imageName];
//            CGImageRelease(imageRef);
//        }
//        _refreshImageArray = frames.copy;
//    }
//    return _refreshImageArray;
//}

- (NSArray *)refreshImageArray{
    if (!_refreshImageArray) {
        NSMutableArray *frames = [[NSMutableArray alloc] init];
        for (int i=0;i<31;i++){
            UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
            [frames addObject:image];
        }
        _refreshImageArray = frames.copy;
    }
    return _refreshImageArray;
}


- (BOOL)isAudited{
    if (STATUS1 || STATUS8 ||STATUS0) {
        return NO;
    }else{
        return YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCity:) name:kChange_Selected_City object:nil];
    self.automaticallyAdjustsScrollViewInsets = NO;
    

    
    
    
//    self.view.backgroundColor = SDColorBGGrayF3F4F5;
}

#pragma mark - 导航栏返回
-(void)initNavigationLeftButtonBackWithTitle:(NSString *)title imagename:(NSString *)imagename titleColor:(NSString *)titleColor IfBelongTabbar:(BOOL)ifBelong {
    [self initNavigationLeftBtnWithTitle:title isNeedImage:YES andImageName:imagename titleColor:titleColor];
}

-(void)initNavigationLeftButtonBackWithTitle:(NSString *)title IfBelongTabbar:(BOOL)ifBelong{
    [self initNavigationLeftButtonBackWithTitle:title imagename:nil titleColor:nil IfBelongTabbar:ifBelong];
}

-(void)initNavigationLeftBtnWithTitle:(NSString *)title isNeedImage:(BOOL)isNeed andImageName:(NSString *)imagename titleColor:(NSString *)titleColor
{
    _navigationLeftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _navigationLeftBtn.adjustsImageWhenHighlighted = NO;
    _navigationLeftBtn.frame=CGRectMake(0, 0, 88, 17);
//        _navigationLeftBtn.frame=CGRectMake(0, 0, 44, 44);
    if (isNeed) {
        if ([NSString isBlankString:imagename]) {
            if (!imagename) {
                imagename = @"fanhuiBlack";
            }
        }        
        [_navigationLeftBtn setImage:[UIImage imageNamed:imagename] forState:UIControlStateNormal];
        [_navigationLeftBtn.imageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    if ([NSString isBlankString:titleColor]) {
        if (SWITCH_STATUS0) {
            titleColor = @"eeeeee";
        }else{
            titleColor = @"333333";
        }
    }
    if (![NSString isBlankString:title]) {
        [_navigationLeftBtn setTitle:title forState:UIControlStateNormal];
    }
    [_navigationLeftBtn setTitleColor:[UIColor colorWithHexColorString:titleColor] forState:UIControlStateNormal];
    [_navigationLeftBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_navigationLeftBtn sizeToFit];
    if (_navigationLeftBtn.width < 50) {
        _navigationLeftBtn.frame=CGRectMake(0, 0, 24, 24);
        [_navigationLeftBtn setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];
//        _navigationLeftBtn 
//        [_navigationLeftBtn setImageEdgeInsets:UIEdgeInsetsMake(10, -14, 10, 14)];
//        [_navigationLeftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -14, 0, 14)];
//        [_navigationLeftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
    }else{
        _navigationLeftBtn.frame=CGRectMake(0, 0, _navigationLeftBtn.width + 10, 17);
        [_navigationLeftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
    }
    [_navigationLeftBtn addTarget:self action:@selector(backTo) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *cancelBtn=[[UIBarButtonItem alloc] initWithCustomView:_navigationLeftBtn];
    self.navigationItem.leftBarButtonItems=@[cancelBtn];

}

-(void)updateNavLeftButtonTitle:(NSString *)title{
    if (_navigationLeftBtn) {
        [_navigationLeftBtn setTitle:title forState:UIControlStateNormal];
    }else{
        self.navigationItem.rightBarButtonItem.title=title;
    }
}

#pragma mark - 导航栏新定义 Created by qhy
- (void)initNavLeftAndRightBtnWithTitle:(NSString *)title titleColor:(UIColor *)color titlefont:(float)font leftSide:(BOOL)leftSide {
    
    UIButton *btn_side = [UIButton buttonWithType:UIButtonTypeCustom];
    if (leftSide) {
        
        btn_side = _navigationLeftBtn;
    }
    else
    {
        btn_side = _navigationRightBtn;
    }
    
    btn_side=[UIButton buttonWithType:UIButtonTypeCustom];
    
    btn_side.frame=CGRectMake(0, 0, 44, 44);
    [btn_side setTitle:title forState:UIControlStateNormal];
    
    btn_side.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:font];
    [btn_side setTitleColor:color forState:UIControlStateNormal];
    if (SWITCH_STATUS1) {
        [btn_side setTitleColor:kBlackWord forState:UIControlStateNormal];
    }
    
    if (leftSide) {
        [btn_side addTarget:self action:@selector(backTo) forControlEvents:UIControlEventTouchUpInside];
    }
    else{
        [btn_side addTarget:self action:@selector(doRightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIBarButtonItem *sideItem=[[UIBarButtonItem alloc] initWithCustomView:btn_side];
    if (leftSide) {
    
        btn_side.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.navigationItem setLeftBarButtonItem:sideItem];

    }
    else{
        btn_side.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self.navigationItem setRightBarButtonItem:sideItem];
    }
    
}

- (void)initNavRightBtnWithTitle:(NSString *)title titleColor:(UIColor *)color titleFont:(CGFloat)font btnImage:(NSString *)imageStr {
    
    UIButton *btn_side = [UIButton buttonWithType:UIButtonTypeCustom];
 
    btn_side = _navigationRightBtn;
    btn_side = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_side.frame = CGRectMake(0, 0, 84, 20);
    [btn_side setTitle:title forState:UIControlStateNormal];
    btn_side.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:font];
    [btn_side setTitleColor:color forState:UIControlStateNormal];
    [btn_side setBackgroundColor:[UIColor whiteColor]];
    [btn_side.layer setMasksToBounds:YES];
    [btn_side.layer setCornerRadius:10];
//    btn_side.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;

    //通过调节文本和图片的内边距到达目的  
    btn_side.imageEdgeInsets = UIEdgeInsetsMake(6.5, btn_side.width-3.5-9, 6.5, 3.5);  
    
    [btn_side setTitleEdgeInsets:UIEdgeInsetsMake(0, -12, 0, 0)]; 
    
    [btn_side setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    [btn_side addTarget:self action:@selector(doRightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *sideItem=[[UIBarButtonItem alloc] initWithCustomView:btn_side];
   
    [self.navigationItem setRightBarButtonItem:sideItem];

    
}

- (void)initNavLeftAndRightBtnWithImage:(UIImage *)image leftSide:(BOOL)leftSide {
    
    UIButton *btn_side = [UIButton buttonWithType:UIButtonTypeCustom];
    if (leftSide) {
        
        btn_side = _navigationLeftBtn;
    }
    else
    {
        btn_side = _navigationRightBtn;
    }
    
    btn_side=[UIButton buttonWithType:UIButtonTypeCustom];
    
    btn_side.frame=CGRectMake(0, 0, 44, 44);
    [btn_side setImage:image forState:UIControlStateNormal];
    
    if (leftSide) {
        [btn_side addTarget:self action:@selector(backTo) forControlEvents:UIControlEventTouchUpInside];
    }
    else{
        [btn_side addTarget:self action:@selector(doRightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }

    UIBarButtonItem *sideItem=[[UIBarButtonItem alloc] initWithCustomView:btn_side];
    if (leftSide) {
        [btn_side setImageEdgeInsets:UIEdgeInsetsMake(0, -16, 0, 0)];
        [self.navigationItem setLeftBarButtonItem:sideItem];
    }
    else{
        [btn_side setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -30)];
        [self.navigationItem setRightBarButtonItem:sideItem];
    }
}

#pragma mark - 导航栏右侧按钮

- (void)initNavigationRightButtonWithTitle:(NSString *)title titileColor:(UIColor *)titleColor WithImage:(UIImage *)image withHighLightImage:(UIImage *)highImage
{
    
    _navigationRightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _navigationRightBtn.frame=CGRectMake(0, 0, 80, 31);
    _navigationRightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_navigationRightBtn setTitleColor:[UIColor colorWithHexColorString:@"5c6368"] forState:UIControlStateNormal];
    [_navigationRightBtn addTarget:self action:@selector(doRightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_navigationRightBtn setTitle:title forState:UIControlStateNormal];
    if (image) {
        [_navigationRightBtn setImage:image forState:UIControlStateNormal];
        [_navigationRightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -24, 0, 24)];
        [_navigationRightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    }
    if (highImage) {
        [_navigationRightBtn setImage:highImage forState:UIControlStateHighlighted];
    }
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithCustomView:_navigationRightBtn];
    UIBarButtonItem *fixSpace=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixSpace.width=-25;
    self.navigationItem.rightBarButtonItems=@[fixSpace,rightItem];
    
}
- (void)initNavigationRightButtonWithBackImage:(UIImage *)image{
    
    _navigationRightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _navigationRightBtn.frame=CGRectMake(0, 0, 80, 31);
    _navigationRightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_navigationRightBtn setTitleColor:[UIColor colorWithHexColorString:@"5c6368"] forState:UIControlStateNormal];
    [_navigationRightBtn addTarget:self action:@selector(doRightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    if (image) {
        [_navigationRightBtn setImage:image forState:UIControlStateNormal];
    }
    [_navigationRightBtn setImageEdgeInsets:UIEdgeInsetsMake(0,80-image.size.width, 0, 0)];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithCustomView:_navigationRightBtn];
    UIBarButtonItem *fixSpace=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixSpace.width=-25;
    self.navigationItem.rightBarButtonItems=@[fixSpace,rightItem];
    
}


- (void)initNavigationRightButtonWithTitle:(NSString *)title titileColor:(UIColor *)titleColor WithBackImage:(UIImage *)image
{
    
    _navigationRightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _navigationRightBtn.frame=CGRectMake(0, 0, 80, 31);
    _navigationRightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_navigationRightBtn setTitleColor:kGrayWord_Nav forState:UIControlStateNormal];
    [_navigationRightBtn addTarget:self action:@selector(doRightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_navigationRightBtn setTitle:title forState:UIControlStateNormal];
    [_navigationRightBtn setBackgroundImage:image forState:UIControlStateNormal];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithCustomView:_navigationRightBtn];
    UIBarButtonItem *fixSpace=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixSpace.width=-25;
    self.navigationItem.rightBarButtonItems=@[fixSpace,rightItem];
    
}
- (void)initNavigationRightButtonWithBoderStyleAndTitle:(NSString *)title
{
    self.navigationRightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.navigationRightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.navigationRightBtn addTarget:self action:@selector(doRightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationRightBtn setTitle:title forState:UIControlStateNormal];
    self.navigationRightBtn.layer.masksToBounds = YES;
    self.navigationRightBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.navigationRightBtn.layer.borderWidth = 1.f;
    self.navigationRightBtn.layer.cornerRadius = 10.f;
    self.navigationRightBtn.frame = CGRectMake(0, 0, 33, 20);
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithCustomView:self.navigationRightBtn];
    UIBarButtonItem *fixSpace=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixSpace.width=-10;
    self.navigationItem.rightBarButtonItems=@[fixSpace,rightItem];
}

//#MARK: 用图片设置导航栏右上角按钮
- (void)initNavigationRightButtonWithImage:(NSString *)imageName
{
    _navigationRightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _navigationRightBtn.adjustsImageWhenHighlighted = NO;
    [_navigationRightBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [_navigationRightBtn sizeToFit];
    _navigationRightBtn.frame=CGRectMake(0, 0, 80, 44);
    [_navigationRightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, (80-_navigationRightBtn.imageView.size.width)*0.5, 0, -(80-_navigationRightBtn.imageView.size.width)*0.5)];
    [_navigationRightBtn addTarget:self action:@selector(doRightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithCustomView:_navigationRightBtn];
    self.navigationItem.rightBarButtonItems=@[rightItem];
}

//#MARK: 用文字以及字体颜色设置导航栏右上角按钮
- (void)initNavigationRightButtonWithTitle:(NSString *)title titileColor:(UIColor *)titleColor
{
    _navigationRightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_navigationRightBtn setTitle:title forState:UIControlStateNormal];
    _navigationRightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_navigationRightBtn setTitleColor:titleColor forState:UIControlStateNormal];
    _navigationRightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    if (SWITCH_STATUS1) {
        [_navigationRightBtn setTitleColor:kBlackWord forState:UIControlStateNormal];
    }
    [_navigationRightBtn sizeToFit];
    if(_navigationRightBtn.titleLabel.size.width < 100){
        _navigationRightBtn.frame=CGRectMake(0, 0, 85, 44);
//        [_navigationRightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, (100-_navigationRightBtn.titleLabel.size.width)*0.5-10, 0, 0)];
        [_navigationRightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, (85-_navigationRightBtn.titleLabel.size.width)*0.5-10-10-10, 0, 0)];

    }
    [_navigationRightBtn addTarget:self action:@selector(doRightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithCustomView:_navigationRightBtn];
    self.navigationItem.rightBarButtonItems=@[rightItem];
}


- (void)initNavigationRightButtonWithTitle:(NSString *)rightTitle backColor:(UIColor *)backColor
{
    _navigationRightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _navigationRightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_navigationRightBtn setTitle:rightTitle forState:UIControlStateNormal];
    [_navigationRightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_navigationRightBtn sizeToFit];
    _navigationRightBtn.frame=CGRectMake(0, 0, _navigationRightBtn.frame.size.width + 10, 20);
    [_navigationRightBtn setBackgroundColor:backColor];
    _navigationRightBtn.layer.borderColor = kBlackBacground.CGColor;
    _navigationRightBtn.layer.borderWidth = 0.5;
    _navigationRightBtn.layer.cornerRadius = 10;
    _navigationRightBtn.layer.masksToBounds = YES;
    [_navigationRightBtn addTarget:self action:@selector(doRightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithCustomView:_navigationRightBtn];
    UIBarButtonItem *fixSpace=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixSpace.width = -15;
    self.navigationItem.rightBarButtonItems=@[rightItem];
}

- (void)initNavigationRightButtonWithImageArray:(NSArray *)imageArray
{
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i=0; i<imageArray.count; i++) {
        UIButton *nmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [nmBtn setImage:imageArray[i] forState:UIControlStateNormal];
        [nmBtn sizeToFit];
        nmBtn.frame=CGRectMake(0, 0, 22, 22);
        nmBtn.tag = 1000 + i;
        [nmBtn addTarget:self action:@selector(doRightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithCustomView:nmBtn];
        [tempArray addObject:rightItem];
        if (i == 1) {
            _navigationRightBtn = nmBtn;
        }
    }
    self.navigationItem.rightBarButtonItems=tempArray.copy;
}
- (void)doRightBtnClick:(UIButton *)sender{
    
}

- (void)updateNavRightButtonTitle:(NSString *)title
{
    if (_navigationRightBtn) {
        [_navigationRightBtn setTitle:title forState:UIControlStateNormal];
    }else{
        self.navigationItem.rightBarButtonItem.title=title;
    }
}

#pragma mark - 导航栏标题
-(void) initNavigationTitleViewLabelWithTitle:(NSString *)title IfBelongTabbar:(BOOL)ifBelong{
    if (_navigationTitleLabel==nil) {
        _navigationTitleLabel=[[UILabel alloc] init];
        _navigationTitleLabel.textAlignment=NSTextAlignmentCenter;
            _navigationTitleLabel.textColor = kWhiteWord;
            _navigationTitleLabel.font=[UIFont fontWithName:@"PingFangSC-Medium" size:18];

    }
//    if ([NSString isBlankString:title]) {
//        title=NSLocalizedString(NSStringFromClass([self class]), nil);
//    }
    
    CGFloat width = [NSString sizeWithString:title andMaxSize:CGSizeMake(kScreenWidth-100, 44) andFont:[UIFont systemFontOfSize:20  ]].width;
    _navigationTitleLabel.frame=CGRectMake((kScreenWidth-width)/2.0, 0, width, 44);
    _navigationTitleLabel.text=title;
    if (ifBelong) {
        self.tabBarController.navigationItem.titleView=_navigationTitleLabel;
    }else{
        self.navigationItem.titleView=_navigationTitleLabel;
    }
}

-(void)initNavigationTitleViewLabelWithTitle:(NSString *)title titleColor:(UIColor *)titleColor IfBelongTabbar:(BOOL)ifBelong{
    _navigationTitleLabel = nil;

    if (_navigationTitleLabel==nil) {
        _navigationTitleLabel=[[UILabel alloc] init];
        _navigationTitleLabel.textAlignment=NSTextAlignmentCenter;
        _navigationTitleLabel.textColor = titleColor;
        
        _navigationTitleLabel.font=[UIFont systemFontOfSize:18.f weight:UIFontWeightHeavy];
    }
//    if ([NSString isBlankString:title]) {
//        title=NSLocalizedString(NSStringFromClass([self class]), nil);
//    }
    
    CGFloat width = [NSString sizeWithString:title andMaxSize:CGSizeMake(kScreenWidth-100, 44) andFont:_navigationTitleLabel.font].width;
    _navigationTitleLabel.frame=CGRectMake((kScreenWidth-width)/2.0, 0, width, 44);
    _navigationTitleLabel.text=title;
    if (ifBelong) {
        self.tabBarController.navigationItem.titleView=_navigationTitleLabel;
    }else{
        self.navigationItem.titleView=_navigationTitleLabel;
    }
}
#pragma mark - event response
-(void)backTo{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)changeButtonStatus{
    self.isNotEnableClick = NO;
}
- (void)doRightBtnAction
{
    [self performSelector:@selector(changeButtonStatus) withObject:nil afterDelay:1.0f];//防止用户重复点击
}

- (void)doBottomAction
{
    
}


#pragma mark - bottomBtn
- (void)addBottomBtnWithTitle:(NSString *)title titleColor:(UIColor *)titleColor bgColor:(UIColor *)bgColor andImage:(UIImage *)image
{
    UIView *bgView = [[UIView alloc] init];
    if (!bgColor) {
        bgColor = SDColorWhiteFFFFFF;
    }
    bgView.backgroundColor = bgColor;
    [self.view addSubview:bgView];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(kTabBar_Height);
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];

    [btn setBackgroundColor:bgColor];
    if (!titleColor) {
        titleColor = [UIColor whiteColor];
    }
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    if ([NSString isBlankString:title]) {
        title = @"确认";
    }
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(doBottomAction) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
    
    if (image) {
        [btn setImage:image forState:UIControlStateNormal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    }
    [bgView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(bgView);
        make.height.mas_equalTo(kTabBar_Height - TabbarSafeBottomMargin);
    }];
    

    self.bottomBtn = btn;
    self.bottomBgView = bgView;
}


- (void)setBottomBtnEnableTitleColor:(UIColor *)color enableBgColor:(UIColor *)enableBgColor disableTitleColor:(UIColor *)disableTitleColor disableBGColor:(UIColor *)disableBGColor {
    
    bottomTitleColor = color;
    bottomBGColor = enableBgColor;
    bottomDisableTitleColor = disableTitleColor;
    bottomDisableBGColor = disableBGColor;
}

- (void)setBottomBtnEnable:(BOOL)enable {
    
    if (self.bottomBtn) {
        self.bottomBtn.enabled = enable;
        if (enable) {
            [self.bottomBtn setTitleColor:bottomTitleColor forState:UIControlStateNormal];
            self.bottomBtn.backgroundColor = bottomBGColor;
            self.bottomBgView.backgroundColor = bottomBGColor;
        }else{
            [self.bottomBtn setTitleColor:bottomDisableTitleColor forState:UIControlStateNormal];
            self.bottomBtn.backgroundColor = bottomDisableBGColor;
            self.bottomBgView.backgroundColor = bottomDisableBGColor;
        }
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)setupIQKbordManager:(BOOL)open{
    
    if (open) {
        // 开始第三方键盘
        [[IQKeyboardManager sharedManager] setEnable:YES];
        [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = NO;
        [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
        [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    }else{
        // 开始第三方键盘
        [[IQKeyboardManager sharedManager] setEnable:NO];
        [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = NO;
        [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
        // 点击屏幕隐藏键盘
        [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = NO;
    }
}

- (void)setHidenNavTitle:(NSString *)title {
    
    self.customNav.hidden = NO;
    self.customTitleLab.text = title;
}


- (UIView *)customNav {
    
    if (!_customNav) {
        _customNav = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavBar_Height)];
        _customNav.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_customNav];
        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"fanhuiWhite"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_customNav addSubview:backBtn];
        backBtn.frame = CGRectMake(0, kStatusBar_Height, 44, 44);
        
        _customTitleLab = [[UILabel alloc]init];
        _customTitleLab.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
        _customTitleLab.textColor = [UIColor whiteColor];
        _customTitleLab.textAlignment = NSTextAlignmentCenter;
        [_customNav addSubview:_customTitleLab];
        _customTitleLab.frame = CGRectMake(backBtn.right + 10, kStatusBar_Height, kScreenWidth -   2 * backBtn.right - KEdgeDistance, 44);
        _customNav.hidden = YES;
    }
    return _customNav;
}

- (void)backBtnClick:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 禁止右滑手势
 
 @param enable 
 */
- (void) interactivePopGestureRecognizer:(BOOL) enable{
    
    if (enable) {
        // 开启返回手势  
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {  
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;  
        }
    }else{
        // 禁用返回手势  
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {  
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;  
        } 
    }
}

-(void)dismissToRootViewController
{
    UIViewController *vc = self;
    while (vc.presentingViewController) {
        vc = vc.presentingViewController;
    }
    [vc dismissViewControllerAnimated:YES completion:nil];
}

@end












































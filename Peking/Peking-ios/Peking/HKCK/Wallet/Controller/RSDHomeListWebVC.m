//
//  RSDHomeListWebVC.m
//  Agent
//
//  Created by wangliang on 2018/3/15.
//  Copyright © 2018年 七扇门. All rights reserved.
//

#import "RSDHomeListWebVC.h"
#import "UIImage+GIF.h"
#import <ImageIO/ImageIO.h>
@interface RSDHomeListWebVC ()<UIWebViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, copy) NSString *string;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation RSDHomeListWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *navStr = @"";
    if (self.naviStr.length > 0) {
        navStr = self.naviStr;
    }
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];

    [self initNavigationTitleViewLabelWithTitle:navStr titleColor:kNVABICSYSTEMTitleColor IfBelongTabbar:NO];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupSubviews];
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

- (void)setupSubviews
{
//    if (@available(iOS 11.0, *)) {
//        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    } else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    
    CGFloat navHeight = 0.f;
    if(self.navigationShow) {
        navHeight=kNavBar_Height;
    }
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,navHeight, kScreenWidth, kScreenHeight-kNavBar_Height)];
    self.webView.scrollView.delegate=self;
    if (@available(iOS 11.0, *)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
//    self.edgesForExtendedLayout = UIRectEdgeNone;

    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    self.webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    ///19.1.21 此处不转码 str中若有中文无法加载
    NSString * utfStr = [self.listWebStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:utfStr]]];
    [ODAlertViewFactory showLoadingViewWithView:self.view];
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-20)/2, (SCREEN_HEIGHT-kNavBar_Height-20)/2, 20, 20)];
//    imageView.image =[UIImage sd_animatedGIFNamed:@"Loading24-1"];
//    self.imageView = imageView;
//    [[UIApplication sharedApplication].keyWindow addSubview:self.imageView];

}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    
    [[IQKeyboardManager sharedManager] setEnable:NO];
               [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = NO;
               [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
               // 点击屏幕隐藏键盘
               [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.imageView removeFromSuperview];
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
               [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = YES;
               [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
               // 点击屏幕隐藏键盘
               [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;

}
- (void)webViewDidFinishLoad:(UIWebView  *)webView
{
//    [self.imageView removeFromSuperview];
    [ODAlertViewFactory hideAllHud:self.view];
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

@end







//
//  RSDHomeListWebVC.m
//  Agent
//
//  Created by wangliang on 2018/3/15.
//  Copyright © 2018年 七扇门. All rights reserved.
//

#import "BICHomeListWebVC.h"
#import "UIImage+GIF.h"
#import <ImageIO/ImageIO.h>
@interface BICHomeListWebVC ()<UIWebViewDelegate>
//
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, copy) NSString *string;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation BICHomeListWebVC

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

- (void)setupSubviews
{
    if (@available(iOS 11.0, *)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,kNavBar_Height, kScreenWidth, kScreenHeight-kNavBar_Height)];
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    self.webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];

//    self.listWebStr=@"http://192.168.1.121:8848/yanzheng/new_file.html?from=singlemessage";
    ///19.1.21 此处不转码 str中若有中文无法加载
    NSString * utfStr = [self.listWebStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:utfStr]]];

    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-20)/2, (SCREEN_HEIGHT-kNavBar_Height-20)/2, 20, 20)];
    imageView.image =[UIImage sd_animatedGIFNamed:@"Loading24-1"];
    self.imageView = imageView;

    [[UIApplication sharedApplication].keyWindow addSubview:self.imageView];

}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.imageView removeFromSuperview];

}
- (void)webViewDidFinishLoad:(UIWebView  *)webView
{
    [self.imageView removeFromSuperview];
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url = request.URL.absoluteString;
//    NSLog(@"url--%@",url);
    if ([url isEqualToString:self.listWebStr]) {
        if (self.successBlock) {
            self.successBlock();
        }
        [self dismissToRootViewController];
    }
    return YES;
}

@end







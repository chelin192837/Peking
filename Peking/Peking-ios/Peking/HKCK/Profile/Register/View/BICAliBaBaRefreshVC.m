//
//  BICAliBaBaRefreshVC.m
//  Biconome
//
//  Created by 车林 on 2019/9/19.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICAliBaBaRefreshVC.h"
@interface BICAliBaBaRefreshVC ()<UIWebViewDelegate>

//@property(nonatomic,strong)uiwebv
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation BICAliBaBaRefreshVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
    
    [self setupSubviews];

}
- (void)setupSubviews
{
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBar_Height)];
    // 加载远程HTML5业务页面。
    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://xxx.com/demo/"]]];
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    self.webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    ///19.1.21 此处不转码 str中若有中文无法加载
    NSString * utfStr = @"";
    
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:utfStr]]];
    

}

- (void)webViewDidFinishLoad:(UIWebView  *)webView
{
//    [self.imageView removeFromSuperview];
    
    // 获取context对象。
    self.context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    // 设置testWebView JS对象，并将该对象指向其自身。
    self.context[@"testWebView"] = self;
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        
        NSLog(@"异常信息：%@", exceptionValue);
        
    };
}
- (void)getSlideData:(NSString *)callData {
    
    NSLog(@"Get:%@", callData);
    
    
}

@end

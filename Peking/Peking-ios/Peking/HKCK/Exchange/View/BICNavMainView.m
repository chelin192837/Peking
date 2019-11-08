//
//  BICNavMainView.m
//  Biconome
//
//  Created by 车林 on 2019/8/24.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICNavMainView.h"
#import "BICNavCointListView.h"

@interface BICNavMainView()

@property(nonatomic,strong)BICNavCointListView *mainListView;

@end

@implementation BICNavMainView

static id sharedInstance = nil;
+ (id)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
-(void)show:(BICMainCurrencyResponse *)resopnseM SuperView:(UIViewController*)viewController
{
    if ([viewController.view.subviews containsObject:self]) {
        self.hidden = !self.hidden;
        return;
    }
    
    kADDNSNotificationCenter(NSNotificationCenterCoinTransactionPair);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyNav:) name:NSNotificationCenterCoinTransactionPairNav object:nil];
    
    self.frame = CGRectMake(0,kNavBar_Height, SCREEN_WIDTH, SCREEN_HEIGHT-kNavBar_Height);
    [viewController.view addSubview:self];
    UIView * nav = [[UIView alloc] init];
    [self addSubview:nav];
    [nav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self);
        make.height.equalTo(@(382));
    }];
    
    UIView * bottomV = [[UIView alloc] init];
    bottomV.backgroundColor = [UIColor colorWithHexColorString:@"0D1634" alpha:0.6];
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [bottomV addGestureRecognizer:tap];
    [self addSubview:bottomV];
    [bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(nav.mas_bottom);
    }];
    
    self.mainListView = [[BICNavCointListView alloc] init];
    [nav addSubview:self.mainListView];
    [self.mainListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(nav);
    }];
    
    [self.mainListView setUITitleList:resopnseM];
}
-(void)show:(BICMainCurrencyResponse *)resopnseM
{

    if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:self]) {
        self.hidden = !self.hidden;
        return;
    }
    
    self.frame = CGRectMake(0,kNavBar_Height, SCREEN_WIDTH, SCREEN_HEIGHT-kNavBar_Height);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    UIView * nav = [[UIView alloc] init];
    [self addSubview:nav];
    [nav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self);
        make.height.equalTo(@(382));
    }];
    
    UIView * bottomV = [[UIView alloc] init];
    bottomV.backgroundColor = [UIColor colorWithHexColorString:@"0D1634" alpha:0.6];
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [bottomV addGestureRecognizer:tap];
    [self addSubview:bottomV];
    [bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(nav.mas_bottom);
    }];
    
    self.mainListView = [[BICNavCointListView alloc] init];
    [nav addSubview:self.mainListView];
    [self.mainListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(nav);
    }];
    
    [self.mainListView setUITitleList:resopnseM];
        
}

-(void)tap:(UITapGestureRecognizer*)tap
{
    kPOSTNSNotificationCenter(NSNotificationCenterEXCBottomToNav,nil);
    self.hidden = YES;
}
-(void)hide
{
    self.hidden = YES;
}
-(void)notify:(NSNotification*)notify
{
    [self hide];
}
-(void)notifyNav:(NSNotification*)notify
{
    [self hide];
}
@end




































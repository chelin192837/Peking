//
//  BaseTabBar.m
//  Agent
//
//  Created by wangliang on 2017/8/24.
//  Copyright © 2017年 七扇门. All rights reserved.
//

#import "BaseTabBar.h"
//#import "RSDHomePageVC.h"
#import "AppDelegate.h"

@interface BaseTabBar()

/** 发布按钮 */
@property (nonatomic, weak) UIButton *publishButton;

@property (nonatomic, strong) NSArray *arr_mobStr;
@end


@implementation BaseTabBar
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
   
        self.backgroundColor = SDColorWhiteFFFFFF;
        _arr_mobStr = @[@"e_tabbar_home",@"e_tabbar_discover", @"e_tabbar_publish",@"e_tabbar_message",@"e_tabbar_mine"];
        // 添加发布按钮
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"publish"] forState:UIControlStateNormal];
        // 只会调用一次
        publishButton.size = publishButton.currentBackgroundImage.size;
        [self addSubview:publishButton];
        self.publishButton = publishButton;
        
        UILabel *redlabel = [[UILabel alloc] init];
        redlabel.backgroundColor = rgb(235, 50, 35);
        redlabel.textColor = rgb(255, 255, 255);
        redlabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:10];
        redlabel.layer.masksToBounds = YES;
        redlabel.layer.cornerRadius = 7;
        redlabel.textAlignment = NSTextAlignmentCenter;
        redlabel.hidden = YES;
        self.messageRedPoint.frame = CGRectMake(Kscale*267, 5, 22, 14);
        [self addSubview:redlabel];
        self.messageRedPoint = redlabel;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 标记按钮是否已经添加过监听
    static BOOL added = NO;
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    CGFloat centerScale = 16.7;
    if (is_iPhoneX) {
        centerScale = centerScale + 17.0;
    }
    
    self.publishButton.center = CGPointMake(width * 0.5, height * 0.5-centerScale);
    // 设置其他UITabBarButton的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = self.frame.size.width / 5;
    CGFloat buttonH = 49;//如论是否iPhoneX 均为49
    NSInteger index = 0;
    for (UIControl *button in self.subviews) {
        
        if (![button isKindOfClass:[UIControl class]] || button == self.publishButton) continue;
        
        // 计算按钮的x值
        CGFloat buttonX = buttonW * index;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        if (buttonX == buttonW * 3) {
            [self bringSubviewToFront:self.messageRedPoint];
        }
        
        // 增加索引
        index++;
        if (index == 1) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
            tap.numberOfTapsRequired = 2;
            [button addGestureRecognizer:tap];
        }
        button.tag = index;

        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    added = YES;
}

-(void)tapAction:(UITapGestureRecognizer *)tap {
    
//    if ([[UtilsManager topViewController] isKindOfClass:[RSDHomePageVC class]]) {
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"tabBarTouchMoreTimes" object:nil];
//    }else{
//        [((AppDelegate*)[UIApplication sharedApplication].delegate).mainController setSelectedIndex:0];
//    }
    
}

- (void)buttonClick:(UIButton *)sender
{
    if (sender.tag !=0 && sender.tag < 6) {
//        [MobClick event:_arr_mobStr[sender.tag-1]];
    }
//    if ([[UtilsManager topViewController] isKindOfClass:[RSDHomePageVC class]]) {
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"tabBarTouchOneTime" object:nil];
//    }
}


@end

//
//  UIBarButtonItem+SDCustomItem.m
//  Agent
//
//  Created by 七扇门 on 16/1/6.
//  Copyright © 2016年 七扇门. All rights reserved.
//

#import "UIBarButtonItem+SDCustomItem.h"

@implementation UIBarButtonItem (SDCustomItem)
+(UIBarButtonItem *)ItemWithImageName:(NSString *)imageName AddressName:(NSString *)addressName type:(int)type target:(id)target action:(SEL)action
{

        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 41, 13);
        [button setTitle:addressName forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[SDDeviceManager colorFromHexRGB:@"5c6368"] forState:UIControlStateNormal];
    
        button.titleLabel.font = [UIFont systemFontOfSize:12];

        CGSize size;
        size =  [addressName boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 13) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:button.titleLabel.font,NSFontAttributeName, nil] context:nil].size;
    if (size.width>=60) {
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -28, 0, 0)];
    }else{
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -35, 0, 0)];
    }
    button.width = size.width;
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, size.width+5, 0, 5)];
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:button];
    
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 12, 20);
        [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (type) {
        return [[UIBarButtonItem alloc] initWithCustomView:btn];
    }else{
        return [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    
    return bar;
    return nil;
}
+(UIBarButtonItem *)ItemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 25, 22);
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];


}

// 只有前景图片
+(UIBarButtonItem *)ItemWithFrame:(CGRect)rect imageName:(NSString *)imageName target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = rect;
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

// 前景图片 + selected图片
+(UIBarButtonItem *)ItemWithFrame:(CGRect)rect imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = rect;
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

//文字 + 背景图片
+(UIBarButtonItem *)ItemWithFrame:(CGRect)rect title:(NSString *)title titleFont:(CGFloat)font titleColor:(UIColor *)color backgroundImageName:(NSString *)imageName target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = rect;
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
     
//文字 + selected文字 + 背景图片
+(UIBarButtonItem *)ItemWithFrame:(CGRect)rect title:(NSString *)title selectedTitle:(NSString *)selectedTitle titleFont:(CGFloat)font titleColor:(UIColor *)color backgroundImageName:(NSString *)imageName target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = rect;
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:selectedTitle forState:UIControlStateSelected];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
}
     

@end

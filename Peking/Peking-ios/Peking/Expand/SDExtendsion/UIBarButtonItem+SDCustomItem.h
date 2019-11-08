//
//  UIBarButtonItem+SDCustomItem.h
//  Agent
//
//  Created by 七扇门 on 16/1/6.
//  Copyright © 2016年 七扇门. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (SDCustomItem)

+(UIBarButtonItem *)ItemWithImageName:(NSString *)imageName AddressName:(NSString *)addressName type:(int)type target:(id)target action:(SEL)action;
+(UIBarButtonItem *)ItemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action;



/** 只有前景图片 */
+(UIBarButtonItem *)ItemWithFrame:(CGRect)rect imageName:(NSString *)imageName target:(id)target action:(SEL)action;

/** 前景图片 + selected前景图片 */
+(UIBarButtonItem *)ItemWithFrame:(CGRect)rect imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName target:(id)target action:(SEL)action;

/** 文字 + 背景图片 */
+(UIBarButtonItem *)ItemWithFrame:(CGRect)rect title:(NSString *)title titleFont:(CGFloat)font titleColor:(UIColor *)color backgroundImageName:(NSString *)imageName target:(id)target action:(SEL)action;

/** 文字 + selected文字 + 背景图片 */
+(UIBarButtonItem *)ItemWithFrame:(CGRect)rect title:(NSString *)title selectedTitle:(NSString *)selectedTitle titleFont:(CGFloat)font titleColor:(UIColor *)color backgroundImageName:(NSString *)imageName target:(id)target action:(SEL)action;


@end

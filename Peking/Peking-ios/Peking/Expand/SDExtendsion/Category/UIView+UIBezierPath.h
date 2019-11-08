//
//  UIView+UIBezierPath.h
//  xuxian
//
//  Created by qsm on 2018/4/23.
//  Copyright © 2018年 yujing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UIBezierPath)

-(void)setBezierPathLine:(CGRect)frame;

-(void)setRoundingCornersBy:(UIRectCorner)corners CornerRadii:(CGFloat)cornerRadii;

@end

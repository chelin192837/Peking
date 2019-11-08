//
//  UIView+UIBezierPath.m
//  xuxian
//
//  Created by qsm on 2018/4/23.
//  Copyright © 2018年 yujing. All rights reserved.
//

#import "UIView+UIBezierPath.h"

@implementation UIView (UIBezierPath)

-(void)setBezierPathLine:(CGRect)frame
{
    CGFloat viewWidth = frame.size.width;
    CGFloat viewHeight = frame.size.height;
    self.layer.cornerRadius = 4;
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.position = CGPointMake(0, 0);
    borderLayer.bounds = CGRectMake(0, 0, viewWidth, viewHeight);
    borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:borderLayer.bounds cornerRadius:CGRectGetHeight(borderLayer.bounds)].CGPath;
//    UIBezierPath *pathB = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:viewHeight/2];
//    borderLayer.path = pathB.CGPath;
    borderLayer.lineWidth = 1. / [[UIScreen mainScreen] scale];
    //虚线边框
    borderLayer.lineDashPattern = @[@3, @3];
    //实线边框
    //    borderLayer.lineDashPattern = nil;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = [UIColor redColor].CGColor;
    [self.layer addSublayer:borderLayer];
}


-(void)setRoundingCornersBy:(UIRectCorner)corners CornerRadii:(CGFloat)cornerRadii
{
    UIBezierPath *maskPath=[UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadii, cornerRadii)];
    
    CAShapeLayer *maskLayer=[[CAShapeLayer alloc] init];
    
    maskLayer.frame=self.bounds;
    
    maskLayer.path=maskPath.CGPath;
    
    self.layer.mask=maskLayer;
    
}


@end





























































































































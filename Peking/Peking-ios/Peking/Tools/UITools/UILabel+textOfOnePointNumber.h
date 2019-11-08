//
//  UILabel+textOfOnePointNumber.h
//  Agent
//
//  Created by 七扇门 on 2017/11/14.
//  Copyright © 2017年 七扇门. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UILabel (textOfOnePointNumber)
+ (NSString *)textOfOnePointNumber:(UILabel *)label;
+ (BOOL)textOfLineNumberIsFive:(UILabel *)label;

+ (NSString *)textOfSpecialNumber:(UILabel *)label;

+ (void)setHeadNewsLabelSpace:(UILabel *)label 
                    withValue:(NSString *)labeText 
                     withFont:(UIFont *)font 
                    withSpece:(CGFloat)lineSpacing;

+ (NSInteger)textOfLineNumber:(NSString *)text font:(UIFont *)font rect:(CGRect)rect;

+ (CGSize)textOfHeightLineNumber:(NSString *)text font:(UIFont *)font lineSpace:(CGFloat)lineSpace rect:(CGSize)rect;
@end

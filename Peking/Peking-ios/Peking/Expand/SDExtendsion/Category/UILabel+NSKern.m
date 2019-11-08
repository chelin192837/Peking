//
//  UILabel+NSKern.m
//  Agent
//
//  Created by qsm on 2018/8/30.
//  Copyright © 2018年 七扇门. All rights reserved.
//

#import "UILabel+NSKern.h"

@implementation UILabel (NSKern)

-(void)setkern:(float)kern WithText:(NSString*)text WithFont:(float)font WithLineSpace:(float)lineSpace
{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    paraStyle.alignment = NSTextAlignmentLeft;
    
    paraStyle.lineSpacing = lineSpace; //设置行间距
    
    paraStyle.hyphenationFactor = 1.0;
    
    paraStyle.firstLineHeadIndent = 0.0;
    
    paraStyle.paragraphSpacingBefore = 0.0;
    
    paraStyle.headIndent = 0;
    
    paraStyle.tailIndent = 0;
    
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font], NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@(kern)
                          };
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:text attributes:dic];
    
    self.attributedText = attributeStr;
    
}

-(void)setAttributedString:(NSString*)attributedString WithKern:(float)kern
{
    NSAttributedString *attributedStr =[[NSAttributedString alloc] initWithString:attributedString attributes:@{NSKernAttributeName : @(kern)}];
    [self setAttributedText:attributedStr];
}

-(void)setAttributedString:(NSString*)attributedString
               FrontLength:(NSInteger)frontLength
                 WithColor:(UIColor*)frontColor
           WithBehindColor:(UIColor*)behindColor
{
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:attributedString];
    [string addAttribute:NSForegroundColorAttributeName value:frontColor range:NSMakeRange(0, frontLength)];
    [string addAttribute:NSForegroundColorAttributeName value:behindColor range:NSMakeRange(frontLength,attributedString.length-frontLength)];
    self.attributedText  = string;
}


@end































































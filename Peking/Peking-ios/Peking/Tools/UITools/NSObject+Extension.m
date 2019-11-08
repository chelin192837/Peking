//
//  UIView+Extension.m
//  ALPHA
//
//  Created by mac on 16/5/12.
//  Copyright © 2016年 king. All rights reserved.
//

#import "NSObject+Extension.h"

@implementation NSObject (Extension)

- ( CGFloat)handleHeightWithStringForHZ:(NSString *)string lineSpace:(CGFloat)space font:(UIFont *)font lineNumbers:(NSInteger)numbers maxWidth:(CGFloat)maxWidth
{
    if (string == nil || string.length < 1) {
        return 0;
    }
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = space;
    paragraph.lineBreakMode = NSLineBreakByCharWrapping;
    paragraph.alignment = NSTextAlignmentLeft;
    
    NSDictionary *attributes = @{NSFontAttributeName: font,NSParagraphStyleAttributeName:paragraph};
    
    CGSize size = [string boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:  NSStringDrawingUsesLineFragmentOrigin  attributes:attributes context:nil].size;
    CGFloat lineHeight = font.lineHeight;
    if (size.height > (lineHeight + space) * numbers) {
        return (lineHeight + space) * numbers;
    }else {
        if(size.height==lineHeight + space){
            return lineHeight;
        }else{
            return ceil(size.height);
        }
    }
}
- ( CGFloat)handleHeightWithString:(NSString *)string lineSpace:(CGFloat)space font:(UIFont *)font lineNumbers:(NSInteger)numbers maxWidth:(CGFloat)maxWidth
{
    if (string == nil || string.length < 1) {
        return 0;
    }
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = space;
    paragraph.lineBreakMode = NSLineBreakByCharWrapping;
    paragraph.alignment = NSTextAlignmentLeft;
    
    NSDictionary *attributes = @{NSFontAttributeName: font,NSParagraphStyleAttributeName:paragraph};
    
    CGSize size = [string boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:  NSStringDrawingUsesLineFragmentOrigin  attributes:attributes context:nil].size;
    CGFloat lineHeight = font.lineHeight;
    if (size.height > (lineHeight + space) * numbers) {
        return (lineHeight + space) * numbers;
    }else {
        return ceil(size.height);
    }
}
- ( CGFloat)handleHeightWithString:(NSString *)string lineSpace:(CGFloat)space font:(UIFont *)font lineNumbers:(NSInteger)numbers maxWidth:(CGFloat)maxWidth align:(NSInteger) align
{
    if (string == nil || string.length < 1) {
        return 0;
    }
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = space;
    paragraph.lineBreakMode = NSLineBreakByCharWrapping;
    paragraph.alignment = align;
    
    NSDictionary *attributes = @{NSFontAttributeName: font,NSParagraphStyleAttributeName:paragraph};
    
    CGSize size = [string boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:  NSStringDrawingUsesLineFragmentOrigin  attributes:attributes context:nil].size;
    CGFloat lineHeight = font.lineHeight;
    if (size.height > (lineHeight + space) * numbers) {
        return (lineHeight + space) * numbers;
    }else {
        return ceil(size.height);
    }
}

- (NSString *)handlePercent:(NSString *)percent
{
    if ([percent floatValue] > 0) {
        return [NSString stringWithFormat:@"+%@%%",percent];
    }else {
        return [NSString stringWithFormat:@"%@%%",percent];
    }
}

- (CGFloat)handleHeightWithMutableString:(NSAttributedString *)string lineSpace:(CGFloat)space font:(UIFont *)font lineNumbers:(NSInteger)numbers maxWidth:(CGFloat)maxWidth
{
    if (string == nil || string.length < 1) {
        return 0;
    }
    
    CGSize size = [string boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    CGFloat lineHeight = font.lineHeight;
    if (size.height > (lineHeight + space) * numbers) {
        return (lineHeight + space) * numbers;
    }else {
        return size.height + 1;
    }
}
@end

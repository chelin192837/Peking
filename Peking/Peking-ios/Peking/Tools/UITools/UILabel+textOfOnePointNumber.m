//
//  UILabel+textOfOnePointNumber.m
//  Agent
//
//  Created by 七扇门 on 2017/11/14.
//  Copyright © 2017年 七扇门. All rights reserved.
//

#import "UILabel+textOfOnePointNumber.h"
#import <CoreText/CoreText.h>
@implementation UILabel (textOfOnePointNumber)
+ (NSString *)textOfOnePointNumber:(UILabel *)label{
    NSString *text = [label text];
    UIFont   *font = [label font];
    CGRect    rect = [label frame];
    
    CTFontRef myFont = CTFontCreateWithName((__bridge CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,100000));
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    
    for (id line in lines){
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        
        NSString *lineString = [text substringWithRange:range];
        [linesArray addObject:lineString];
    }
    //处理数组中的数据
    NSMutableString *stringLast = [NSMutableString new];
    //先判断返回的数组长度是否大于5；
    if(linesArray.count>5){
        
        if ([linesArray[4]length] > 7) {
            stringLast = [NSMutableString stringWithFormat:@"%@%@%@%@%@",linesArray.firstObject,linesArray[1],linesArray[2],linesArray[3],[linesArray[4] substringToIndex:[linesArray[4] length]-6]];
        }
        else
        {
            stringLast = [NSMutableString stringWithFormat:@"%@%@%@%@",linesArray.firstObject,linesArray[1],linesArray[2],linesArray[3]];
        }
        [stringLast appendString:@"..."];
        
        [stringLast appendString:@"全文"];
    }
    else
    {
        stringLast = [NSMutableString stringWithFormat:@"%@",label.text];
    }
    return stringLast;
}

+ (NSString *)textOfSpecialNumber:(UILabel *)label{
    NSString *text = [label text];
    UIFont   *font = [label font];
    CGRect    rect = [label frame];
    
    CTFontRef myFont = CTFontCreateWithName((__bridge CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,100000));
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    
    for (id line in lines){
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        
        NSString *lineString = [text substringWithRange:range];
        [linesArray addObject:lineString];
    }
    //处理数组中的数据
    NSMutableString *stringLast = [NSMutableString new];
    NSString *strAdd = @"...全文";
    if ([linesArray[3]length] < strAdd.length) {
        
        stringLast = [NSMutableString stringWithFormat:@"%@%@%@",linesArray.firstObject,linesArray[1],linesArray[2]];
    }
    else
    {
        stringLast = [NSMutableString stringWithFormat:@"%@%@%@%@",linesArray.firstObject,linesArray[1],linesArray[2],[linesArray[3] substringToIndex:[linesArray[3] length]-strAdd.length]];
    }
   
    [stringLast appendString:@"..."];
    
    [stringLast appendString:@"全文"];
    
    return stringLast;
}

+ (BOOL)textOfLineNumberIsFive:(UILabel *)label {
   
    CGFloat labelHeight = [label sizeThatFits:CGSizeMake(label.frame.size.width, MAXFLOAT)].height;
    NSNumber *count = @((labelHeight) / label.font.lineHeight);
    
    if ([count integerValue] >= 5) {
        return YES;
    }
    else
    {
        return NO;
    }
    
}

+ (void)setHeadNewsLabelSpace:(UILabel *)label 
                    withValue:(NSString *)labeText 
                     withFont:(UIFont *)font 
                    withSpece:(CGFloat)lineSpacing {
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = lineSpacing; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    
    CGRect rect = [label frame];
    
    CTFontRef myFont = CTFontCreateWithName((__bridge CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:labeText];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,100000));
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    
    for (id line in lines){
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        
        NSString *lineString = [labeText substringWithRange:range];
        [linesArray addObject:lineString];
    }
    //处理数组中的数据
    NSMutableString *stringLast = [NSMutableString new];
    //先判断返回的数组长度是否大于5；
    if(linesArray.count>5){
        
        stringLast = [NSMutableString stringWithFormat:@"%@%@%@%@%@",linesArray.firstObject,linesArray[1],linesArray[2],linesArray[3],[linesArray[4] substringToIndex:[linesArray[4] length]-5]];
        [stringLast appendString:@"..."];
        
        [stringLast appendString:@"全文"];
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:stringLast];
        [str addAttribute:NSForegroundColorAttributeName value:RGBACOLOR(83, 121, 178, 1) range:NSMakeRange(str.length-2,2)];
        
    }
    else
    {
        stringLast = [NSMutableString stringWithFormat:@"%@",label.text];
    }
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:stringLast attributes:dic];
    
    label.attributedText = attributeStr;
    
    
}

+ (NSInteger)textOfLineNumber:(NSString *)text font:(UIFont *)font rect:(CGRect)rect {
    
    CTFontRef myFont = CTFontCreateWithName((__bridge CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,100000));
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    
    for (id line in lines){
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        
        NSString *lineString = [text substringWithRange:range];
        [linesArray addObject:lineString];
    }
    return linesArray.count;
}

+ (CGSize)textOfHeightLineNumber:(NSString *)text font:(UIFont *)font lineSpace:(CGFloat)lineSpace rect:(CGSize)rect{
    NSMutableAttributedString *attributedString =[[NSMutableAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:font}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace; // 调整行间距
    NSRange range = NSMakeRange(0, [text length]);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    CGSize titleSize = [attributedString boundingRectWithSize:rect options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    return titleSize;
}

// 过滤表情
- (NSString *)disable_emoji:(NSString *)text {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}


@end

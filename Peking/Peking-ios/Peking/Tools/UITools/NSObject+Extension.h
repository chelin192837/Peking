//
//  UIView+Extension.h
//  ALPHA
//
//  Created by mac on 16/5/12.
//  Copyright © 2016年 king. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSObject (Extension)
- ( CGFloat)handleHeightWithStringForHZ:(NSString *)string lineSpace:(CGFloat)space font:(UIFont *)font lineNumbers:(NSInteger)numbers maxWidth:(CGFloat)maxWidth;

- (CGFloat)handleHeightWithString:(NSString *)string lineSpace:(CGFloat)space font:(UIFont *)font lineNumbers:(NSInteger)numbers maxWidth:(CGFloat)maxWidth;

- ( CGFloat)handleHeightWithString:(NSString *)string lineSpace:(CGFloat)space font:(UIFont *)font lineNumbers:(NSInteger)numbers maxWidth:(CGFloat)maxWidth align:(NSInteger) align;

- (CGFloat)handleHeightWithMutableString:(NSAttributedString *)string lineSpace:(CGFloat)space font:(UIFont *)font lineNumbers:(NSInteger)numbers maxWidth:(CGFloat)maxWidth;

- (NSString *)handlePercent:(NSString *)percent;
@end

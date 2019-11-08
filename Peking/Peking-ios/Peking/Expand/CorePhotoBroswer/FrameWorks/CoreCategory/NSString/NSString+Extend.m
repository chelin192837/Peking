//
//  NSString+Extend.m
//  CoreCategory
//
//  Created by 成林 on 15/4/6.
//  Copyright (c) 2015年 沐汐. All rights reserved.
//

#import "NSString+Extend.h"

@implementation NSString (Extend)


/*
 *  时间戳对应的NSDate
 */
-(NSDate *)date{
    
    NSTimeInterval timeInterval=self.floatValue;
    
    return [NSDate dateWithTimeIntervalSince1970:timeInterval];
}

+ (CGSize)sizeWithString:(NSString *)string andMaxSize:(CGSize)maxSize andFont:(UIFont *)font
{
    NSDictionary *attr = @{NSFontAttributeName : font};
    return [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}

+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string isKindOfClass:[NSString class]]) {
        if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
            return YES;
        }
    }
    return NO;
}

-(BOOL)isChineseWord{
    NSUInteger le=[self length];
    for(int i=0; i<le;i++){
        int a = [self characterAtIndex:i];
        if((a >= 0x4e00 && a <= 0x9fff) || (a >= 0x3400 && a <= 0x4db5) || (a >= 0xe815 && a <= 0xe864) || (a >= 0xd840 && a <= 0xd875) || (a >= 0xdc00 && a <= 0xdfff)){
            continue;
        }else{
            return false;
        }
    }
    return true;
}

- (NSString *)checkSelfWithDefaultStr:(NSString *)defaultStr{
    if ([NSString isBlankString:self]) {
        return defaultStr;
    }else{
        return self;
    }
}

- (BOOL)isStartWithString:(NSString*)start
{
    BOOL result = FALSE;
    NSRange found = [self rangeOfString:start options:NSCaseInsensitiveSearch];
    if (found.location == 0)
    {
        result = TRUE;
    }
    return result;
}

- (BOOL)isEndWithString:(NSString*)end
{
    NSInteger endLen = [end length];
    NSInteger len = [self length];
    BOOL result = TRUE;
    if (endLen <= len) {
        NSInteger index = len - 1;
        for (NSInteger i = endLen - 1; i >= 0; i--) {
            if ([end characterAtIndex:i] != [self characterAtIndex:index]) {
                result = FALSE;
                break;
            }
            index--;
        }
    }
    else {
        result = FALSE;
    }
    return result;
}

+ (void)callWithNumber:(NSString *)number
{
    if ([NSString isBlankString:number]) {
        [ODAlertViewFactory showToastWithMessage:KDefault_BlankPhone];
        return;
    }
    NSString *phoneNumber = [@"telprompt://" stringByAppendingString:number];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

+ (void)callWithNumberWithoutPrompt:(NSString *)number
{
    if ([NSString isBlankString:number]) {
        [ODAlertViewFactory showToastWithMessage:KDefault_BlankPhone];
        return;
    }
    NSString *phoneNumber = [@"tel://" stringByAppendingString:number];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

+ (NSString *)leachSpecialCharacter:(NSString *)number{
    NSString *str = @"";
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"[]{}（#%-*+=_）\\|~(＜＞$%^&*)_+ "];
    str = [[number componentsSeparatedByCharactersInSet:doNotWant]componentsJoinedByString: @""];
    return str;
}

/// 首页 title 转换
+ (NSString *)transformStrFromString:(NSString *)string {
    if ([string isEqualToString:@"最新"]) {
        return @"new";
    }else if ([string isEqualToString:@"快佣"]) {
        return @"fast_commission";
    }else if ([string isEqualToString:@"高佣"]) {
        return @"high_commission";
    }else if ([string isEqualToString:@"文旅"]) {
        return @"travel";
    }else if ([string isEqualToString:@"海外"]) {
        return @"overseas";
    }else if ([string isEqualToString:@"热推"]) {
        return @"hot";
    }else{
        return nil;
    }
}


@end




















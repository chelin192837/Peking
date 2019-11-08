//
//  NSString+Extend.h
//  CoreCategory
//
//  Created by 成林 on 15/4/6.
//  Copyright (c) 2015年 沐汐. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extend)


/*
 *  时间戳对应的NSDate
 */
@property (nonatomic,strong,readonly) NSDate *date;

/**
 *  根据文字的数量计算文字尺寸
 *
 *  @param string e
 *  @param maxSize CGSizeMake(100000,100000)
 *  @param font e
 *
 *  @return CGSize
 */
+ (CGSize)sizeWithString:(NSString *)string andMaxSize:(CGSize)maxSize andFont:(UIFont *)font;

/**
 *  判断字符串是否非空
 *
 *  @param string e
 *
 *  @return BOOL
 */
+ (BOOL) isBlankString:(NSString *)string;
/**
 *  是否中文
 *
 *  @return BOOL
 */
-(BOOL)isChineseWord;
/**
 *  检查自己是否为空串，如果是填充“defaultStr”
 *
 *  @param defaultStr e
 *
 *  @return NSString
 */
- (NSString *)checkSelfWithDefaultStr:(NSString *)defaultStr;
/**
 *  判断是否以某个字符串开头
 *
 *  @param start 开头字符串
 *
 *  @return e
 */
- (BOOL)isStartWithString:(NSString*)start;
/**
 *  判断是否以某个字符串结束
 *
 *  @param end 结束字符串
 *  @return e
 */
- (BOOL)isEndWithString:(NSString*)end;
/**
 *  打电话
 *
 *  @param number 电话号码
 */
+ (void)callWithNumber:(NSString *)number;
/**
 *  打电话 没有弹窗
 *
 *  @param number e
 */
+ (void)callWithNumberWithoutPrompt:(NSString *)number;
/**
 *  过滤特殊字符
 *
 *  @param number 过滤字符
 *
 *  @return NSString
 */
+ (NSString *)leachSpecialCharacter:(NSString *)number;
/// 首页 title 转换
+ (NSString *)transformStrFromString:(NSString *)string;
@end

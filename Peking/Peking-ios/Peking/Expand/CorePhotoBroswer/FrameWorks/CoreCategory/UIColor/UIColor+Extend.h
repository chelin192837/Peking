//
//  UIColor+Extend.h
//  Wifi
//
//  Created by muxi on 14/11/19.
//  Copyright (c) 2014年 muxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#define rgb(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]
#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define hexColor(colorV) [UIColor colorWithHexColorString:@#colorV]
#define hexColorAlpha(colorV,a) [UIColor colorWithHexColorString:@#colorV alpha:a];


///  间隔线
#define kGrayLine [UIColor colorWithHexColorString:@"eeeeee"]
#define kGraMidLine [UIColor colorWithHexColorString:@"403e4b"]
#define kPurpleBacground [UIColor colorWithHexColorString:@"2c2e37"]
#define kPurpleBac [UIColor colorWithHexColorString:@"312f3c"]
#define kContentViewBac [UIColor colorWithHexColorString:@"EBEBEB"]

@interface UIColor (Extend)




/**
 *  十六进制颜色
 */
+ (UIColor *)colorWithHexColorString:(NSString *)hexColorString;






/**
 *  十六进制颜色:含alpha
 */
+ (UIColor *)colorWithHexColorString:(NSString *)hexColorString alpha:(float)alpha;


/**
 *  随机颜色
 *
 *  @return UIColor
 */
+ (UIColor *)randomColor;

/* Toms : For Swift */
+ (UIColor *)kBlackBackground;



@end

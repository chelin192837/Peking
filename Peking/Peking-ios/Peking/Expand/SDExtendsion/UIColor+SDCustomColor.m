//
//  UIColor+SDCustomColor.m
//  Agent
//
//  Created by jj on 16/1/15.
//  Copyright © 2016年 七扇门. All rights reserved.
//

#import "UIColor+SDCustomColor.h"

@implementation UIColor (SDCustomColor)

+(UIColor *)colorFromHexRGB:(NSString *)inColorString
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode];	// ignore error
    }
    redByte		= (unsigned char) (colorCode >> 16);
    greenByte	= (unsigned char) (colorCode >> 8);
    blueByte	= (unsigned char) (colorCode);	// masks off high bits
    result = [UIColor
              colorWithRed:		(float)redByte	/ 0xff
              green:	(float)greenByte/ 0xff
              blue:	(float)blueByte	/ 0xff
              alpha:1.0f];
    return result;
}


@end

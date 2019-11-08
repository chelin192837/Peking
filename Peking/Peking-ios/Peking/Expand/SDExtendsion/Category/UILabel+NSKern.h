//
//  UILabel+NSKern.h
//  Agent
//
//  Created by qsm on 2018/8/30.
//  Copyright © 2018年 七扇门. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (NSKern)

-(void)setkern:(float)kern WithText:(NSString*)text WithFont:(float)font WithLineSpace:(float)lineSpace;

-(void)setAttributedString:(NSString*)attributedString WithKern:(float)kern ;

-(void)setAttributedString:(NSString*)attributedString
                    FrontLength:(NSInteger)frontLength
                      WithColor:(UIColor*)frontColor
                WithBehindColor:(UIColor*)behindColor;

@end

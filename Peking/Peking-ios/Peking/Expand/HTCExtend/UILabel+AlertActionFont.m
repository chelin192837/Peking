//
//  UILabel+AlertActionFont.m
//  Agent
//
//  Created by qsm on 2018/5/23.
//  Copyright © 2018年 七扇门. All rights reserved.
//

#import "UILabel+AlertActionFont.h"

@implementation UILabel (AlertActionFont)
- (void)setAppearanceFont:(UIFont *)appearanceFont
{
    if(appearanceFont)
    {
        [self setFont:appearanceFont];
    }
}

- (UIFont *)appearanceFont
{
    return self.font;
}

@end

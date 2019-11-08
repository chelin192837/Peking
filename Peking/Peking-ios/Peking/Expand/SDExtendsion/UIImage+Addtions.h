//
//  UIImage+Addtions.h
//  TestGroupIcon
//
//  Created by Pill.Gong on 8/9/16.
//  Copyright (c) 2014 Pill.Gong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Addtions)

+ (UIImage *)groupIconWith:(NSArray *)array;
+ (UIImage *)groupIconWith:(NSArray *)array bgColor:(UIColor *)bgColor;

@end

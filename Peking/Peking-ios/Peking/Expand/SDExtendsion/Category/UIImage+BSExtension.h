//
//  UIImage+BSExtension.h
//  
//
//  Created by 七扇门 on 16/8/31.
//  Copyright © 2016年 luotao. All rights reserved.
//  图片圆角处理

#import <UIKit/UIKit.h>

@interface UIImage (BSExtension)

/**
 *  圆形图片
 */
- (UIImage *)circleImage;

/**
 *  生成指定大小、颜色图片
 *
 *  @param color a
 *  @param size a
 *
 *  @return UIImage
 */
+(UIImage *)createImageWithColor:(UIColor *)color Size:(CGSize)size;

@end

//
//  UIImage+ImageScaleSize.h
//  BYFCApp
//
//  Created by PengLee on 15/1/6.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageScaleSize)
//压缩成指定大小的图片
+ (UIImage *)imageByScaleAndCropingForSize:(CGSize)newSize oldImage:(UIImage *)image;
//等比例压缩
+ (UIImage *) imageCompressForSizeImage:(UIImage *)image targetSize:(CGSize)size;
// 计算图片的大小
+ (CGFloat) caculateImageSize:(UIImage *) image;
@end

//
//  UIImage+ImageScaleSize.m
//  BYFCApp
//
//  Created by PengLee on 15/1/6.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import "UIImage+ImageScaleSize.h"

@implementation UIImage (ImageScaleSize)
//压缩指定大小的图片
+ (UIImage *)imageByScaleAndCropingForSize:(CGSize)newSize oldImage:(UIImage *)image
{
    //创建一个bitmap 的context ，并把它设置成当前正在使用的context ，
    UIGraphicsBeginImageContext(newSize);
    //绘制改变大小的图片，
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    //从当前的context 中创建一个改变大小后的图片，
    UIImage * scaleImage = UIGraphicsGetImageFromCurrentImageContext();
    //让当前的context出堆栈，
    UIGraphicsEndImageContext();
    //返回缩放后的图片
    return scaleImage;
    
}
+ (UIImage *)imageCompressForSizeImage:(UIImage *)image targetSize:(CGSize)size
{
    UIImage * newImage = nil;
    CGSize iamgeSize = image.size;
    CGFloat width = iamgeSize.width;
    CGFloat height  = iamgeSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaleWidth = targetWidth;
    CGFloat scaleHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if (CGSizeEqualToSize(iamgeSize, size)==NO)
    {
        CGFloat widthFactor = targetWidth/width;
        CGFloat heightFactor = targetHeight/height;
        if (widthFactor >heightFactor)
        {
            scaleFactor = widthFactor;
            
        }
        else
        {
            scaleFactor = heightFactor;
            
        }
        scaleWidth  =width * scaleFactor;
        scaleHeight = height * scaleFactor;
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight-scaleHeight)*0.5;
            
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth -scaleWidth)*0.5;
            
        }
        
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaleWidth;
    thumbnailRect.size.height = scaleHeight;
    [image drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if (newImage==nil)
    {
        NSLog(@"scale image file");
    }
    UIGraphicsEndImageContext();
    
    
    return newImage;
}

+ (CGFloat)caculateImageSize:(UIImage *)image {
    
    CGFloat length = 0;
    if (image) {
        NSData * imageData = UIImageJPEGRepresentation(image,1);
        length = [imageData length]/ 1000 / 1024;
    }
    return length;
}

@end

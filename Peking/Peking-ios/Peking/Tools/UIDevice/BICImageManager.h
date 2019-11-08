//
//  BICImageManager.h
//  Biconome
//
//  Created by 车林 on 2019/9/2.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICImageManager : NSObject

//字符串生成图片
+(UIImage*)QRTranThoughString:(NSString*)str WithSize:(CGFloat)size;

-(void)SaveImageToLocal:(UIViewController*)viewController;
-(void)SaveImageToLocalForView:(UIView*)view;
+(NSData *)zipNSDataWithImage:(UIImage *)sourceImage;
+(NSString *)coverImageToString:(UIImage *)image;
+(UIImage *)coverStringToImage:(NSString *)strimage64;
@end

NS_ASSUME_NONNULL_END

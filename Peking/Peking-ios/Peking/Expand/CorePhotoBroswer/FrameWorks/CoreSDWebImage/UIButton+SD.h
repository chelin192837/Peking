//
//  UIButton+SD.h
//  CoreSDWebImage
//
//  Created by 成林 on 15/5/6.
//  Copyright (c) 2015年 muxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDWebImageDownloader.h"
#import "SDWebImageManager.h"
#import "UIImage+ReMake.h"



@interface UIButton (SD)



/**
 *  普通网络图片展示
 *
 *  @param urlStr  图片地址
 *  @param phImage 占位图片
 */
-(void)imageWithUrlStr:(NSString *)urlStr phImage:(UIImage *)phImage;


/**
 *  带有进度的网络图片展示
 *
 *  @param urlStr         图片地址
 *  @param phImage        占位图片
 *  @param completedBlock 完成
 */
-(void)imageWithUrlStr:(NSString *)urlStr phImage:(UIImage *)phImage state:(UIControlState)state completedBlock:(SDWebImageCompletionBlock)completedBlock;


/**
 *  水平排列，文字在左，图片在右
 *
 *  @param space 文字和图片间隔
 */
- (void)setTitleImageHorizontalAlignmentWithSpace:(float)space;

/**
 *  水平排列，图片在左，文字在右
 *
 *  @param space 图片和文字间隔
 */
- (void)setImageTitleHorizontalAlignmentWithSpace:(float)space;

/**
 *  竖直排列，文字在上，图片在下
 *
 *  @param space 文字和图片的间距
 */
- (void)setTitleImageVerticalAlignmentWithSpace:(float)space;

/**
 *  竖直排列，图片在上，文字在下
 *
 *  @param space 图片和文字的间距
 */
- (void)setImageTitleVerticalAlignmentWithSpace:(float)space;

@end

//
//  UIButton+EnlargeTouchArea.h
//  YYKitDemo
//
//  Created by qsm on 2019/2/21.
//  Copyright © 2019年 ibireme. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (EnlargeTouchArea)

- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;

- (void)setEnlargeEdge:(CGFloat) size;

@end

NS_ASSUME_NONNULL_END

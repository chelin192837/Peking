//
//  XHVerticalScrollview.h
//  VerticalScrollViewPlan
//
//  Created by 牛新怀 on 2017/8/10.
//  Copyright © 2017年 牛新怀. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XHVerticalScrollview;
/*
 @parameter 用户delegate方法，传出点击某个滚动条数据
 */

@protocol XHVerticalDelegate <NSObject>

- (void)didSelectTag:(NSInteger)tag withView:(XHVerticalScrollview *)view;

@end
@interface XHVerticalScrollview : UIView
/*
 @parameter 外部传入datasourse，用于展示上下无限滚动的数据

 */
@property (strong, nonatomic) NSArray * customArray;

@property (strong, nonatomic) NSTimer * myTimer;

@property (weak, nonatomic) id<XHVerticalDelegate>delegate;

-(instancetype)initWithDelegate:(id)delegate
                      DataArray:(NSArray*)dataArray
                        BgColor:(UIColor*)bgColor
                          Frame:(CGRect)frame;

@end

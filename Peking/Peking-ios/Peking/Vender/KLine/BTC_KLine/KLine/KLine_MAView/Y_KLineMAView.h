//
//  Y_KLineMAView.h
//  BTC-Kline
//
//  Created by yate1996 on 16/5/2.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Y_KLineModel;
@interface Y_KLineMAView : UIView
@property (nonatomic, assign)NSInteger type;
+(instancetype)view;

-(void)maProfileWithModel:(Y_KLineModel *)model;
-(void)maProfileWithModel:(Y_KLineModel *)model type:(NSInteger)type;
@end

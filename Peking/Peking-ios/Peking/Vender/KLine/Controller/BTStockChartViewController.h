//
//  YStockChartViewController.h
//  BTC-Kline
//
//  Created by yate1996 on 16/4/27.
//  Copyright © 2016年 yate1996. All rights reserved.
//  K线

#import <UIKit/UIKit.h>

@class BTBiModel;
typedef void(^buySellCoinbackBlock)(void);
@interface BTStockChartViewController : BaseViewController

@property (nonatomic, strong) BTBiModel *biModel;

@property (nonatomic, copy) buySellCoinbackBlock backBlock;

@property (nonatomic, strong)getTopListResponse * model;

@end

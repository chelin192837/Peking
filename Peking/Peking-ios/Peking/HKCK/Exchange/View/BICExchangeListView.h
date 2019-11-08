//
//  BTCListView.h
//  Biconome
//
//  Created by 车林 on 2019/8/10.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BICMainCurrencyResponse.h"
#import "BICMarketListView.h"

#import "BICChangePriceView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BICExchangeListView : UIView

-(instancetype)init;

-(void)setUITitleList;

@property(nonatomic,assign)ChangePriceType priceType;

@end

@interface BICZTitleCell : UICollectionViewCell

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UIView *pointView;

@end

NS_ASSUME_NONNULL_END


//
//  BICChangePriceView.h
//  Biconome
//
//  Created by 车林 on 2019/8/23.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BICEXCMainVC;
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,ChangePriceType)
{
    ChangePriceType_Buy=99,
    ChangePriceType_Sale
};
typedef NS_ENUM(NSInteger,ChangeOrderType)
{
    ChangeOrderType_Limit=99,
    ChangeOrderType_Market,
    ChangeOrderType_Stop
};
@interface BICChangePriceView : UIView

@property(nonatomic,assign)ChangePriceType priceType;

@property(nonatomic,assign)ChangeOrderType orderType;

@property(nonatomic,strong) BICEXCMainVC * vc;

-(instancetype)initWithNib;

-(void)updateUI:(ChangePriceType)priceType OrderType:(ChangeOrderType)orderType;


@end

NS_ASSUME_NONNULL_END

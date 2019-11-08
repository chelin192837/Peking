//
//  BICEXCMiddenView.h
//  Biconome
//
//  Created by 车林 on 2019/8/23.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BICChangePriceView.h"
#import "BICEXCMainVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface BICEXCMiddenView : UIView

-(instancetype)initWithFrame:(CGRect)frame With:(ChangePriceType)priceType OrderType:(ChangeOrderType)orderType;

@property(nonatomic,assign)ChangeOrderType orderType;

@property(nonatomic,strong)BICEXCMainVC *vc;

@end

NS_ASSUME_NONNULL_END

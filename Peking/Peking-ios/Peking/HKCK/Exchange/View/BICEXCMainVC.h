//
//  BICEXCMainVC.h
//  Biconome
//
//  Created by 车林 on 2019/8/23.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BICChangePriceView.h"


//@class BICChangePriceView;
NS_ASSUME_NONNULL_BEGIN

@interface BICEXCMainVC : BaseViewController

@property(nonatomic,assign)ChangePriceType priceType;

@property(nonatomic,assign)ChangeOrderType orderType;

@property(nonatomic,assign)BOOL setupRefreshNeed;

-(void)setupRefresh;



@end

NS_ASSUME_NONNULL_END

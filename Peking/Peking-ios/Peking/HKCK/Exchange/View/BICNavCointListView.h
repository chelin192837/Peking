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

NS_ASSUME_NONNULL_BEGIN

@interface BICNavCointListView : UIView

-(instancetype)init;

-(void)setUITitleList:(BICMainCurrencyResponse*)response;

//-(void)updateTopList:(NSInteger)count;

@end


NS_ASSUME_NONNULL_END


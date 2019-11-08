//
//  BICRechargeDetailBottomView.h
//  Biconome
//
//  Created by 车林 on 2019/9/3.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^RechargeBlock)(void);
typedef void(^DrawBlock)(void);
@interface BICRechargeDetailBottomView : UIView

-(instancetype)initWithNibRecharge:(RechargeBlock)recharge DrawBlock:(DrawBlock)drawBlock;

@end

NS_ASSUME_NONNULL_END

//
//  BICCoinDetailBottomView.h
//  Biconome
//
//  Created by 车林 on 2019/9/3.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BICGetWalletsResponse.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,Detail_Bottom_Type)
{
    Detail_Bottom_Recharge=99,//充值
    Detail_Bottom_Draw
};
typedef void(^RechargeBlock)(void);
typedef void(^DrawBlock)(void);
@interface BICCoinDetailBottomView : UIView
@property(nonatomic,strong)GetWalletsResponse* response;
-(instancetype)initWithNibRecharge:(RechargeBlock)recharge DrawBlock:(DrawBlock)drawBlock;

@end

NS_ASSUME_NONNULL_END

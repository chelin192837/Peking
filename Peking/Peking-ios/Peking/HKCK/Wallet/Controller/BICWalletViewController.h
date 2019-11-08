//
//  MarketViewController.h
//  Biconome
//
//  Created by 车林 on 2019/8/20.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,WalletSearchType)
{
    WalletSearchType_detail=99,//充提币页进入
    WalletSearchType_wallet //钱包首页进入
};
@interface BICWalletViewController : BaseViewController

@property(nonatomic,strong)NSArray* searchArray;

@property(nonatomic,assign)WalletSearchType pushType;

@end

NS_ASSUME_NONNULL_END

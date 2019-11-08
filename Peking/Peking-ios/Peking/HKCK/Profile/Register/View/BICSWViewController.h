//
//  BICSWViewController.h
//  Biconome
//
//  Created by 车林 on 2019/8/16.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWViewController.h"
#import "BICWalletTransferRequest.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,Wallet_Type)
{
    Wallet_Type_ETH=99,
    Wallet_Type_BTC
};
@interface BICSWViewController : BaseViewController

@property(nonatomic,strong) BICRegisterRequest * requsestModel;

@property (nonatomic,assign)LoginRegType loginType;

@property(nonatomic,strong) BICWalletTransferRequest * transferRequest;

@property (nonatomic,assign)Wallet_Type WalletType;

@property (nonatomic, copy) void (^backFinishItemOperationBlock)(void);

@end

NS_ASSUME_NONNULL_END

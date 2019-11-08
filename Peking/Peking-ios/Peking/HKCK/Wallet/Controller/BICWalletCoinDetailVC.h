//
//  BICWalletCoinDetailVC.h
//  Biconome
//
//  Created by 车林 on 2019/9/3.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BICGetWalletsResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface BICWalletCoinDetailVC : BaseViewController

@property(nonatomic,strong)GetWalletsResponse* response;
@property(nonatomic,assign)int indexRow;
@end

NS_ASSUME_NONNULL_END

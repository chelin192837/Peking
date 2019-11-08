//
//  BICWalletHistoryVC.h
//  Biconome
//
//  Created by 车林 on 2019/8/31.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "BICpcGetTransferInOutResponse.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,TRANSFER_TYPE)
{
    TRANSFER_TYPE_ALL=99,
    TRANSFER_TYPE_IN,
    TRANSFER_TYPE_OUT
};
@interface BICWalletHistoryVC : BaseViewController
@property(nonatomic,assign)TRANSFER_TYPE transferType;

@end

NS_ASSUME_NONNULL_END

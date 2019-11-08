//
//  BICWalletHistoryCell.h
//  Biconome
//
//  Created by 车林 on 2019/8/31.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BICpcGetTransferInOutResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface BICWalletHistoryCell : UITableViewCell
+(instancetype)exitWithTableView:(UITableView*)tableView;
@property(nonatomic,strong)GetTransferInOutResponse *response;
@property (nonatomic, copy) void (^cancelClickItemOperationBlock)(void);
@end

NS_ASSUME_NONNULL_END

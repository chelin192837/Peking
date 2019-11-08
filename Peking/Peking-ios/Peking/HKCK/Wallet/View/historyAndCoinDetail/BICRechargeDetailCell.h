//
//  BICRechargeDetailCell.h
//  Biconome
//
//  Created by 车林 on 2019/9/3.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BICpcGetTransferInOutResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface BICRechargeDetailCell : UITableViewCell
@property(nonatomic,strong)GetTransferInOutResponse *response;
+(instancetype)exitWithTableView:(UITableView*)tableView;

@end

NS_ASSUME_NONNULL_END

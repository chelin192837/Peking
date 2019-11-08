//
//  BICWalletDrawNumCell.h
//  Biconome
//
//  Created by 车林 on 2019/9/2.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BICGetWalletsResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface BICWalletDrawNumCell : UITableViewCell
+(instancetype)exitWithTableView:(UITableView*)tableView;
@property(nonatomic,strong)GetWalletsResponse * response;

@end

NS_ASSUME_NONNULL_END

//
//  BICCoinDetailCell.h
//  Biconome
//
//  Created by 车林 on 2019/9/3.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BICGetWalletsResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface BICCoinDetailCell : UITableViewCell

+(instancetype)exitWithTableView:(UITableView*)tableView;
@property(nonatomic,strong)GetWalletsResponse* response;


@end

NS_ASSUME_NONNULL_END

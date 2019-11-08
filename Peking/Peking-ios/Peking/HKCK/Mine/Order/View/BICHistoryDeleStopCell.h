//
//  BICHistoryDeleCell.h
//  Biconome
//
//  Created by 车林 on 2019/8/29.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BICListUserResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface BICHistoryDeleStopCell : UITableViewCell
@property(nonatomic,strong)ListUserRowsResponse*response;
+(instancetype)exitWithTableView:(UITableView*)tableView;

@end

NS_ASSUME_NONNULL_END

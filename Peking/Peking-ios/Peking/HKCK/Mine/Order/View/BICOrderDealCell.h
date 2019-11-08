//
//  BICDealCell.h
//  Biconome
//
//  Created by 车林 on 2019/8/29.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BICDealListByUserResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface BICOrderDealCell : UITableViewCell
+(instancetype)exitWithTableView:(UITableView*)tableView;
@property(nonatomic,strong)ListByUserResponse * response;
@end

NS_ASSUME_NONNULL_END

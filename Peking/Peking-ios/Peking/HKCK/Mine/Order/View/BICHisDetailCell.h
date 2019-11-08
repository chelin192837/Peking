//
//  BICHisDetailCell.h
//  Biconome
//
//  Created by 车林 on 2019/8/29.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BICListDetailByOrderIdResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface BICHisDetailCell : UITableViewCell

+(instancetype)exitWithTableView:(UITableView*)tableView;

@property(nonatomic,strong)ListDetailByOrderId * response;
@property(nonatomic,strong)ListUserRowsResponse *headerResponse;

@end

NS_ASSUME_NONNULL_END

//
//  BICEXCMainCell.h
//  Biconome
//
//  Created by 车林 on 2019/8/23.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CancelBlock) (ListUserRowsResponse*response);
@interface BICEXCMainStopCell : UITableViewCell
+(instancetype)exitWithTableView:(UITableView*)tableView;

@property(nonatomic,strong)ListUserRowsResponse*response;

@property(nonatomic,copy)CancelBlock cancelBlock;;


@end

NS_ASSUME_NONNULL_END

//
//  BICLinkTypeViewCell.h
//  Biconome
//
//  Created by a on 2019/9/25.
//  Copyright © 2019 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICLinkTypeViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, copy) void (^typeSelectItemOperationBlock)(int index);
@end

NS_ASSUME_NONNULL_END

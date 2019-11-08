//
//  BICPauseRechargeCell.h
//  Biconome
//
//  Created by 车林 on 2019/9/2.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,Pause_Type)
{
    Pause_Type_Recharge = 99,
    Pause_Type_WithDraw
};
@interface BICPauseRechargeCell : UITableViewCell
+(instancetype)exitWithTableView:(UITableView*)tableView;

@property(nonatomic,assign)Pause_Type type;

@end

NS_ASSUME_NONNULL_END

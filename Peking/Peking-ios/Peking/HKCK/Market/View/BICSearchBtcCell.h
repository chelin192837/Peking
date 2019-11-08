//
//  BICSearchBtcCell.h
//  Biconome
//
//  Created by 车林 on 2019/8/21.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICSearchBtcCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

+(instancetype)cellWithTableView:(UITableView*)tableView;

@end

NS_ASSUME_NONNULL_END

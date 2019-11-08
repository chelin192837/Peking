//
//  BICMineCell.h
//  Biconome
//
//  Created by 车林 on 2019/8/31.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICMineCell : UITableViewCell
+(instancetype)exitWithTableView:(UITableView*)tableView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIImageView *titleImg;
@property (weak, nonatomic) IBOutlet UILabel *titleTexLab;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (nonatomic,strong) UILabel *detailLabel;
@end

NS_ASSUME_NONNULL_END

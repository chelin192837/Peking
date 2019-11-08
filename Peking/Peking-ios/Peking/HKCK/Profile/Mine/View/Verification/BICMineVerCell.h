//
//  BICMineCell.h
//  Biconome
//
//  Created by 车林 on 2019/8/31.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICMineVerCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (assign, nonatomic)  Boolean ishaveTop;
@property (assign, nonatomic)  Boolean ishaveBottom;
@property (strong, nonatomic)  UIView *bgView;
@property (strong, nonatomic)  UIImageView *titleImg;
@property (strong, nonatomic)  UILabel *titleTexLab;
@property (strong, nonatomic)  UIImageView *tipImg;
@property (nonatomic,strong) UILabel *detailLabel;
@end

NS_ASSUME_NONNULL_END

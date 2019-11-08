//
//  BICDealCell.h
//  Biconome
//
//  Created by 车林 on 2019/8/10.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICDealCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView*)tableView;

@property(nonatomic,strong)getTopListResponse * model;

@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

NS_ASSUME_NONNULL_END

//
//  BICXWTabelCell.h
//  Biconome
//
//  Created by 车林 on 2019/8/16.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICXWTabelCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *countryNameLab;

@property (weak, nonatomic) IBOutlet UILabel *codeLab;

+(instancetype)exitWithTableView:(UITableView*)tableView;

@property (weak, nonatomic) IBOutlet UIView *topBgView;


@end

NS_ASSUME_NONNULL_END

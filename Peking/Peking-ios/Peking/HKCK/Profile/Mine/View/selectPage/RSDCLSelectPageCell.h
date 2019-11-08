//
//  RSDCLSelectPageCell.h
//  Agent
//
//  Created by jj on 2018/1/19.
//  Copyright © 2018年 七扇门. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSDCLSelectPageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *selectRadio;

@property (weak, nonatomic) IBOutlet UILabel *selectLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

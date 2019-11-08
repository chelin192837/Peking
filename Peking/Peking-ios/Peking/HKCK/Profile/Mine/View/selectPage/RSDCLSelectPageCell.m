//
//  RSDCLSelectPageCell.m
//  Agent
//
//  Created by jj on 2018/1/19.
//  Copyright © 2018年 七扇门. All rights reserved.
//

#import "RSDCLSelectPageCell.h"

@implementation RSDCLSelectPageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"RSDCLSelectPageCell";
    RSDCLSelectPageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"RSDCLSelectPageCell" owner:nil options:nil][0];
    }
    
    return cell;
}

@end

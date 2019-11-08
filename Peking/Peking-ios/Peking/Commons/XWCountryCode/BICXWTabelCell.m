//
//  BICXWTabelCell.m
//  Biconome
//
//  Created by 车林 on 2019/8/16.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICXWTabelCell.h"
@interface BICXWTabelCell()


@end
@implementation BICXWTabelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)exitWithTableView:(UITableView*)tableView
{
    NSString* cellId = @"BICXWTabelCell";
    BICXWTabelCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
    }
    
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

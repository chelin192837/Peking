//
//  BICMineComSecCell.m
//  Biconome
//
//  Created by 车林 on 2019/9/4.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICMineComSecCell.h"

@implementation BICMineComSecCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(instancetype)exitWithTableView:(UITableView*)tableView
{
    NSString* cellId = @"BICMineComSecCell";
    BICMineComSecCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
    }
    return cell;
}

@end

//
//  BICSearchBtcCell.m
//  Biconome
//
//  Created by 车林 on 2019/8/21.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICSearchBtcCell.h"

@implementation BICSearchBtcCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

+(instancetype)cellWithTableView:(UITableView*)tableView
{
    static NSString *ide = @"BICSearchBtcCell";
    BICSearchBtcCell *cell = [tableView dequeueReusableCellWithIdentifier:ide];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BICSearchBtcCell" owner:nil options:nil] firstObject];
    }
    
    return cell;
}


@end

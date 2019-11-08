//
//  BICBaseTableViewCell.m
//  Biconome
//
//  Created by 车林 on 2019/10/6.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICBaseTableViewCell.h"

@implementation BICBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

//+(instancetype)exitWithTableView:(UITableView*)tableView Id:(id)currentObjc
//{
//    NSString* cellId = NSStringFromClass(currentObjc);
//   
//    NSClassFromString(cellId) * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//    if (!cell) {
//        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
//    }
//    return cell;
//}



@end

//
//  BICAboutUsCell.m
//  Biconome
//
//  Created by 车林 on 2019/9/3.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICAboutUsCell.h"

@implementation BICAboutUsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = infoDic[@"CFBundleShortVersionString"];
    //Biconomy V
    self.versionLabel.text=[NSString stringWithFormat:@"Biconomy V%@",currentVersion];
}

+(instancetype)exitWithTableView:(UITableView*)tableView
{
    NSString* cellId = @"BICAboutUsCell";
    BICAboutUsCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
        
    }
    return cell;
}
@end

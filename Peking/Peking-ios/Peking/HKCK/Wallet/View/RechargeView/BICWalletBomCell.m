//
//  BICWalletBomCell.m
//  Biconome
//
//  Created by 车林 on 2019/8/31.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICWalletBomCell.h"
@interface BICWalletBomCell()

@property (weak, nonatomic) IBOutlet UIView *titileBgView;

@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
@implementation BICWalletBomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.titileBgView.backgroundColor = hexColorAlpha(FF9822, 0.1);
    self.titileBgView.layer.cornerRadius = 4.f;
    self.titileBgView.layer.masksToBounds = YES;
    
    self.bgView.layer.cornerRadius = 8.f;
//    self.bgView.layer.masksToBounds = YES;
    [self.bgView isYY];

    self.selectionStyle = UITableViewCellSelectionStyleNone;

//    "此地址只可接收" = "Sending coins except ";
//    "充值其他资产将不可找回" = " to this address result in the loss of your deposit";

    
//    self.titleTextLab.text = LAN(@"此地址只可接收BTC，充值其他资产将不可找回");
    
    
}


+(instancetype)exitWithTableView:(UITableView*)tableView
{
    NSString* cellId = @"BICWalletBomCell";
    BICWalletBomCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
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

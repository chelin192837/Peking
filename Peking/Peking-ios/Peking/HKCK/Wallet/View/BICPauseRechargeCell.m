//
//  BICPauseRechargeCell.m
//  Biconome
//
//  Created by 车林 on 2019/9/2.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICPauseRechargeCell.h"
@interface BICPauseRechargeCell()

@property (weak, nonatomic) IBOutlet UILabel *mainTitleLab;

@property (weak, nonatomic) IBOutlet UILabel *detailTitleLab;


@end
@implementation BICPauseRechargeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.mainTitleLab.text = LAN(@"暂停充值");
    self.detailTitleLab.text = LAN(@"该币种已暂停充值，感谢您的理解");
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}
+(instancetype)exitWithTableView:(UITableView*)tableView
{
    NSString* cellId = NSStringFromClass(self);
    
    BICPauseRechargeCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
    }
    return cell;
}

-(void)setType:(Pause_Type)type
{
    _type = type;
    if (_type==Pause_Type_Recharge) {
        self.mainTitleLab.text = LAN(@"暂停充值");
        self.detailTitleLab.text = LAN(@"该币种已暂停充值，感谢您的理解");
    }
    
    if (_type==Pause_Type_WithDraw) {
        self.mainTitleLab.text = LAN(@"暂停提币");
        self.detailTitleLab.text = LAN(@"该币种已暂停提币，感谢您的理解");
    }
    
}
@end

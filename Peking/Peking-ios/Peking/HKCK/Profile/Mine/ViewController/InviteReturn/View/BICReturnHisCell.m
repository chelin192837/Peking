//
//  BICReturnHisCell.m
//  Biconome
//
//  Created by 车林 on 2019/10/6.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICReturnHisCell.h"
@interface BICReturnHisCell()

@property (weak, nonatomic) IBOutlet UILabel *telLab;
@property (weak, nonatomic) IBOutlet UILabel *commissionLab;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;

@property (weak, nonatomic) IBOutlet UILabel *createTimeLab;



@end
@implementation BICReturnHisCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}
-(void)setModel:(InvitationInfo *)model
{
    _model = model;
    
    self.telLab.text = model.tel;
    
    self.createTimeLab.text = [UtilsManager getLocalDateFormateUTCDate:model.createTime];
    
//    self.statusLab.text = model.isEffective ? LAN(@"生效"):LAN(@"失效");
    
    self.commissionLab.text = [NSString stringWithFormat:@"%@ %@",model.amount,@"BTC"];
    
}
+(instancetype)exitWithTableView:(UITableView*)tableView
{
    NSString* cellId = NSStringFromClass(self);
    BICReturnHisCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
    }
    return cell;
}

@end

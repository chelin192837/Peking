//
//  BICInviteTopCell.m
//  Biconome
//
//  Created by 车林 on 2019/10/6.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICInviteTopCell.h"
@interface BICInviteTopCell()
@property (weak, nonatomic) IBOutlet UILabel *telLab;
@property (weak, nonatomic) IBOutlet UILabel *commissionLab;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (weak, nonatomic) IBOutlet UILabel *topLab;


@end
@implementation BICInviteTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}
-(void)setModel:(InvitationInfo *)model
{
    _model = model;

    if (model.index==1) {
        self.iconImg.image = [UIImage imageNamed:@"icon_rankinglist_first"];
    }else if (model.index==2)
    {
        self.iconImg.image = [UIImage imageNamed:@"icon_rankinglist_second"];
    }else if (model.index==3)
    {
        self.iconImg.image = [UIImage imageNamed:@"icon_rankinglist_third"];
    }else{
        self.iconImg.image = [UIImage imageNamed:@"icon_rankinglist_default"];
    }
    
    self.topLab.text = [NSString stringWithFormat:@"%d",model.index];
    
    self.telLab.text = model.pidTel;
    
    self.commissionLab.text = [NSString stringWithFormat:@"%@ %@",model.commission,@"BTC"];
    
    self.statusLab.text = model.isEffective ? LAN(@"生效"):LAN(@"失效");

}
+(instancetype)exitWithTableView:(UITableView*)tableView
{
    NSString* cellId = NSStringFromClass(self);
    BICInviteTopCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
    }
    return cell;
}

@end

//
//  BICMineCell.m
//  Biconome
//
//  Created by 车林 on 2019/8/31.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICMineCell.h"
@interface BICMineCell()
@property (weak, nonatomic) IBOutlet UIView *bgView;


@end
@implementation BICMineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.bgView isYY];
}

+(instancetype)exitWithTableView:(UITableView*)tableView
{
    NSString* cellId = @"BICMineCell";
    BICMineCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
    }
    return cell;
}
//-(void)layoutSubviews{
//    [super layoutSubviews];
//    self.detailTextLabel.frame=CGRectMake(CGRectGetMinX(self.titleImg.frame)-4-200, 0, 200, 56);
//    [self.contentView addSubview:self.detailLabel];
//
//}
//-(UILabel *)detailLabel{
//    if(!_detailLabel){
//        _detailLabel=[[UILabel alloc] init];
//        _detailLabel.font=[UIFont systemFontOfSize:15];
//        _detailLabel.textColor=UIColorWithRGB(0xFB9300);
//        _detailLabel.text=@"111";
//    }
//    return _detailLabel;
//}
@end

//
//  BICQRCodeCell.m
//  Biconome
//
//  Created by 车林 on 2019/8/31.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICQRCodeCell.h"
#import "BICImageManager.h"

@interface BICQRCodeCell()
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIView *titleBgView;

@property (weak, nonatomic) IBOutlet UILabel *titletextLab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleBGViewHeight;

@end

@implementation BICQRCodeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    self.bgView.layer.cornerRadius = 8.f;
//    self.bgView.layer.masksToBounds = YES;
    
    self.titleBgView.backgroundColor = hexColorAlpha(FF9822, 0.1);
    self.titleBgView.layer.cornerRadius = 4.f;
    self.titleBgView.layer.masksToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    self.titletextLab.text = LAN(@"备注和地址同时使用才能充值币到biconomy");
    
}
+(instancetype)exitWithTableView:(UITableView*)tableView
{
    NSString* cellId = @"BICQRCodeCell";
    BICQRCodeCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
    }
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setResponse:(GetWalletsResponse *)response
{
    _response = response;
    
    if (!response.isRemark) { //没有备注
        self.titleBGViewHeight.constant = 0.f;
        self.titleBgView.hidden = YES;
    }
    if(![self.response.tokenSymbol isEqualToString:@"USDT"]){
        self.bgView.layer.cornerRadius = 8.f;
        self.bgView.layer.masksToBounds = YES;
//        [self.bgView isYY];

        self.QRImage.image = [BICImageManager QRTranThoughString:response.addr WithSize:160];
        
    }else{
        
        NSArray *array = [response.addr componentsSeparatedByString:@"|"];
        self.QRImage.image = [BICImageManager QRTranThoughString:[array objectAtIndex:self.response.addrIndex] WithSize:160];
    }
}

@end

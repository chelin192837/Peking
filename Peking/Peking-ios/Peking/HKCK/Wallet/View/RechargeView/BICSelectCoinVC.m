//
//  BICSelectCoinVC.m
//  Biconome
//
//  Created by 车林 on 2019/8/31.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICSelectCoinVC.h"
@interface BICSelectCoinVC()
@property (weak, nonatomic) IBOutlet UILabel *coinLab;

@end
@implementation BICSelectCoinVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.bgView.layer.cornerRadius = 8.f;
//    self.bgView.layer.masksToBounds = YES;
    [self.bgView isYY];

    self.coinLab.text = LAN(@"币种");
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
+(instancetype)exitWithTableView:(UITableView*)tableView
{
    NSString* cellId = @"BICSelectCoinVC";
    BICSelectCoinVC * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
    }
    return cell;
}
-(void)setResponse:(GetWalletsResponse *)response
{
    _response = response;
    
    self.tokenSymbolLab.text = response.tokenSymbol?:@"Bitcoin";
    
    [self.loginAddrImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@"URL8801"/%@",kBaseUrl,response.logoAddr]] placeholderImage:kBTCImageIcon];

}
@end

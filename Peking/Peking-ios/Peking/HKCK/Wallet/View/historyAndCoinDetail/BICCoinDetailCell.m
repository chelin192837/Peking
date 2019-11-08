//
//  BICCoinDetailCell.m
//  Biconome
//
//  Created by 车林 on 2019/9/3.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICCoinDetailCell.h"
@interface BICCoinDetailCell()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *tokenSymbolLab;

@property (weak, nonatomic) IBOutlet UILabel *balanceLab;

@property (weak, nonatomic) IBOutlet UILabel *balanceUsedLab;
@property (weak, nonatomic) IBOutlet UILabel *totalLab;
@property (weak, nonatomic) IBOutlet UILabel *freeBalanceLab;
@property (weak, nonatomic) IBOutlet UILabel *freezzBalanceLab;
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;


@property (weak, nonatomic) IBOutlet UILabel *AmountTLab;
@property (weak, nonatomic) IBOutlet UILabel *balanceTLab;
@property (weak, nonatomic) IBOutlet UILabel *freeBalanceTLab;

@end
@implementation BICCoinDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    [self.bgView isYY];
    self.AmountTLab.text = LAN(@"总额");
    self.balanceTLab.text = LAN(@"可用余额");
    self.freeBalanceTLab.text = LAN(@"下单冻结");

}

+(instancetype)exitWithTableView:(UITableView*)tableView
{
    NSString* cellId = @"BICCoinDetailCell";
    BICCoinDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
    }
    return cell;
}

-(void)setResponse:(GetWalletsResponse *)response
{
    _response = response;
    
    self.tokenSymbolLab.text = response.tokenSymbol;
    NSString *imageurl=[NSString stringWithFormat:@"%@"URL8801"/%@",kBaseUrl,response.logoAddr];
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:kBTCImageIcon];
    
    NSString * value = NumFormat(response.btcValue);
    
    self.balanceLab.text = [NSString stringWithFormat:@"%@ BTC",value];
        
    self.totalLab.text = [NSString stringWithFormat:@"%.8lf",response.balance.doubleValue];
   
    self.totalLab.text = NumFormat(self.totalLab.text);

    self.freeBalanceLab.text = [NSString stringWithFormat:@"%.8lf",response.freeBalance.doubleValue];
    
    self.freeBalanceLab.text = NumFormat(self.freeBalanceLab.text);

    self.freezzBalanceLab.text = [NSString stringWithFormat:@"%.8lf",response.freezeBalance.doubleValue];
    
    self.freezzBalanceLab.text = NumFormat(self.freezzBalanceLab.text);

    
    
}

@end

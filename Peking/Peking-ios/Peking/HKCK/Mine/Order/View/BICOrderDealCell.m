//
//  BICOrderDealCell.m
//  Biconome
//
//  Created by 车林 on 2019/8/23.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICOrderDealCell.h"


@interface BICOrderDealCell ()

@property (weak, nonatomic) IBOutlet UILabel *coinTypeLab;

@property (weak, nonatomic) IBOutlet UILabel *orderTypeLab; //限价
@property (weak, nonatomic) IBOutlet UILabel *limitPriTypeLab; //买入

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UILabel *unitPriceLab;

@property (weak, nonatomic) IBOutlet UILabel *totalAmountLab;
@property (weak, nonatomic) IBOutlet UILabel *tradingNumLab;
@property (weak, nonatomic) IBOutlet UILabel *chaegeRatioLab;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLab;




@property (weak, nonatomic) IBOutlet UILabel *tradePriceTLab;
@property (weak, nonatomic) IBOutlet UILabel *tradeNumTLab;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountTLab;
@property (weak, nonatomic) IBOutlet UILabel *feeTLab;
@property (weak, nonatomic) IBOutlet UILabel *timeTLab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stopWidth;

@end

@implementation BICOrderDealCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.bgView.layer.cornerRadius = 8.f;
//    self.bgView.layer.masksToBounds = YES;
    [self.bgView isYY];

    self.bgView.backgroundColor = [UIColor whiteColor];
    //给bgView边框设置阴影
//    self.bgView.layer.shadowOffset = CGSizeMake(1,1);
//    self.bgView.layer.shadowOpacity = 0.6;
//    self.bgView.layer.shadowColor = [UIColor blackColor].CGColor;
    
    self.orderTypeLab.layer.cornerRadius = 4.f;
    self.orderTypeLab.layer.masksToBounds = YES;
    
    self.limitPriTypeLab.layer.cornerRadius = 4.f;
    self.limitPriTypeLab.layer.masksToBounds = YES;
    
    self.tradePriceTLab.text = LAN(@"成交价格");
    self.tradeNumTLab.text = LAN(@"成交量");
    self.totalAmountTLab.text = LAN(@"成交额");
    self.feeTLab.text = LAN(@"手续费");
    self.timeTLab.text = LAN(@"时间");

}

+(instancetype)exitWithTableView:(UITableView*)tableView
{
    NSString* cellId = @"BICOrderDealCell";
    BICOrderDealCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
    }
    return cell;
}

-(void)setResponse:(ListByUserResponse *)response
{
    self.coinTypeLab.text = [NSString stringWithFormat:@"%@/%@",response.coinName,response.unitName];
    
    if ([response.publishType isEqualToString:@"LIMIT"]) {
        self.limitPriTypeLab.text = LAN(@"限价");
        self.stopWidth.constant = 40.f;
    }else if([response.publishType isEqualToString:@"MARKET"])
    {
        self.limitPriTypeLab.text = LAN(@"市价");
        self.stopWidth.constant = 40.f;
    }else if([response.publishType isEqualToString:@"STOP"])
    {
        self.stopWidth.constant = 73.f;
        self.limitPriTypeLab.text = LAN(@"止盈止损");
    }
    
    NSString * unitStr = @"";

    if ([response.orderType isEqualToString:@"BUY"]) {
        
        self.orderTypeLab.text = LAN(@"买入");
        self.orderTypeLab.backgroundColor= kBICSaleBgColor;
        unitStr = response.coinName;
    }else if ([response.orderType isEqualToString:@"SELL"])
    {
        self.orderTypeLab.text = LAN(@"卖出");
        self.orderTypeLab.backgroundColor= kBICBuyBgColor;
        unitStr = response.unitName;
    }
    
    self.unitPriceLab.text = NumFormat(response.unitPrice);
    self.totalAmountLab.text = NumFormat(response.totalAmount);
    self.tradingNumLab.text  = NumFormat(response.tradingNum);
    
    self.chaegeRatioLab.text = [NSString stringWithFormat:@"%@ %@",NumFormat(response.serviceCharge),unitStr];
    
    self.createTimeLab.text = [UtilsManager getLocalDateFormateUTCDate:response.createTime];

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end


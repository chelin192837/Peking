//
//  BICItemCell.m
//  Biconome
//
//  Created by 车林 on 2019/8/10.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICItemCell.h"
#import "UIView+UIBezierPath.h"
#import "BICMarketGetResponse.h"
#import "NSObject+Extend.h"

@interface BICItemCell()
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (weak, nonatomic) IBOutlet UILabel *currencyPairLab;
@property (weak, nonatomic) IBOutlet UILabel *amountLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *percentLab;

@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation BICItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.currencyPairLab.textColor = kBICGetHomeTitleColor;
    self.amountLab.textColor = kBICGetHomeAmountColor;
    self.priceLab.textColor = kBICGetHomePriceColor;
    self.percentLab.textColor = kBICGetHomePercentGColor;

    self.bgView.layer.cornerRadius = 8.f;
//    self.bgView.layer.masksToBounds = YES;
    [self.bgView isYY];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateRate:) name:NSNotificationCenterBICRateConfig object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMarket:) name:NSNotificationCenteSockJSTopicMarket object:nil];

    

}
-(void)updateRate:(NSNotification*)notify
{
    if ([[BICDeviceManager getCurrentRate] isEqualToString:@"CNY"]) {
        self.priceLab.text = [NSString stringWithFormat:@"¥%.2f",_model.cnyAmount.doubleValue*_model.amount.doubleValue];
    }
    if ([[BICDeviceManager getCurrentRate] isEqualToString:@"USD"]) {
        self.priceLab.text = [NSString stringWithFormat:@"$%.2f",_model.usdAmount.doubleValue*_model.amount.doubleValue];
    }
}
-(void)updateMarket:(NSNotification*)notify
{
    marketGetResponse  *res = notify.object;
    
    getTopListResponse * response  = [getTopListResponse ZXY_ModelToModel:res];
    
    response.logoaddr = _model.logoaddr;
    
    if ([response.currencyPair isEqualToString:_model.currencyPair]) {
        [self setUI:response];
    }

}
-(void)setUI:(getTopListResponse *)model
{
    [self.titleImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@"URL8801"/%@",kBaseUrl,model.logoaddr]] placeholderImage:kBTCImageIcon];
    
    //    [self.titleImage sd_setImageWithURL:[NSURL URLWithString:model.logoaddr] placeholderImage:[UIImage imageNamed:@"btc"]];
    
    //交易对名字
    self.currencyPairLab.text = [model.currencyPair stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    
    //当前每个交易对相对基准币多少钱
    self.amountLab.text = model.amount;
    
    self.amountLab.text = NumFormat(self.amountLab.text);
    
    //折合人民币多少钱
    if ([[BICDeviceManager getCurrentRate] isEqualToString:@"CNY"]) {
        self.priceLab.text = [NSString stringWithFormat:@"%.2f",model.cnyAmount.doubleValue*model.amount.doubleValue];
        
        self.priceLab.text = NumFormat(self.priceLab.text);
        
        self.priceLab.text = [NSString stringWithFormat:@"¥%@",self.priceLab.text];
    }
    if ([[BICDeviceManager getCurrentRate] isEqualToString:@"USD"]) {
        self.priceLab.text = [NSString stringWithFormat:@"%.2f",model.usdAmount.doubleValue*model.amount.doubleValue];
        self.priceLab.text = NumFormat(self.priceLab.text);
        self.priceLab.text = [NSString stringWithFormat:@"$%@",self.priceLab.text];
        
    }
    
    double amount = model.amount.doubleValue;
    
    double percent = model.percent.doubleValue;
    
    double percentFinal = percent * 100; //百分比
    
    //上涨的的具体数值
    double total = amount*percent;
    NSString* totalValue = [NSString stringWithFormat:@"%f",total];

    //上涨的百分;
    NSString * fuStr = @"%";
    NSString * percentFinalStr = [NSString stringWithFormat:@"%.2f",percentFinal];//百分比保留两位数
    
    if ([model.percent containsString:@"-"]) {
        NSString* totalValueUp = [NSString stringWithFormat:@"%lf",-total];
        self.percentLab.textColor = kBICGetHomePercentBGRColor;
        self.percentLab.text =[NSString stringWithFormat:@"%@%@ %@%@",percentFinalStr,fuStr,@"-",NumFormat(totalValueUp)];
    }else{
        self.percentLab.textColor = kBICGetHomePercentBGGColor;
        self.percentLab.text =[NSString stringWithFormat:@"+%@%@ +%@",percentFinalStr,fuStr,NumFormat(totalValue)];
    }
    
}
-(void)setModel:(getTopListResponse *)model
{
    _model = model;
  
    [self setUI:model];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

@end

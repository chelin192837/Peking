//
//  BICDealCell.m
//  Biconome
//
//  Created by 车林 on 2019/8/10.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICDealCell.h"
#import "BICMarketGetResponse.h"
#import "NSObject+Extend.h"

@interface BICDealCell()

@property (weak, nonatomic) IBOutlet UILabel *lastPrice;
@property (weak, nonatomic) IBOutlet UILabel *currencyPairLab;
@property (weak, nonatomic) IBOutlet UILabel *amountLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;

@property (weak, nonatomic) IBOutlet UIButton *percentBtn;


@end
@implementation BICDealCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.bgView.backgroundColor = kBICWhiteColor;
    self.bgView.layer.cornerRadius = 8.f;
    [self.bgView isYY];
    
    self.currencyPairLab.textColor = kBICGetHomeCellTitleColor;
    
    self.amountLab.textColor = kBICGetHomeCellAmountColor;
    
    self.priceLab.textColor = kBICGetHomeCellLastPriceColor;
    
    self.lastPrice.textColor = kBICGetHomeCellLastPriceColor;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateRate:) name:NSNotificationCenterBICRateConfig object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(socketUpdate:) name:NSNotificationCenteSockJSTopicMarket object:nil];

}
+(instancetype)cellWithTableView:(UITableView*)tableView
{
    static NSString *ide = @"BICDealCell";
    BICDealCell *cell = [tableView dequeueReusableCellWithIdentifier:ide];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BICDealCell" owner:nil options:nil] firstObject];
    }

    return cell;
}

-(void)socketUpdate:(NSNotification*)noti
{
    marketGetResponse  *res = noti.object;
    
    getTopListResponse * response  = [getTopListResponse ZXY_ModelToModel:res];
    
    if ([response.currencyPair isEqualToString:_model.currencyPair]) {
        [self setUI:response];
    }

}
-(void)updateRate:(NSNotification*)notify
{
    if ([[BICDeviceManager getCurrentRate] isEqualToString:@"CNY"]) {
        self.priceLab.text = [NSString stringWithFormat:@"¥%.2f",[_model.cnyAmount floatValue]*_model.amount.doubleValue];
    }
    
    if ([[BICDeviceManager getCurrentRate] isEqualToString:@"USD"]) {
        self.priceLab.text = [NSString stringWithFormat:@"$%.2f",[_model.usdAmount floatValue]*_model.amount.doubleValue];
    }
}
-(void)setModel:(getTopListResponse *)model
{
    _model = model;
    
    [self setUI:model];
}

-(void)setUI:(getTopListResponse *)model
{
    self.currencyPairLab.text = [model.currencyPair stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    
    if ([[BICDeviceManager getCurrentRate] isEqualToString:@"CNY"]) {
        self.priceLab.text = [NSString stringWithFormat:@"%.2f",[model.cnyAmount floatValue]*model.amount.doubleValue];
    }
    
    if ([[BICDeviceManager getCurrentRate] isEqualToString:@"USD"]) {
        self.priceLab.text = [NSString stringWithFormat:@"%.2f",[model.usdAmount floatValue]*model.amount.doubleValue];
    }
    
    if ([[BICDeviceManager getCurrentRate] isEqualToString:@"CNY"]) {
        
        self.priceLab.text = NumFormat(self.priceLab.text);
        
        self.priceLab.text = [NSString stringWithFormat:@"¥%@",self.priceLab.text];
    }
    
    if ([[BICDeviceManager getCurrentRate] isEqualToString:@"USD"]) {
        self.priceLab.text = NumFormat(self.priceLab.text);
        self.priceLab.text = [NSString stringWithFormat:@"$%@",self.priceLab.text];
        
    }
    
//    self.priceLab.text = NumFormat(self.priceLab.text);
//    [NSString stringWithFormat:@"%f",[model.amount floatValue]]
    self.lastPrice.text = model.amount;
    
    self.lastPrice.text = NumFormat(self.lastPrice.text);
    
    //成交额 = 等于单价 * 成交次数
    double amount = model.amount.doubleValue;
    double total = model.total.doubleValue;
    double totalPrice = amount*total;
    NSString* totalValue = [NSString stringWithFormat:@"%.2lf",totalPrice];
    
    self.amountLab.text = NumFormat(totalValue);
    
    double percentFinal = model.percent.doubleValue * 100.f;
    NSString* fuStr = @"%";
    if ([model.percent containsString:@"-"]) {
        self.percentBtn.backgroundColor = kBICGetHomeCellBtnRColor;
        [self.percentBtn setTitle:[NSString stringWithFormat:@"%.2lf%@",percentFinal,fuStr] forState:UIControlStateNormal];
    }else{
        self.percentBtn.backgroundColor = kBICGetHomeCellBtnGColor;
        [self.percentBtn setTitle:[NSString stringWithFormat:@"+%.2lf%@",percentFinal,fuStr] forState:UIControlStateNormal];
    }
    
    [self.percentBtn setTitleColor:kBICWhiteColor forState:UIControlStateNormal];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

@end

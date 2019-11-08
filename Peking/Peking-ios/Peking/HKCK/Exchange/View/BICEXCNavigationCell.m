//
//  BICEXCNavigationCell.m
//  Biconome
//
//  Created by 车林 on 2019/8/24.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICEXCNavigationCell.h"
#import "BICMarketGetResponse.h"
#import "NSObject+Extend.h"
@interface BICEXCNavigationCell()

@property (weak, nonatomic) IBOutlet UILabel *lastPrice;
@property (weak, nonatomic) IBOutlet UILabel *currencyPairLab;
@property (weak, nonatomic) IBOutlet UILabel *amountLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;

@property (weak, nonatomic) IBOutlet UIButton *percentBtn;

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@end
@implementation BICEXCNavigationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.bgView.backgroundColor = kBICWhiteColor;
//    [self.bgView isYY];

    self.currencyPairLab.textColor = kBICGetHomeCellTitleColor;
    
    self.amountLab.textColor = kBICGetHomeCellAmountColor;
    
    self.priceLab.textColor = kBICGetHomeCellLastPriceColor;
    
    self.lastPrice.textColor = kBICGetHomeCellLastPriceColor;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateRate:) name:NSNotificationCenterBICRateConfig object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(socketUpdate:) name:NSNotificationCenteSockJSTopicMarket object:nil];

}
+(instancetype)cellWithTableView:(UITableView*)tableView
{
    static NSString *ide = @"BICEXCNavigationCell";
    BICEXCNavigationCell *cell = [tableView dequeueReusableCellWithIdentifier:ide];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BICEXCNavigationCell" owner:nil options:nil] firstObject];
    }
    
    return cell;
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


-(void)socketUpdate:(NSNotification*)noti
{
    marketGetResponse  *res = noti.object;
    
    getTopListResponse * response  = [getTopListResponse ZXY_ModelToModel:res];
    
    NSLog(@"MarketJs_%@",response);
    
    if ([response.currencyPair isEqualToString:_model.currencyPair]) {
        if (_model) {
            response.logoaddr = _model.logoaddr;
        }
        [self setUI:response];
    }

}

-(void)setUI:(getTopListResponse *)model
{
   //    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.logoaddr] placeholderImage:[UIImage imageNamed:@"btc"]];
       
       [self.iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@"URL8801"/%@",kBaseUrl,model.logoaddr]] placeholderImage:kBTCImageIcon];

       
       self.currencyPairLab.text = [model.currencyPair stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
       
       if ([[BICDeviceManager getCurrentRate] isEqualToString:@"CNY"]) {
           self.priceLab.text = [NSString stringWithFormat:@"¥%.2f",[model.cnyAmount floatValue]*_model.amount.doubleValue];

           
       }
       
       if ([[BICDeviceManager getCurrentRate] isEqualToString:@"USD"]) {
           self.priceLab.text = [NSString stringWithFormat:@"$%.2f",[model.usdAmount floatValue]*_model.amount.doubleValue];

       }
       
       
       self.lastPrice.text = model.amount;
       
       self.lastPrice.text = NumFormat(self.lastPrice.text);
       
       //成交额 = 等于单价 * 成交次数
       float amount = model.amount.doubleValue;
       float total = model.total.doubleValue;
       float totalPrice = amount*total;
       NSString* totalValue = [NSString stringWithFormat:@"%.2f",totalPrice];
       self.amountLab.text =totalValue;
       
       CGFloat percentFinal = model.percent.doubleValue * 100.f;
       NSString* fuStr = @"%";
       if ([model.percent containsString:@"-"]) {
           self.percentBtn.backgroundColor = kBICGetHomeCellBtnRColor;
           [self.percentBtn setTitle:[NSString stringWithFormat:@"%.2f%@",percentFinal,fuStr] forState:UIControlStateNormal];
       }else{
           self.percentBtn.backgroundColor = kBICGetHomeCellBtnGColor;
           [self.percentBtn setTitle:[NSString stringWithFormat:@"+%.2f%@",percentFinal,fuStr] forState:UIControlStateNormal];
       }
       
       [self.percentBtn setTitleColor:kBICWhiteColor forState:UIControlStateNormal];
       
       
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

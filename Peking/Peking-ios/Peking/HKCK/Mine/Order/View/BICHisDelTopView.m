//
//  BICHisDelTopView.m
//  Biconome
//
//  Created by 车林 on 2019/8/29.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICHisDelTopView.h"
@interface BICHisDelTopView()
@property (weak, nonatomic) IBOutlet UILabel *coinPairLab;
@property (weak, nonatomic) IBOutlet UILabel *unitPairLab;
@property (weak, nonatomic) IBOutlet UILabel *entrustLab;
@property (weak, nonatomic) IBOutlet UILabel *dealNumLab;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountLab;
@property (weak, nonatomic) IBOutlet UILabel *serviceChargeLab;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLab;

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UILabel *dealPercentLab;




@property (weak, nonatomic) IBOutlet UILabel *tradeDetailTLab;

@property (weak, nonatomic) IBOutlet UILabel *priceTLab;
@property (weak, nonatomic) IBOutlet UILabel *numTLab;
@property (weak, nonatomic) IBOutlet UILabel *filledTLab;
@property (weak, nonatomic) IBOutlet UILabel *feeTLab;
@property (weak, nonatomic) IBOutlet UILabel *conditionTLab;
@property (weak, nonatomic) IBOutlet UILabel *timeTLab;
@property (weak, nonatomic) IBOutlet UILabel *stopValueLab;

@end


@implementation BICHisDelTopView

-(instancetype)initWithNib
{

    self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
    
    self.bgView.layer.cornerRadius = 8.f;
//    self.bgView.layer.masksToBounds = YES;
    [self.bgView isYY];

    self.tradeDetailTLab.text = LAN(@"成交详情");
    self.priceTLab.text = [NSString stringWithFormat:@"%@/%@",LAN(@"委托价"),LAN(@"成交均价")];
    self.numTLab.text = [NSString stringWithFormat:@"%@/%@",LAN(@"委托数量"),LAN(@"成交数量")];

    self.filledTLab.text = LAN(@"成交额");
    self.feeTLab.text = LAN(@"手续费");
    self.conditionTLab.text = LAN(@"触发条件");
    self.timeTLab.text = LAN(@"时间");

    
    return self;
}
-(void)setResponse:(ListUserRowsResponse *)response
{

    self.coinPairLab.text = response.coinName;
    self.unitPairLab.text = [NSString stringWithFormat:@"/%@",response.unitName];
    
    NSString * limitPrice = @"";
    
    if ([response.publishType isEqualToString:@"LIMIT"]) {
        limitPrice = LAN(@"限价");
    }else if([response.publishType isEqualToString:@"MARKET"])
    {
        limitPrice = LAN(@"市价");
    }else if([response.publishType isEqualToString:@"STOP"])
    {
        limitPrice = LAN(@"止盈止损");
    }
    NSString * orderType = @"";
    
    if ([response.orderType isEqualToString:@"BUY"]) {
        
        orderType = LAN(@"买入");
        self.serviceChargeLab.text = [NSString stringWithFormat:@"%@ %@",NumFormat(response.dealCharge),response.coinName];


    }else if ([response.orderType isEqualToString:@"SELL"])
    {
        orderType= LAN(@"卖出");
        self.serviceChargeLab.text = [NSString stringWithFormat:@"%@ %@",response.dealCharge,response.unitName];

    }
    
    if (!response.triggerCondition) {
        self.stopValueLab.text = @"-";
    }else{
        self.stopValueLab.text = response.triggerCondition;
    }
    
    //成交百分比
    NSString * dealPercent = @"";
    if([response.publishType isEqualToString:@"MARKET"] && [response.orderType isEqualToString:@"BUY"]){
        if ([response.dealTurnover isEqualToString:response.entrustTurnover]) {
            dealPercent = [NSString stringWithFormat:@"%@%@",LAN(@"全部成交"),@"(100%)"];
        }else{
            if ((response.dealTurnover.integerValue==0) ||(response.entrustTurnover.integerValue==0)) {
                dealPercent = [NSString stringWithFormat:@"%@%@",LAN(@"部分成交"),@"(0%)"];
            }else{
                float percent = (response.dealNum.doubleValue / response.entrustNum.doubleValue)*100;
                NSString*str = @"%";
                
                dealPercent = [NSString stringWithFormat:@"%@(%.2f%@)",LAN(@"部分成交"),percent,str];
            }
        }
    }else{
        if ([response.dealNum isEqualToString:response.entrustNum]) {
            dealPercent = [NSString stringWithFormat:@"%@%@",LAN(@"全部成交"),@"(100%)"];
        }else{
            if ((response.dealNum.integerValue==0) ||(response.entrustNum.integerValue==0)) {
                dealPercent = [NSString stringWithFormat:@"%@%@",LAN(@"部分成交"),@"(0%)"];
            }else{
                float percent = (response.dealNum.doubleValue / response.entrustNum.doubleValue)*100;
                NSString*str = @"%";
                
                dealPercent = [NSString stringWithFormat:@"%@(%.2f%@)",LAN(@"部分成交"),percent,str];
            }
        }
    }
    if([response.publishType isEqualToString:@"MARKET"] && [response.orderType isEqualToString:@"BUY"]){
         if ([response.dealTurnover isEqualToString:response.entrustTurnover]) {
             self.dealPercentLab.text = [NSString stringWithFormat:@"%@  %@  %@",limitPrice,orderType,dealPercent];
         }else{
             self.dealPercentLab.text = [NSString stringWithFormat:@"%@  %@",limitPrice,orderType];
         }
        self.entrustLab.text = [NSString stringWithFormat:@"- / %@",NumFormat(response.dealPrice)];
        self.dealNumLab.text = [NSString stringWithFormat:@"- / %@",NumFormat(response.dealNum)];
    }else if([response.publishType isEqualToString:@"MARKET"] && [response.orderType isEqualToString:@"SELL"]){
        if ([response.dealNum isEqualToString:response.entrustNum]) {
            self.dealPercentLab.text = [NSString stringWithFormat:@"%@  %@  %@",limitPrice,orderType,dealPercent];
        }else{
            self.dealPercentLab.text = [NSString stringWithFormat:@"%@  %@",limitPrice,orderType];
        }
        self.entrustLab.text = [NSString stringWithFormat:@"- / %@",NumFormat(response.dealPrice)];
        self.dealNumLab.text = [NSString stringWithFormat:@"%@ / %@",NumFormat(response.entrustNum),NumFormat(response.dealNum)];
    }else{
        self.dealPercentLab.text = [NSString stringWithFormat:@"%@  %@  %@",limitPrice,orderType,dealPercent];
        self.entrustLab.text = [NSString stringWithFormat:@"%@ / %@",
        NumFormat(response.entrustPrice),NumFormat(response.dealPrice)];
        self.dealNumLab.text = [NSString stringWithFormat:@"%@ / %@",NumFormat(response.entrustNum),NumFormat(response.dealNum)];
    }
   
 
    if([response.orderStatus isEndWithString:@"CANCEL"]){
        self.dealPercentLab.text = [NSString stringWithFormat:@"%@  %@  %@",limitPrice,orderType,LAN(@"已取消")];
        self.tradeDetailTLab.text=@"";
    }
    
    
    
    self.totalAmountLab.text = [NSString stringWithFormat:@"%@ / %@",NumFormat(response.entrustTurnover),NumFormat(response.dealTurnover)];
    
    self.createTimeLab.text = [UtilsManager getLocalDateFormateUTCDate:response.createTime];
    
    
    
}


@end

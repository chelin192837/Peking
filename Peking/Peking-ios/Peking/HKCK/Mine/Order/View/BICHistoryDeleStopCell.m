//
//  BICHistoryDeleStopCell.m
//  Biconome
//
//  Created by 车林 on 2019/8/23.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICHistoryDeleStopCell.h"


@interface BICHistoryDeleStopCell ()

@property (weak, nonatomic) IBOutlet UILabel *coinTypeLab;

@property (weak, nonatomic) IBOutlet UILabel *orderTypeLab; //限价
@property (weak, nonatomic) IBOutlet UILabel *limitPriTypeLab; //买入

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *entrustLab;
@property (weak, nonatomic) IBOutlet UILabel *dealNumLab;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *orderStatusLab;


@property (weak, nonatomic) IBOutlet UILabel *delePriceLab;
@property (weak, nonatomic) IBOutlet UILabel *deleNumLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;


@property (weak, nonatomic) IBOutlet UILabel *stopLab;

@property (weak, nonatomic) IBOutlet UILabel *stopValueLab;

@end

@implementation BICHistoryDeleStopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.bgView.layer.cornerRadius = 8.f;
//    self.bgView.layer.masksToBounds = YES;
    [self.bgView isYY];

//    self.bgView.backgroundColor = [UIColor whiteColor];
//    //给bgView边框设置阴影
//    self.bgView.layer.shadowOffset = CGSizeMake(1,1);
//    self.bgView.layer.shadowOpacity = 0.6;
//    self.bgView.layer.shadowColor = [UIColor blackColor].CGColor;
    
    self.orderTypeLab.layer.cornerRadius = 4.f;
    self.orderTypeLab.layer.masksToBounds = YES;
    
    self.limitPriTypeLab.layer.cornerRadius = 4.f;
    self.limitPriTypeLab.layer.masksToBounds = YES;
    
    self.timeLab.text = LAN(@"时间");
    self.delePriceLab.text = [NSString stringWithFormat:@"%@/%@",LAN(@"委托价"),LAN(@"成交均价")];
    self.deleNumLab.text = [NSString stringWithFormat:@"%@/%@",LAN(@"委托数量"),LAN(@"成交数量")];
    self.stopLab.text =LAN(@"触发条件");
        
}

+(instancetype)exitWithTableView:(UITableView*)tableView
{
    NSString* cellId = @"BICHistoryDeleStopCell";
    BICHistoryDeleStopCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
    }
    return cell;
}

-(void)setResponse:(ListUserRowsResponse *)response
{
    _response = response;
    
    self.coinTypeLab.text = [NSString stringWithFormat:@"%@/%@",response.coinName,response.unitName];
    
    if ([response.publishType isEqualToString:@"LIMIT"]) {
        self.limitPriTypeLab.text = LAN(@"限价");
    }else if([response.publishType isEqualToString:@"MARKET"])
    {
        self.limitPriTypeLab.text = LAN(@"市价");
    }else if([response.publishType isEqualToString:@"STOP"])
    {
        self.limitPriTypeLab.text = LAN(@"止盈止损");
    }
    
    
    
    if ([response.orderType isEqualToString:@"BUY"]) {
        self.orderTypeLab.text = LAN(@"买入");
        self.orderTypeLab.backgroundColor= kBICSaleBgColor;
    }else if ([response.orderType isEqualToString:@"SELL"])
    {
        self.orderTypeLab.text = LAN(@"卖出");
        self.orderTypeLab.backgroundColor= kBICBuyBgColor;
    }
    
    if (!response.triggerCondition) {
        self.stopValueLab.text = @"-";
    }else{
        self.stopValueLab.text = response.triggerCondition;
    }
    
    self.entrustLab.text = [NSString stringWithFormat:@"%@/%@",NumFormat(response.entrustPrice),NumFormat(response.dealPrice)];
  
    
    self.dealNumLab.text = [NSString stringWithFormat:@"%@/%@",NumFormat(response.entrustNum),NumFormat(response.dealNum)];

    self.createTimeLab.text = [UtilsManager getLocalDateFormateUTCDate:response.createTime];
    
    
    self.orderStatusLab.text = LAN(response.orderStatus);
    
    if([response.publishType isEqualToString:@"MARKET"])
    {
          self.entrustLab.text = [NSString stringWithFormat:@"%@/%@",@"-",NumFormat(response.dealPrice)];
          
          self.dealNumLab.text = [NSString stringWithFormat:@"%@/%@",@"-",NumFormat(response.dealNum)];
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end


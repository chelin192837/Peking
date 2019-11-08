//
//  BICHisDetailCell.m
//  Biconome
//
//  Created by 车林 on 2019/8/29.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICHisDetailCell.h"
@interface BICHisDetailCell()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *unitPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *tradingNumLab;

@property (weak, nonatomic) IBOutlet UILabel *timeTLab;
@property (weak, nonatomic) IBOutlet UILabel *priceTLab;
@property (weak, nonatomic) IBOutlet UILabel *numTLab;

@end

@implementation BICHisDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.bgView.layer.cornerRadius = 8.f;
//    self.bgView.layer.masksToBounds = YES;
    [self.bgView isYY];

    self.timeTLab.text = LAN(@"时间");
    self.priceTLab.text = LAN(@"成交价");
    self.numTLab.text = LAN(@"成交量");

}

+(instancetype)exitWithTableView:(UITableView*)tableView
{
    NSString* cellId = @"BICHisDetailCell";
    BICHisDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
    }
    return cell;
}

-(void)setResponse:(ListDetailByOrderId *)response
{
    _response = response;
    if([self.headerResponse.orderStatus isEndWithString:@"CANCEL"]){
        self.createTimeLab.text = @"-";
        self.unitPriceLab.text = @"-";
        self.tradingNumLab.text = @"-";
    }else{
        if(response){
            self.createTimeLab.text = [UtilsManager getLocalDateFormateUTCDate:response.createTime];
            self.unitPriceLab.text = NumFormat(response.unitPrice);
            self.tradingNumLab.text = NumFormat(response.tradingNum);
        }
    }
    
}

-(void)setHeaderResponse:(ListUserRowsResponse *)headerResponse{
    _headerResponse=headerResponse;
}

@end



















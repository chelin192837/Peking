//
//  BICMainWalletCell.m
//  Biconome
//
//  Created by 车林 on 2019/8/30.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICMainWalletCell.h"
@interface BICMainWalletCell()
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIImageView *logImage;
@property (weak, nonatomic) IBOutlet UILabel *tokenSymbolLab;


@end
@implementation BICMainWalletCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.layer.cornerRadius = 8.f;
//    self.bgView.layer.masksToBounds = YES;
    
    [self.bgView isYY];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hide:) name:NSNotificationCenterBICWalletHideBalance object:nil];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
 
    
}

-(void)hide:(NSNotification*)notify
{
    NSNumber * obj =notify.object;
    
    if (obj.boolValue) {  // hide = yes
        self.balanceLab.text = @"********";
    }else{
        
        NSString * str = [NSString stringWithFormat:@"%.8f",_response.balance.doubleValue];
        
        self.balanceLab.text = [NSString stringWithFormat:@"%@",NumFormat(str)];
    }
}

+(instancetype)exitWithTableView:(UITableView*)tableView
{
    NSString* cellId = @"BICMainWalletCell";
    BICMainWalletCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
    }
    return cell;
}

-(void)setResponse:(GetWalletsResponse *)response
{
 
    _response = response;
    NSString *imageurl=[NSString stringWithFormat:@"%@"URL8801"/%@",kBaseUrl,response.logoAddr];
    [self.logImage sd_setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:kBTCImageIcon];
    
    self.tokenSymbolLab.text = response.tokenSymbol;
    
    NSDecimalNumber *tempNum = [NSDecimalNumber decimalNumberWithString:response.balance];
    if([tempNum compare:[NSDecimalNumber decimalNumberWithString:@"0"]]==NSOrderedSame){
        self.balanceLab.text =@"0.00000000";
    }else{
        self.balanceLab.text = [BICDeviceManager addComma:response.balance];
    }
//  self.balanceLab.text = NumFormat(self.balanceLab.text);
    
}

@end

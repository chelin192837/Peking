//
//  BICRechargeDetailCell.m
//  Biconome
//
//  Created by 车林 on 2019/9/3.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICRechargeDetailCell.h"
@interface BICRechargeDetailCell()

@property (weak, nonatomic) IBOutlet UILabel *tokenSymbolLab;
@property (weak, nonatomic) IBOutlet UIImageView *logaddrImg;
@property (weak, nonatomic) IBOutlet UILabel *balanceLab;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@property (weak, nonatomic) IBOutlet UILabel *chainType;
@property (weak, nonatomic) IBOutlet UILabel *addrLab;
@property (weak, nonatomic) IBOutlet UILabel *gasPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *hashTextIdlab;

@property (weak, nonatomic) IBOutlet UILabel *createTimeLab;
@property (weak, nonatomic) IBOutlet UIView *gasBGView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *gasHeight;




@property (weak, nonatomic) IBOutlet UILabel *totalTLab;

@property (weak, nonatomic) IBOutlet UILabel *statusTLab;

@property (weak, nonatomic) IBOutlet UILabel *chainTypeLab;

@property (weak, nonatomic) IBOutlet UILabel *addressTLab;

@property (weak, nonatomic) IBOutlet UILabel *feeTLab;

@property (weak, nonatomic) IBOutlet UILabel *blockCormLab;

@property (weak, nonatomic) IBOutlet UILabel *txidTLab;

@property (weak, nonatomic) IBOutlet UILabel *timeTLab;


@property (weak, nonatomic) IBOutlet UIView *bgView;


@end
@implementation BICRechargeDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.totalTLab.text = LAN(@"数量");
    self.statusTLab.text = LAN(@"状态");
    self.chainTypeLab.text = LAN(@"链类型");
    self.addressTLab.text = LAN(@"地址");
    self.feeTLab.text = LAN(@"手续费");
    self.blockCormLab.text = LAN(@"区块确认");
    self.txidTLab.text = @"Txid";
    self.timeTLab.text = LAN(@"时间");
    
    self.bgView.layer.cornerRadius = 8.f;
    [self.bgView isYY];

}
+(instancetype)exitWithTableView:(UITableView*)tableView
{
    NSString* cellId = @"BICRechargeDetailCell";
    BICRechargeDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
    }
    return cell;
}
-(void)setResponse:(GetTransferInOutResponse *)response
{
    _response = response;
    
    NSString *imageurl=[NSString stringWithFormat:@"%@"URL8801"/%@",kBaseUrl,response.logoAddr];
    [self.logaddrImg sd_setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:kBTCImageIcon];
    self.tokenSymbolLab.text = response.tokenSymbol;
    self.balanceLab.text = response.amount;
    
    self.statusLab.text = [self getStatus:response.status];
    
    self.chainType.text = response.chainType;
    
    self.gasPriceLab.text = [NSString stringWithFormat:@"%@ %@",response.gasPrice?:@"0",response.tokenSymbol];
    
    self.hashTextIdlab.text = response.khash?:@"---";
    
    self.createTimeLab.text = [UtilsManager getLocalDateFormateUTCDate:response.createTime];
    if ([response.transferType isEqualToString:@"IN"]) {//充值
        self.addrLab.text = response.fromAddr;
        self.gasBGView.hidden = YES;
        self.gasHeight.constant = 0.f;

    }
    if ([response.transferType isEqualToString:@"OUT"]) {//提现
        self.addrLab.text = response.toAddr;
    }
    
    
}

-(NSString*)getStatus:(NSString*)status
{
    NSString* statusValue=@"";
    switch (status.integerValue) {
        case 0:
        {
            statusValue = LAN(@"失败");
        }
            break;
        case 1:
        {
            statusValue = LAN(@"成功");
            
        }
            break;
        case 2:
        {
            statusValue = LAN(@"待初审提币");
            
        }
            break;
        case 3:
        {
            statusValue = LAN(@"待复审提币");
            
        }
            break;
        case 4:
        {
            statusValue = LAN(@"待出币");
            
        }
            break;
        case 5:
        {
            statusValue = LAN(@"打包中");
            
        }
            break;
        case 6:
        {
            statusValue = LAN(@"出币失败");
            
        }
            break;
        case 7:
        {
            statusValue = LAN(@"审核不通过");
            
        }
            break;
        case 8:
        {
            statusValue = LAN(@"已取消");
            
        }
            break;
            
        default:
            break;
    }
    return statusValue;
}

@end

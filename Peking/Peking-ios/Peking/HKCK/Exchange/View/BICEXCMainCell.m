//
//  BICEXCMainCell.m
//  Biconome
//
//  Created by 车林 on 2019/8/23.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICEXCMainCell.h"
#import "MDRadialProgressView.h"
#import "MDRadialProgressTheme.h"
#import "MDRadialProgressLabel.h"

@interface BICEXCMainCell ()
@property (weak, nonatomic) IBOutlet UILabel *coinTypeLab;

@property (weak, nonatomic) IBOutlet UILabel *orderTypeLab; //限价
@property (weak, nonatomic) IBOutlet UILabel *limitPriTypeLab; //买入

@property (weak, nonatomic) IBOutlet UILabel *unitPriceLab;

@property (weak, nonatomic) IBOutlet UILabel *totalNumLab;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLab;

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *progreView;


@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UILabel *delePriceLab;
@property (weak, nonatomic) IBOutlet UILabel *numLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@property(nonatomic,strong) MDRadialProgressView *radialView;
@end

@implementation BICEXCMainCell
- (IBAction)cancelBtn:(id)sender {
    BICOrderCancelRequest*request =[[BICOrderCancelRequest alloc] init];
    request.orderId = _response.id;
    WEAK_SELF
    [[BICExchangeService sharedInstance] analyticalOrderCancelData:request serverSuccessResultHandler:^(id response) {
        BICBaseResponse * responseM = (BICBaseResponse*)response;
        if (responseM.code==200) {
            [BICDeviceManager AlertShowTip:LAN(@"取消成功")];
            if (weakSelf.cancelBlock) {
                weakSelf.cancelBlock(weakSelf.response);
            }
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
    } failedResultHandler:^(id response) {
        
    } requestErrorHandler:^(id error) {
        
    }];
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.bgView.backgroundColor = [UIColor whiteColor];

    self.bgView.layer.cornerRadius = 8.f;
//    self.bgView.layer.masksToBounds = YES;
    [self.bgView isYY];
    
    //给bgView边框设置阴影
//    self.bgView.layer.shadowOffset = CGSizeMake(1,1);
//    self.bgView.layer.shadowOpacity = 0.6;
//    self.bgView.layer.shadowColor = [UIColor blackColor].CGColor;
    
    self.orderTypeLab.layer.cornerRadius = 4.f;
    self.orderTypeLab.layer.masksToBounds = YES;
    
    self.limitPriTypeLab.layer.cornerRadius = 4.f;
    self.limitPriTypeLab.layer.masksToBounds = YES;
    

    [self.progreView addSubview:self.radialView];
    
    
    [self.cancelBtn setTitle:LAN(@"取消") forState:UIControlStateNormal];
    
    self.delePriceLab.text = LAN(@"委托价");
    self.numLab.text = LAN(@"数量");
    
    self.timeLab.text = LAN(@"时间");
    
}


-(MDRadialProgressView*)radialView
{
    if (!_radialView) {
        MDRadialProgressTheme *newTheme = [[MDRadialProgressTheme alloc] init];
        newTheme.completedColor = kBICExcProCicleColor;
        newTheme.incompletedColor = kBICHistoryCellBGColor;
        newTheme.centerColor = [UIColor clearColor];
        newTheme.labelColor = kBICExcProTextColor;
        newTheme.font = [UIFont systemFontOfSize:14.f weight:UIFontWeightMedium];
        _radialView = [[MDRadialProgressView alloc] initWithFrame:CGRectMake(0, 0, 52, 52) andTheme:newTheme];
        _radialView.progressTotal = 100;
        _radialView.progressCounter = 25;
        _radialView.theme.sliceDividerHidden = YES;
    }
    return _radialView;
}
+(instancetype)exitWithTableView:(UITableView*)tableView
{
    NSString* cellId = @"BICEXCMainCell";
    BICEXCMainCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
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
    
    self.unitPriceLab.text = NumFormat(response.unitPrice);
    
    self.totalNumLab.text = NumFormat(response.totalNum);
    
    self.createTimeLab.text = [UtilsManager getLocalDateFormateUTCDate:response.createTime];
    
    //percent
    
    double precent=0.f;
    
    if ([response.publishType isEqualToString:@"LIMIT"]) { //限价
        
        double totalNum = [response.totalNum doubleValue];
        double changeNum = [response.totalNum doubleValue] - [response.lastNum doubleValue];
        precent = changeNum/totalNum;
        
    }else if([response.publishType isEqualToString:@"MARKET"]) //市价
    {
        if ([response.orderType isEqualToString:@"BUY"]) {
            double totalNum = [response.totalTurnover doubleValue];
            double changeNum = [response.totalTurnover doubleValue] - [response.lastTurnover doubleValue];
            precent = changeNum/totalNum;
            
        }else if ([response.orderType isEqualToString:@"SELL"])
        {
            double totalNum = [response.totalNum doubleValue];
            double changeNum = [response.totalNum doubleValue] - [response.lastNum doubleValue];
            precent = changeNum/totalNum;
        }
        
    }

    
    int precentInt = (int)(precent*100);
    
    if (precentInt==0) {
        self.radialView.progressTotal = 1000;
        self.radialView.progressCounter = 1;
        self.radialView.label.text = @"0%";
    }else{
        self.radialView.progressTotal = 100;
        self.radialView.progressCounter = precentInt;
        NSString* str = @"%";
        self.radialView.label.text = [NSString stringWithFormat:@"%d%@",precentInt,str];
    }
    
    if([response.publishType isEqualToString:@"MARKET"])
    {
     self.unitPriceLab.text = @"-";
    
        if([response.orderType isEqualToString:@"BUY"]){
            self.totalNumLab.text = @"-";
        }
        
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

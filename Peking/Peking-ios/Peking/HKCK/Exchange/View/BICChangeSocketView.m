//
//  BICChangeSocketView.m
//  Biconome
//
//  Created by 车林 on 2019/8/23.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICChangeSocketView.h"
#import "BICEXChangeLine.h"
#import "BICEXCHorLine.h"
#import "BICMarketGetResponse.h"
#import "BICSockJSRouter.h"

@interface BICChangeSocketView()

@property(nonatomic,strong)BICEXCHorLine * horLineTop;

@property(nonatomic,strong)BICEXCHorLine * horLineBottom;
@property(nonatomic,strong)UILabel * priceLab;
@property(nonatomic,strong)UILabel * totalNumLab;
@property(nonatomic,strong)UILabel *BicMoney;
@property(nonatomic,strong)UILabel *YuanMoney;
@property(nonatomic,strong)BICMarketGetResponse * responseM;
@end

@implementation BICChangeSocketView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.layer.cornerRadius = 8.f;
//        self.layer.masksToBounds = YES;
        [self isYY];
        
        kADDNSNotificationCenter(NSNotificationCenterBICChangeSocketView);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(middenPrice:) name:NSNotificationCenterMarketGet object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SockJS_Type_Market:) name:NSNotificationCenteSockJSTopicMarket object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateRate:) name:NSNotificationCenterBICRateConfig object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(topicSubscription:) name:NSNotificationCenteSockJSTopicSubscription object:nil];

        [self setupUI:frame];
    }
    return self;
}
-(void)setupUI:(CGRect)frame
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UILabel * priceLab = [[UILabel alloc] init];
    self.priceLab=priceLab;
    NSString*priceStr = LAN(@"价格");
    priceLab.text = [NSString stringWithFormat:@"%@",priceStr];
    priceLab.font = [UIFont systemFontOfSize:12.f];
    priceLab.textColor = kBICGetHomeAmountColor;
    [self addSubview:priceLab];
    [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.top.equalTo(self).offset(12);
    }];
    
    UILabel * totalNumLab = [[UILabel alloc] init];
    self.totalNumLab=totalNumLab;
    NSString*NumStr = LAN(@"数量");
    totalNumLab.text = [NSString stringWithFormat:@"%@",NumStr];
    totalNumLab.font = [UIFont systemFontOfSize:12.f];
    totalNumLab.textColor = kBICGetHomeAmountColor;
    [self addSubview:totalNumLab];
    [totalNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-12);
        make.top.equalTo(self).offset(12);
    }];
    
    BICEXCHorLine * horLineTop = [[BICEXCHorLine alloc] initWithFrame:CGRectMake(12,37, self.width-12*2,5*28) With:HorLineType_red];
    self.horLineTop = horLineTop;
    [self addSubview:horLineTop];
    
    UIView *middenView = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(horLineTop.frame), frame.size.width, 53)];
    [self addSubview:middenView];

    UILabel *BicMoney = [[UILabel alloc] init];
    self.BicMoney=BicMoney;
    BicMoney.text = @"0.00";
    BicMoney.font = [UIFont systemFontOfSize:18.f weight:UIFontWeightMedium];
    BicMoney.textColor = kBICGetHomeTitleColor;
    [middenView addSubview:BicMoney];
    [BicMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(middenView);
        make.top.equalTo(middenView).offset(8);
    }];
    
    UILabel *YuanMoney = [[UILabel alloc] init];
    self.YuanMoney=YuanMoney;
    YuanMoney.text = @"¥0.00";
    YuanMoney.font = [UIFont systemFontOfSize:12.f weight:UIFontWeightRegular];
    YuanMoney.textColor = kBoardTextColor;
    [middenView addSubview:YuanMoney];
    [YuanMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(middenView);
        make.bottom.equalTo(middenView).offset(-8);
    }];
    
    BICEXCHorLine * horLineBottom = [[BICEXCHorLine alloc] initWithFrame:CGRectMake(12, 173+53, self.width-12*2,5*28) With:HorLineType_Green];
    self.horLineBottom = horLineBottom;
    [self addSubview:horLineBottom];
    
}
-(void)topicSubscription:(NSNotification*)notify
{
    BICCoinAndUnitResponse *responseM = notify.object;
    
    if (responseM) {
        NSMutableArray * sellArr = [[NSMutableArray alloc] init];
        if (responseM.data.SELL_ORDERS.count>0) {
            for (int i=0; i<responseM.data.SELL_ORDERS.count; i++) {
                [sellArr addObject:responseM.data.SELL_ORDERS[i]];
            }
        }
        self.horLineTop.arr = sellArr.copy;
        self.horLineBottom.arr = responseM.data.BUY_ORDERS;
    }
    
}
-(void)notify:(NSNotification*)notify
{
    BICCoinAndUnitResponse *responseM = notify.object;
    
    if (responseM) {
        NSMutableArray * sellArr = [[NSMutableArray alloc] init];
        if (responseM.data.SELL_ORDERS.count>0) {
            for (int i=0; i<responseM.data.SELL_ORDERS.count; i++) {
                [sellArr addObject:responseM.data.SELL_ORDERS[i]];
            }
        }
        self.horLineTop.arr = sellArr.copy;
        self.horLineBottom.arr = responseM.data.BUY_ORDERS;
    }

}
-(void)SockJS_Type_Market:(NSNotification*)noti
{
    [self middenPrice:noti];
}
-(void)middenPrice:(NSNotification*)noti
{
    BICMarketGetResponse * responseM ;
    
    if ([noti.object isKindOfClass:[marketGetResponse class]]) {
        marketGetResponse * response = noti.object;
        responseM = [[BICMarketGetResponse alloc] init];
        responseM.data = response;
    }else{
        responseM = noti.object;
    }
    self.responseM = responseM;
    
   NSString *  currencyPair = [NSString stringWithFormat:@"%@-%@",[BICDeviceManager GetPairCoinName],[BICDeviceManager GetPairUnitName]];

    if (responseM) {
        if ([responseM.data.currencyPair isEqualToString:currencyPair]) {
               self.BicMoney.text = responseM.data.amount;
//            RSDLog(@"%@",responseM.data.amount);
               self.BicMoney.text = NumFormat(self.BicMoney.text);
               if ([[BICDeviceManager getCurrentRate] isEqualToString:@"CNY"]) {
                   float yuan = self.responseM.data.amount.doubleValue * self.responseM.data.cnyAmount.doubleValue;
                   NSString * yuanStr = [NSString stringWithFormat:@"%.2f",yuan];
                   self.YuanMoney.text = [NSString stringWithFormat:@"¥%@",NumFormat(yuanStr)];
                   
               }
               
               if ([[BICDeviceManager getCurrentRate] isEqualToString:@"USD"]) {
                   float yuan = self.responseM.data.amount.doubleValue * self.responseM.data.usdAmount.doubleValue;
                   NSString * yuanStr = [NSString stringWithFormat:@"%.2f",yuan];
                   self.YuanMoney.text = [NSString stringWithFormat:@"$%@",NumFormat(yuanStr)];
               }
           }
    }
   

}

-(void)updateRate:(NSNotification*)notify
{
    if ([[BICDeviceManager getCurrentRate] isEqualToString:@"CNY"]) {
        float yuan = self.responseM.data.amount.doubleValue * self.responseM.data.cnyAmount.doubleValue;
        NSString * yuanStr = [NSString stringWithFormat:@"%.2f",yuan];
        self.YuanMoney.text = [NSString stringWithFormat:@"¥%@",NumFormat(yuanStr)];
    }
    
    if ([[BICDeviceManager getCurrentRate] isEqualToString:@"USD"]) {
        float yuan = self.responseM.data.amount.doubleValue * self.responseM.data.usdAmount.doubleValue;
        NSString * yuanStr = [NSString stringWithFormat:@"%.2f",yuan];
        self.YuanMoney.text = [NSString stringWithFormat:@"$%@",NumFormat(yuanStr)];
    }
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

//
//  BICEXCMiddenView.m
//  Biconome
//
//  Created by 车林 on 2019/8/23.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICEXCMiddenView.h"
#import "BICChangeSocketView.h"
#import "BICChangePriceView.h"

@interface BICEXCMiddenView()

@property(nonatomic,strong)BICChangePriceView * changePriceView;

@end


@implementation BICEXCMiddenView

-(instancetype)initWithFrame:(CGRect)frame With:(ChangePriceType)priceType OrderType:(ChangeOrderType)orderType
{
    if (self=[super initWithFrame:frame]) {
        [self setupUI:priceType OrderType:orderType];
    }
    return self;
}

-(void)setVc:(BICEXCMainVC *)vc
{
    self.changePriceView.vc = vc;
}
-(void)setupUI:(ChangePriceType)priceType OrderType:(ChangeOrderType)orderType
{
    
    BICChangeSocketView * socketView = [[BICChangeSocketView alloc]initWithFrame:CGRectMake(kBICMargin, kBICMargin, self.width/2-6-kBICMargin, self.height-kBICMargin)];
    socketView.backgroundColor = [UIColor whiteColor];
    [self addSubview:socketView];
//    [socketView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(kBICMargin);
//        make.right.equalTo(self.mas_centerX).offset(-6);
//        make.top.equalTo(self).offset(kBICMargin);
//        make.bottom.equalTo(self);
//    }];
//    [socketView setupUI];
    
    BICChangePriceView * changePriceView = [[BICChangePriceView alloc] initWithNib];
    self.changePriceView = changePriceView;
    changePriceView.priceType = priceType;
    changePriceView.orderType = orderType;
    [self addSubview:changePriceView];
    [changePriceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-kBICMargin);
        make.top.equalTo(socketView);
        make.left.equalTo(self.mas_centerX).offset(6);
        make.bottom.equalTo(self);
    }];
    
    [changePriceView updateUI:priceType OrderType:orderType];
    
//    changePriceView.priceType=priceType;

}


@end

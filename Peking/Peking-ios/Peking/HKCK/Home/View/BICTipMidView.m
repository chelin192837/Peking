//
//  BICTipMidView.m
//  Biconome
//
//  Created by 车林 on 2019/8/10.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICTipMidView.h"
@interface BICTipMidView()

@property(nonatomic,strong)UILabel* leftLabel;
@property(nonatomic,strong)UILabel* middenLabel;
@property(nonatomic,strong)UILabel* rightLabel;

@end

@implementation BICTipMidView

+(instancetype)initWithNib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
}
-(void)updateUI
{
    self.leftLabel.text = LAN(@"币种/成交额");
    self.middenLabel.text = LAN(@"最新价");
    self.rightLabel.text = LAN(@"24H涨跌");
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = kBICHomeBGColor;
        
        self.userInteractionEnabled = NO ;
        UILabel * leftLabel = [[UILabel alloc] init];
        self.leftLabel=leftLabel;
        leftLabel.textColor=kBICGetHomeBtcKindColor;
        leftLabel.font = [UIFont systemFontOfSize:14.f];
        leftLabel.text = LAN(@"币种/成交额");
        
        [self addSubview:leftLabel];
        [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(kBICMargin);
            make.centerY.equalTo(self);
        }];
        
        UILabel * middenLabel = [[UILabel alloc] init];
        self.middenLabel=middenLabel;
        middenLabel.textColor=kBICGetHomeBtcKindColor;
        middenLabel.font = [UIFont systemFontOfSize:14.f];
        middenLabel.text = LAN(@"最新价");
        [self addSubview:middenLabel];
        [middenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.leading.equalTo(self.mas_centerX).offset(-22);
        }];
        
        UILabel * rightLabel = [[UILabel alloc] init];
        self.rightLabel=rightLabel;
        rightLabel.font = [UIFont systemFontOfSize:14.f];
        rightLabel.textColor=kBICGetHomeBtcKindColor;
        rightLabel.text = LAN(@"24H涨跌");
        [self addSubview:rightLabel];
        [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-kBICMargin);
            make.centerY.equalTo(self);
        }];
        

    }
    return self;
}
@end

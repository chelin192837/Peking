//
//  BICEXChangeLine.m
//  Biconome
//
//  Created by 车林 on 2019/8/24.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICEXChangeLine.h"
#import "BICEXChangeModel.h"
#import "BICEXCHorLine.h"

@implementation BICEXChangeLine

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI
{
    UILabel * priceLab = [[UILabel alloc] init];
    
    priceLab.text = [NSString stringWithFormat:@"%@(USDT)",LAN(@"价格")];
    priceLab.font = [UIFont systemFontOfSize:12.f];
    priceLab.textColor = kBICGetHomeAmountColor;
    [self addSubview:priceLab];
    [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.top.equalTo(self).offset(12);
    }];
    
    UILabel * totalNumLab = [[UILabel alloc] init];
    totalNumLab.text = [NSString stringWithFormat:@"%@(USDT)",LAN(@"数量")];
    totalNumLab.font = [UIFont systemFontOfSize:12.f];
    totalNumLab.textColor = kBICGetHomeAmountColor;
    [self addSubview:totalNumLab];
    [totalNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-12);
        make.top.equalTo(self).offset(12);
    }];
    
    BICEXCHorLine * horLine = [[BICEXCHorLine alloc] initWithFrame:CGRectMake(0, 40, self.width,5*28)];
    [self addSubview:horLine];
    

}


@end

//
//  BICEXCChangeDoneView.m
//  Biconome
//
//  Created by 车林 on 2019/8/26.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICEXCChangeDoneView.h"
#import "BICEXCMiddenLine.h"

@interface BICEXCChangeDoneView()

@property (weak, nonatomic) IBOutlet BICEXCChangeDoneView *middenView;

@property(nonatomic,strong)BICEXCHorLine * middenLineTop;

@property (weak, nonatomic) IBOutlet UILabel *changedLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *numLab;

@end

@implementation BICEXCChangeDoneView

-(instancetype)initWithNib
{
    self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
    
    self.layer.cornerRadius = 8.f;
//    self.layer.masksToBounds = YES;
    [self isYY];
    [self setupUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notify:) name:NSNotificationCenteSockJSTopicHistory object:nil];
    
    return self;
}

-(void)setupUI
{
    self.changedLab.text = LAN(@"成交");
    self.timeLab.text = LAN(@"时间");
    self.priceLab.text = LAN(@"价格");
    self.numLab.text = LAN(@"数量");

    
    CGFloat width = (SCREEN_WIDTH-4*kBICMargin);

    BICEXCHorLine * middenLineTop = [[BICEXCHorLine alloc] initWithMiddenFrame:CGRectMake(0,0, width,6*28) With:HorLineType_Green];
    self.middenLineTop = middenLineTop ;
    [self.middenView addSubview:middenLineTop];
    
}
-(void)setResponseM:(BICGetTopListResponse *)responseM
{
    self.middenLineTop.arrMidArr=responseM.data;
}
-(void)notify:(NSNotification*)noti
{
    BICGetHistoryListResponse *responseM = noti.object;
    
    self.middenLineTop.arrMidArr=responseM.data;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
@end

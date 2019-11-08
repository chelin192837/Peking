//
//  BICEXCRightLine.m
//  Biconome
//
//  Created by 车林 on 2019/8/24.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICEXCRightLine.h"
@interface BICEXCRightLine()
@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (weak, nonatomic) IBOutlet UILabel *leftLab;
@property (weak, nonatomic) IBOutlet UILabel *rightLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bannerConstent;

@end

@implementation BICEXCRightLine

-(instancetype)initWithNibWith:(HorLineType)type
{
    self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
    [self setupUI:type];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
    return self;
}

-(void)tap:(UITapGestureRecognizer*)tap
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenterHorLineToChangePrice object:self.model];
}

-(void)updateUI:(NSNotification*)noti
{
    NSDictionary * dic = noti.object;
    NSString *length = @"80";
    if (dic) {
        length = dic[@"length"];
    }
    
    self.bannerConstent.constant = [BICDeviceManager getRandomNumber:20 to:120];
    
}

-(void)setupUI:(HorLineType)type
{
    
    if (type==HorLineType_red) {
        self.bannerView.backgroundColor = kBICGetHomeCellBtnRColor;
        self.rightLab.textColor = kBICGetHomeCellBtnRColor;
    }

    if (type==HorLineType_Green) {
        self.bannerView.backgroundColor = kBICGetHomeCellBtnGColor;
        self.rightLab.textColor = kBICGetHomeCellBtnGColor;

    }
    
}


-(void)setupUIRever:(HorLineType)type
{
    
    if (type==HorLineType_red) {
        self.bannerView.backgroundColor = kBICGetHomeCellBtnRColor;
        self.leftLab.textColor = kBICGetHomeCellBtnRColor;
        self.rightLab.textColor=UIColorWithRGB(0x64666C);
    }

    if (type==HorLineType_Green) {
        self.bannerView.backgroundColor = kBICGetHomeCellBtnGColor;
        self.leftLab.textColor = kBICGetHomeCellBtnGColor;
        self.rightLab.textColor=UIColorWithRGB(0x64666C);
    }
    
}

-(void)setModel:(BUYSALE_ORDERS *)model
{
    _model = model;
 
    self.leftLab.text = NumFormat(model.totalLastNumStr);
    self.rightLab.text = NumFormat(model.unitPrice);
    
    self.bannerConstent.constant = (self.width) * model.percent;
    
}
-(void)setModelRever:(BUYSALE_ORDERS *)model
{
    _model = model;
    
 
    self.leftLab.text = NumFormat(model.unitPrice);
    self.rightLab.text = NumFormat(model.totalLastNumStr);
    
    self.bannerConstent.constant = (self.width) * model.percent;
    
}


@end

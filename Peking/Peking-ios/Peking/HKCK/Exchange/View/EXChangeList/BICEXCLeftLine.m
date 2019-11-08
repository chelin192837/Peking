//
//  BICEXCRightLine.m
//  Biconome
//
//  Created by 车林 on 2019/8/24.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICEXCLeftLine.h"
@interface BICEXCLeftLine()
@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (weak, nonatomic) IBOutlet UILabel *leftLab;
@property (weak, nonatomic) IBOutlet UILabel *rightLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bannerConstent;

@end

@implementation BICEXCLeftLine
-(instancetype)initWithNibWith:(HorLineType)type
{
    self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
    [self setupUI:type];
    return self;
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
//....
-(void)setModel:(BUYSALE_ORDERS *)model
{
    
    self.leftLab.text = NumFormat(model.totalLastNumStr);
    self.rightLab.text = NumFormat(model.unitPrice);
    
    self.bannerConstent.constant = (self.width) * model.percent;
    
}

@end


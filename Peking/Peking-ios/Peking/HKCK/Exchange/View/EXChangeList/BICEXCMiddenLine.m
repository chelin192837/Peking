//
//  BICEXCRightLine.m
//  Biconome
//
//  Created by 车林 on 2019/8/24.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICEXCMiddenLine.h"

@interface BICEXCMiddenLine()

@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (weak, nonatomic) IBOutlet UILabel *leftLab;
@property (weak, nonatomic) IBOutlet UILabel *rightLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bannerConstent;
@property (weak, nonatomic) IBOutlet UILabel *middenLab;

@end

@implementation BICEXCMiddenLine
-(instancetype)initWithNibWith:(HorLineType)type
{
    self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
    [self setupUI:type];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUI:) name:NSNotificationCenterEXCBannerConstent object:nil];
    return self;
}

-(void)updateUI:(NSNotification*)noti
{
    NSDictionary * dic = noti.object;
    NSString *length = @"80";
    if (dic) {
        length = dic[@"length"];
    }
    
    self.bannerConstent.constant = [BICDeviceManager getRandomNumber:20 to:240];
    
}

-(void)setupUI:(HorLineType)type
{
    
//    if (type==HorLineType_red) {
//        self.bannerView.backgroundColor = kBICGetHomeCellBtnRColor;
//        self.rightLab.textColor = kBICGetHomeCellBtnRColor;
//    }
//
//    if (type==HorLineType_Green) {
//        self.bannerView.backgroundColor = kBICGetHomeCellBtnGColor;
//        self.rightLab.textColor = kBICGetHomeCellBtnGColor;
//
//    }
    
}

-(void)setModel:(GetHistoryListResponse *)model
{
    self.leftLab.text = NumFormat(model.tradingNum);
    NSString *localTime=@"";
    if(model.createTime){
        localTime=[UtilsManager getLocalDateFormateUTCDate:model.createTime];
    }
    NSArray * arr =[localTime componentsSeparatedByString:@" "];
    if (arr.count>1) {
        self.rightLab.text = arr[1];
//
    }else{
        self.rightLab.text = @"";
    }
    
    self.middenLab.text = NumFormat(model.makerPrice);
    
    if ([model.tradingType isEqualToString:@"BUY"]) {
        self.bannerView.backgroundColor = kBICGetHomeCellBtnGColor;
        self.rightLab.textColor =kBICGetHomeCellBtnGColor;
    }
    if ([model.tradingType isEqualToString:@"SELL"]) {
        self.bannerView.backgroundColor = kBICGetHomeCellBtnRColor;
        self.rightLab.textColor = kBICGetHomeCellBtnRColor;

    }
    
//    self.bannerConstent.constant = (self.width) * [model.percent floatValue];
    
}


@end



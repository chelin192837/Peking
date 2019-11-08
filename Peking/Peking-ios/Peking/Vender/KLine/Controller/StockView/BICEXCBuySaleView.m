//
//  BICEXCBuySaleView.m
//  Biconome
//
//  Created by 车林 on 2019/8/26.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICEXCBuySaleView.h"
#import "UIView+Extension.h"
#import "BICEXCHorLine.h"
@interface BICEXCBuySaleView()

@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UIView *middenView;

@property(nonatomic,strong)BICEXCHorLine * horLineTop;

@property(nonatomic,strong)BICEXCHorLine * horLineTopLeft;


@property (weak, nonatomic) IBOutlet UILabel *leftLab;
@property (weak, nonatomic) IBOutlet UILabel *rightLab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buyConstent;

@property (weak, nonatomic) IBOutlet UILabel *buyBlockLab;
@property (weak, nonatomic) IBOutlet UILabel *sellBlockLab;

@end

@implementation BICEXCBuySaleView

-(instancetype)initWithNib
{
    self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
  
    self.layer.cornerRadius = 8.f;
//    self.layer.masksToBounds = YES;
    [self isYY];
    
    [self.rightView addRoundedCorners:UIRectCornerTopRight|UIRectCornerBottomRight withRadii:CGSizeMake(4, 4)];
    
    self.buyBlockLab.text = LAN(@"买盘");
    self.sellBlockLab.text = LAN(@"卖盘");
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(topicSubscription:) name:NSNotificationCenteSockJSTopicSubscription object:nil];
    
    [self setupUI];
    return self;
}

-(void)setupUI
{
    CGFloat width = (SCREEN_WIDTH-4*kBICMargin-16)/2;
    BICEXCHorLine * horLineTop = [[BICEXCHorLine alloc] initWithFrame:CGRectMake(0,0, width,5*28) With:HorLineType_Green];
    self.horLineTop=horLineTop;
    [self.middenView addSubview:horLineTop];
    
    BICEXCHorLine * horLineTopLeft = [[BICEXCHorLine alloc] initWithLeftFrame:CGRectMake(width+kBICMargin,0, width,5*28) With:HorLineType_red];
    self.horLineTopLeft=horLineTopLeft;
    [self.middenView addSubview:horLineTopLeft];
}

-(void)setResponseM:(BICCoinAndUnitResponse *)responseM
{
    _responseM = responseM;
    
    [self setUI:responseM];
  
}
-(void)topicSubscription:(NSNotification*)noti
{
    BICCoinAndUnitResponse *responseM = noti.object;
    [self setUI:responseM];
}
-(void)setUI:(BICCoinAndUnitResponse *)responseM
{
//    NSMutableArray * sellArr = [[NSMutableArray alloc] init];
//    if (responseM.data.SELL_ORDERS.count>0) {
//        for (int i=0; i<responseM.data.SELL_ORDERS.count; i++) {
//            [sellArr addObject:responseM.data.SELL_ORDERS[responseM.data.SELL_ORDERS.count-i-1]];
//        }
//    }
//    NSMutableArray * buyArr = responseM.data.BUY_ORDERS.copy;
//    NSMutableArray * sellArr = responseM.data.SELL_ORDERS.copy;
//    [self quickSortArrayBuySell:buyArr withLeftIndex:0 andRightIndex:buyArr.count-1];
//    [self quickSortArrayBuySell:sellArr withLeftIndex:0 andRightIndex:sellArr.count-1];
    //左侧 买
    self.horLineTop.isRever=YES;
    self.horLineTop.arr = responseM.data.BUY_ORDERS;
    //右侧 卖
    self.horLineTopLeft.arrLeft = responseM.data.SELL_ORDERS;
    
    //总买的数目
    float buyNum = 0.f;
    for (BUYSALE_ORDERS* buy in responseM.data.BUY_ORDERS) {
        buyNum+=buy.totalLastNumStr.floatValue;
    }
    //总卖的数目
    float sellNum = 0.f;
    for (BUYSALE_ORDERS* sell in responseM.data.SELL_ORDERS) {
        sellNum+=sell.totalLastNumStr.floatValue;
    }
    
    if (buyNum + sellNum > 0) {
        
        // 总买的百分比
        float buyPercent =buyNum / (buyNum + sellNum);
        //总卖的百分比
        float sellPercent = 1 - buyPercent;
        
        self.leftLab.text = [NSString stringWithFormat:@"%.2f%%",buyPercent*100];
        
        self.rightLab.text = [NSString stringWithFormat:@"%.2f%%",sellPercent*100];
        
        self.buyConstent.constant = buyPercent * (SCREEN_WIDTH-4*kBICMargin) ;
        
        [self layoutIfNeeded];
        
        //        self.leftView.backgroundColor = kBICGetHomeCellBtnGColor;
        
//        NSLog(@"buyPercent----%f",buyPercent * (SCREEN_WIDTH-4*kBICMargin));
        
        [self.leftView addRoundedCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft withRadii:CGSizeMake(4, 4)];
    }
}

-(void)quickSortArrayBuySell:(NSMutableArray *)array withLeftIndex:(NSInteger)leftIndex andRightIndex:(NSInteger)rightIndex
{
    if (leftIndex >= rightIndex) {//如果数组长度为0或1时返回
        return ;
    }
    
    NSInteger i = leftIndex;
    NSInteger j = rightIndex;
    //记录比较基准数
    BUYSALE_ORDERS *iv=array[i];
    double key = [iv.unitPrice doubleValue];
    
    while (i < j) {
        /**** 首先从右边j开始查找比基准数小的值 ***/
        BUYSALE_ORDERS *jv=array[j];
        while (i < j && [jv.unitPrice doubleValue] >= key) {//如果比基准数大，继续查找
            j--;
        }
        //如果比基准数小，则将查找到的小值调换到i的位置
        array[i] = array[j];
        
        /**** 当在右边查找到一个比基准数小的值时，就从i开始往后找比基准数大的值 ***/
        BUYSALE_ORDERS *iiv=array[i];
        while (i < j && [iiv.unitPrice doubleValue] <= key) {//如果比基准数小，继续查找
            i++;
        }
        //如果比基准数大，则将查找到的大值调换到j的位置
        array[j] = array[i];
        
    }
    
    //将基准数放到正确位置
    array[i] = iv;
    
    /**** 递归排序 ***/
    //排序基准数左边的
    [self quickSortArrayBuySell:array withLeftIndex:leftIndex andRightIndex:i - 1];
    //排序基准数右边的
    [self quickSortArrayBuySell:array withLeftIndex:i + 1 andRightIndex:rightIndex];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

//
//  BICEXCBomSaleBuyView.m
//  Biconome
//
//  Created by 车林 on 2019/8/26.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICEXCBomSaleBuyView.h"
#import "AppDelegate.h"
#import "UIView+shadowPath.h"
@interface BICEXCBomSaleBuyView()
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;

@property (weak, nonatomic) IBOutlet UIButton *sellBtn;


@end
@implementation BICEXCBomSaleBuyView
- (IBAction)buyClick:(id)sender {

    [self ScrollToViewObject:@(0)];

//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self ScrollToViewObject:@(0)];
//    });
//

   
    [self postToExchange];

}
- (IBAction)sellClick:(id)sender {
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self ScrollToViewObject:@(1)];
//    });
//
//    BaseTabBarController *nmTabBarVC =  ((AppDelegate*)[UIApplication sharedApplication].delegate).mainController;
//    [nmTabBarVC setSelectedIndex:2];
    
    [self postToExchange];

}

-(void)postToExchange
{
    NSArray * arr = [self.model.currencyPair componentsSeparatedByString:@"-"];
    SDUserDefaultsSET(arr, BICEXCChangeCoinPair);
    kPOSTNSNotificationCenter(NSNotificationCenterCoinTransactionPair, self.model);
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenterSelectToExchangeIndex object:nil];

}
-(void)ScrollToViewObject:(NSNumber*)num
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenterScrollToView object:num];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.yq_viewController.navigationController popToRootViewControllerAnimated:NO];

        BaseTabBarController *nmTabBarVC =  ((AppDelegate*)[UIApplication sharedApplication].delegate).mainController;
        [nmTabBarVC setSelectedIndex:2];
        
    });
}
-(void)setModel:(getTopListResponse *)model
{
    _model = model;
    
}
-(instancetype)initWithNib
{
    self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
    [self.sellBtn setTitle:LAN(@"卖出") forState:UIControlStateNormal];
    [self.buyBtn setTitle:LAN(@"买入") forState:UIControlStateNormal];

    [self.buyBtn viewShadowPathWithColor:[UIColor blackColor] shadowOpacity:0.25 shadowRadius:8 shadowPathType:LeShadowPathCommon shadowPathWidth:10];
    
    [self.sellBtn viewShadowPathWithColor:[UIColor blackColor] shadowOpacity:0.25 shadowRadius:8 shadowPathType:LeShadowPathCommon shadowPathWidth:10];

//    [self.sellBtn isYY];
    return self;
}


@end

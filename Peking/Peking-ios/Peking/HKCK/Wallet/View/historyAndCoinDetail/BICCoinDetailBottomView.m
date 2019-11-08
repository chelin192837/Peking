//
//  BICCoinDetailBottomView.m
//  Biconome
//
//  Created by 车林 on 2019/9/3.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICCoinDetailBottomView.h"
#import "UIView+shadowPath.h"
#import "BICWalletRechargeVC.h"
@interface BICCoinDetailBottomView()

@property(nonatomic,copy)RechargeBlock rechargeBlock;

@property(nonatomic,copy)DrawBlock drawBlock;
@property (weak, nonatomic) IBOutlet UIButton *rechargeBtn;
@property (weak, nonatomic) IBOutlet UIButton *drawBtn;

@end
@implementation BICCoinDetailBottomView

-(instancetype)initWithNibRecharge:(RechargeBlock)recharge DrawBlock:(DrawBlock)drawBlock
{
    self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
    self.frame=CGRectMake(0, 0, SCREEN_WIDTH, TabbarSafeBottomMargin+64.f);
    self.rechargeBlock = recharge;
    self.drawBlock  = drawBlock;
    [self.rechargeBtn setTitle:LAN(@"充值") forState:UIControlStateNormal];
    [self.drawBtn setTitle:LAN(@"提币") forState:UIControlStateNormal];

    [self.rechargeBtn viewShadowPathWithColor:[UIColor blackColor] shadowOpacity:0.5 shadowRadius:8 shadowPathType:LeShadowPathCommon shadowPathWidth:10];
       
    [self.drawBtn viewShadowPathWithColor:[UIColor blackColor] shadowOpacity:0.5 shadowRadius:8 shadowPathType:LeShadowPathCommon shadowPathWidth:10];

    return self;
}

- (IBAction)rechargeBtn:(id)sender {
    if (self.rechargeBlock) {
        self.rechargeBlock();
    }
//    BICWalletRechargeVC * rechargeVC = [[BICWalletRechargeVC alloc] init];
//    rechargeVC.response = self.response;
//    [[UtilsManager getCurrentVC].navigationController pushViewController:rechargeVC animated:YES];
    
}
- (IBAction)drawBtn:(id)sender {
    if (self.drawBlock) {
        self.drawBlock();
    }
    
}

@end

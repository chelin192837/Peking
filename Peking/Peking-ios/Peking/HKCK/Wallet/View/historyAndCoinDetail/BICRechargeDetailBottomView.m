//
//  BICCoinDetailBottomView.m
//  Biconome
//
//  Created by 车林 on 2019/9/3.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICRechargeDetailBottomView.h"
@interface BICRechargeDetailBottomView()

@property(nonatomic,copy)RechargeBlock rechargeBlock;

@property(nonatomic,copy)DrawBlock drawBlock;

@property (weak, nonatomic) IBOutlet UIButton *kcopyBtn;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;

@end

@implementation BICRechargeDetailBottomView

-(instancetype)initWithNibRecharge:(RechargeBlock)recharge DrawBlock:(DrawBlock)drawBlock
{
    self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
    self.rechargeBlock = recharge;
    self.drawBlock  = drawBlock;
    self.kcopyBtn.layer.borderWidth = 1.f;
    self.kcopyBtn.layer.borderColor = hexColor(6653FF).CGColor;
    [self.kcopyBtn setTitle:LAN(@"复制Txid") forState:UIControlStateNormal];
    [self.checkBtn setTitle:LAN(@"检查Txid") forState:UIControlStateNormal];

    return self;
}

- (IBAction)rechargeBtn:(id)sender {
    if (self.rechargeBlock) {
        self.rechargeBlock();
    }
    
}
- (IBAction)drawBtn:(id)sender {
    if (self.drawBlock) {
        self.drawBlock();
    }
    
}

@end

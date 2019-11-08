//
//  SDRuleView.m
//  Agent
//
//  Created by 七扇门 on 16/9/10.
//  Copyright © 2016年 七扇门. All rights reserved.
//

#import "SDRuleView.h"
//#import "DECSwitchStatusViewController.h"

@implementation SDRuleView

+ (instancetype)publishView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)tipToSwitchStatus{
    
    //经纪人认证 装修未认证
    NSString *contentStr = @"由于您的手机号已经认证为经纪人,如需使用装修版功能请更换手机号重新认证为装修顾问！";
    //装修认证 经纪人未认证
    if ((STATUS1 && DEC_STATUS2) || (STATUS1 && DEC_STATUS3)) {
        contentStr = @"由于您的手机号已经认证为装修顾问,如需使用地产版功能请更换手机号重新认证为经纪人！";
    }
    
//    SDRuleView *switchView = [[[NSBundle mainBundle] loadNibNamed:@"SDRuleView" owner:nil options:nil] lastObject];
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    self.frame = [UIApplication sharedApplication].keyWindow.frame;
    self.titleLabel.text = @"身份提示";
    self.contentLabel.text = contentStr;
    self.ruleButton.hidden = YES;
    [self.knowButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.knowButton addTarget:self action:@selector(cancleAction) forControlEvents:UIControlEventTouchUpInside];
    [self.continueButton setTitle:@"切换" forState:UIControlStateNormal];
    [self.continueButton addTarget:self action:@selector(switchStatusAction) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)cancleAction{
    [self removeFromSuperview];
}
- (void)switchStatusAction{
    [self removeFromSuperview];
    
    if (self.removeRightBtnClickBlock) {
        self.removeRightBtnClickBlock();
    }
//    DECSwitchStatusViewController * switchVC = [[DECSwitchStatusViewController alloc] init];
//    [[UtilsManager getCurrentVC].navigationController pushViewController:switchVC animated:YES];
}
@end

//
//  SDRuleView.h
//  Agent
//
//  Created by 七扇门 on 16/9/10.
//  Copyright © 2016年 七扇门. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ViewRightBtnBlock)(void);

@interface SDRuleView : UIView

+ (instancetype)publishView;

- (void)tipToSwitchStatus;


@property (weak, nonatomic) IBOutlet UIButton *ruleButton;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;
@property (weak, nonatomic) IBOutlet UIButton *knowButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

///
@property (nonatomic,copy) ViewRightBtnBlock removeRightBtnClickBlock;//请勿在此block内写跳转

@end

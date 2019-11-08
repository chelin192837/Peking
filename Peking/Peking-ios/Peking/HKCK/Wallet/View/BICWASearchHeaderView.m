//
//  BICSearchHeaderView.m
//  Biconome
//
//  Created by 车林 on 2019/8/16.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICWASearchHeaderView.h"
@interface BICWASearchHeaderView()

@property (weak, nonatomic) IBOutlet UIView *searchView;

@property(nonatomic,strong) SearchBlock searchBlock;
@property(nonatomic,strong) RightBlock rightBlock;
@property (weak, nonatomic) IBOutlet UIButton *historyButton;

@end

@implementation BICWASearchHeaderView

-(instancetype)initWithNib:(SearchBlock)searchBlock RightBlock:(RightBlock)rightBlock
{
    self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
    self.searchBlock = searchBlock;
    self.rightBlock = rightBlock;
    self.frame=CGRectMake(0, 0, SCREEN_WIDTH, kNavBar_Height);
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap:)];
    [self.searchView addGestureRecognizer:tap];
    self.searchLab.text = LAN(@"搜索");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUI) name:NSNotificationCenterUpdateUI object:nil];
    [self.historyButton setBackgroundColor:UIColorWithRGB(0xF3F5FB)];
    self.historyButton.layer.cornerRadius = 8;
    self.historyButton.layer.masksToBounds=YES;

    return self;
}
-(void)updateUI
{
    self.searchLab.text = LAN(@"搜索");
    
}
- (IBAction)rightBtn:(id)sender {
    if (self.rightBlock) {
        self.rightBlock();
    }
}

-(void)viewTap:(UITapGestureRecognizer*)tap
{
    if (self.searchBlock) {
        self.searchBlock();
    }
}



@end

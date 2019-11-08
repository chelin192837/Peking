//
//  BICTopSelectHead.m
//  Biconome
//
//  Created by 车林 on 2019/8/23.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICTopSelectHead.h"
#import "UIView+Extension.h"

@interface BICTopSelectHead()

@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UIButton *saleBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstent;

@end

@implementation BICTopSelectHead

+(instancetype)initWithNib
{
    return [[NSBundle mainBundle] loadNibNamed:@"BICTopSelectHead" owner:nil options:nil][0];
}

-(instancetype)initWithNibBuyBlock:(BuyBlock)buyBlock SaleBlock:(SaleBlock)saleBlock
{
    self = [[NSBundle mainBundle] loadNibNamed:@"BICTopSelectHead" owner:nil options:nil][0];
    [self setupUI];
    self.buyBlock =buyBlock;
    self.saleBlock=saleBlock;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollToNav:) name:NSNotificationCenterExchangeScrollerToNav object:nil];

    return self;
}
-(void)setupUI
{

    [self.buyBtn setBackgroundImage:[UIImage imageNamed:@"segmented_left_highlight"] forState:UIControlStateNormal];
    [self.buyBtn setTitleColor:kBICMainBGColor forState:UIControlStateNormal];
    
    [self.saleBtn setBackgroundImage:[UIImage imageNamed:@"segmented_right"] forState:UIControlStateNormal];
    
    [self.saleBtn setTitleColor:kBICSaleBorderColor forState:UIControlStateNormal];
    
    [self.buyBtn setTitle:LAN(@"买入") forState:UIControlStateNormal];
    [self.saleBtn setTitle:LAN(@"卖出") forState:UIControlStateNormal];
    
//    [self.buyBtn isYY];
//    [self.saleBtn isYY];

}
-(void)scrollToNav:(NSNotification*)notify
{
    NSNumber * off_Y = notify.object;
    CGFloat offY = [off_Y floatValue];
    
    if ( offY > 44+20) {
        
        self.buyBtn.y = 14.f;
        self.saleBtn.y = 14.f;
    }

    
    
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
}
-(void)changeTo:(NSInteger)index
{
    if (index==0) {
        [self setBuyButton];

    }
    if (index==1) {
        [self setSaleButton];

    }
}
- (IBAction)buyClick:(id)sender {
    [self setBuyButton];
    if (self.buyBlock) {
        self.buyBlock();
    }
}
- (IBAction)saleClick:(id)sender {
    [self setSaleButton];
    if (self.saleBlock) {
        self.saleBlock();
    }
}
-(void)setBuyButton
{
    [self.buyBtn setBackgroundImage:[UIImage imageNamed:@"segmented_left_highlight"] forState:UIControlStateNormal];
    [self.buyBtn setTitleColor:kBICMainBGColor forState:UIControlStateNormal];
    
    [self.saleBtn setBackgroundImage:[UIImage imageNamed:@"segmented_right"] forState:UIControlStateNormal];

    [self.saleBtn setTitleColor:kBICSaleBorderColor forState:UIControlStateNormal];
    
}
-(void)setSaleButton
{
  
    [self.buyBtn setBackgroundImage:[UIImage imageNamed:@"segmented_left"] forState:UIControlStateNormal];
    [self.buyBtn setTitleColor:kBICSaleBorderColor forState:UIControlStateNormal];
    
   [self.saleBtn setBackgroundImage:[UIImage imageNamed:@"segmented_right_highlight"] forState:UIControlStateNormal];
    [self.saleBtn setTitleColor:kBICMainBGColor forState:UIControlStateNormal];
    
}
@end

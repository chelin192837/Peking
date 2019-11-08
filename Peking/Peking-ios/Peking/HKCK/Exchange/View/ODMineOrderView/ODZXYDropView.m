//
//  ODZXYDropView.m
//  OneDoor
//
//  Created by 车林 on 2019/6/12.
//  Copyright © 2019年 Yujing. All rights reserved.
//

#import "ODZXYDropView.h"

@interface ODZXYDropView()

@property (nonatomic,strong)NSArray * valueArray;

@property (nonatomic,strong)UIView * superView;

@property (nonatomic,strong)UIView * mainView;

@property (nonatomic,copy)BtnBlock btnBlock;

@end

static id share = nil;

@implementation ODZXYDropView

+(instancetype)shareInstacne
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[ODZXYDropView alloc] init];
    });
    
    return share;
}

-(void)setValueArray:(NSArray*)array
                   SuperView:(UIView*)superView
                      Button:(UIButton*)button
                   BtnBlock:(BtnBlock)btnBlock
{
        self.valueArray = array;
        
        self.superView = superView;
    
        self.btnBlock = btnBlock;
        
        [self setupUI:button];
}

-(void)setupUI:(UIButton*)btn
{
    
    UIView*mainBgView = [[UIView alloc] init];
    self.mainView = mainBgView;
    mainBgView.backgroundColor = [UIColor colorWithWhite:.5f alpha:0.3f];
    UITapGestureRecognizer*tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgTap:)];
    [mainBgView addGestureRecognizer:tap];
    [[UIApplication sharedApplication].keyWindow addSubview:mainBgView];
    [mainBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo([UIApplication sharedApplication].keyWindow);
    }];
    
    UIView*rightBgView = [[UIView alloc] init];
    rightBgView.layer.cornerRadius = 8.f;
    rightBgView.layer.masksToBounds = YES;
    rightBgView.backgroundColor = kBICWhiteColor;
    [mainBgView addSubview:rightBgView];
    [rightBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@127);
        make.height.equalTo(@108);
        make.right.equalTo(mainBgView).offset(-16);
        make.top.equalTo(mainBgView).offset(kNavBar_Height+12);
    }];
    
    UIImageView *rightImage = [[UIImageView alloc] init];
    rightImage.image = [UIImage imageNamed:@"triangle"];
    [mainBgView addSubview:rightImage];
    [rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(mainBgView).offset(-kBICMargin-5);
        make.width.equalTo(@8);
        make.height.equalTo(@4);
        make.top.equalTo(rightBgView).offset(-4);
    }];
    
    for(UIView *btnV in [mainBgView subviews])
    {
        if ([btnV isKindOfClass:[UIButton class]]) {
            [btnV removeFromSuperview];
        }
    }
    for (int i=0; i<self.valueArray.count; i++) {
        UIButton*v = [[UIButton alloc] init];
        v.backgroundColor = [UIColor whiteColor];
            [v setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [v addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
        [v setTitle:self.valueArray[i] forState:UIControlStateNormal];
        v.titleLabel.font = [UIFont systemFontOfSize:16.f];
        v.titleLabel.textColor = kBICGetHomeAmountColor;
        v.tag = 100+i;
        if (i==0) {
            [v setImage:[UIImage imageNamed:@"cny2"] forState:UIControlStateNormal];
        }else{
            [v setImage:[UIImage imageNamed:@"usd2"] forState:UIControlStateNormal];
        }
        [mainBgView addSubview:v];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@100);
            make.height.equalTo(@40);
            make.centerX.equalTo(rightBgView);
            make.top.equalTo(rightBgView).offset(13+i*40);
        }];
    
    }
    
}

-(void)bgTap:(UITapGestureRecognizer*)tap
{
    [[tap view] removeFromSuperview];
}
-(void)btnTap:(UIButton*)sender
{
    if (self.btnBlock) {
        self.btnBlock(sender);
    }
    [self.mainView removeFromSuperview];
}
@end

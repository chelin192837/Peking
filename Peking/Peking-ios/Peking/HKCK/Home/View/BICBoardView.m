//
//  BICBoardView.m
//  Biconome
//
//  Created by 车林 on 2019/8/19.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICBoardView.h"
#import "XHVerticalScrollview.h"
#import "RSDHomeListWebVC.h"
@implementation BICBoardView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = frame.size.height/2;
//        self.layer.masksToBounds = YES;
        [self isYY];
    }
    return self;
}

-(void)setupUI:(NSArray*)titleArray{
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIImageView* titleImage = [[UIImageView alloc] init];
    titleImage.image = IMAGE(@"notice");
    [self addSubview:titleImage];
    [titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@28);
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(10);
    }];
    
    XHVerticalScrollview *scroller = [[XHVerticalScrollview alloc] initWithDelegate:self DataArray:titleArray BgColor:kBICWhiteColor Frame:CGRectMake(48,0,KScreenWidth-32-40-28-16, 48)];
    [self addSubview:scroller];
    
    UIButton *arrowBtn = [[UIButton alloc] init];
    arrowBtn.userInteractionEnabled = NO;
    [arrowBtn setBackgroundImage:[UIImage imageNamed:@"notice_more"] forState:UIControlStateNormal];
    [self addSubview:arrowBtn];
    [arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(scroller);
        make.height.equalTo(@16);
        make.width.equalTo(@16);
    }];
    
    [self layoutIfNeeded];
}
@end

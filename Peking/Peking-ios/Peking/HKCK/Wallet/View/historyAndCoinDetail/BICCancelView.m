//
//  BICUpdateView.m
//  Biconome
//
//  Created by a on 2019/10/10.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "BICCancelView.h"
@interface BICCancelView ()
@property (strong, nonatomic)  UIView *bgView;
@property (strong, nonatomic)  UIView *topView;
@property (strong, nonatomic)  UILabel *titleLabel;
@property (strong, nonatomic)  UILabel *contentLabel;
@property (strong, nonatomic)  UIButton *cancelButton;
@property (strong, nonatomic)  UIButton *confirmButton;
@end
@implementation BICCancelView

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title content:(NSString *)content left:(NSString *)left right:(NSString *)right{
    if(self==[super initWithFrame:frame]){
        self.backgroundColor=[UIColor clearColor];
        [self setUpUI];
        self.titleLabel.text=title;
        self.contentLabel.text=content;
        [self.cancelButton setTitle:left forState:UIControlStateNormal];
        [self.confirmButton setTitle:right forState:UIControlStateNormal];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self==[super initWithFrame:frame]){
        self.backgroundColor=[UIColor clearColor];
        [self setUpUI];
    }
    return self;
}
-(void)setUpUI{
    [self addSubview:self.bgView];
    [self addSubview:self.topView];
    [self.topView addSubview:self.titleLabel];
    [self.topView addSubview:self.contentLabel];
    [self.topView addSubview:self.cancelButton];
    [self.topView addSubview:self.confirmButton];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.bgView.frame=CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    self.topView.frame=CGRectMake((KScreenWidth-280)/2, (KScreenHeight-173)/2, 280, 173);
    self.titleLabel.frame=CGRectMake(0, 20, CGRectGetWidth(self.topView.frame), 23);
    self.contentLabel.frame=CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), CGRectGetWidth(self.topView.frame), 70);
    self.cancelButton.frame=CGRectMake(24, CGRectGetMaxY(self.contentLabel.frame),108, 44);
    self.confirmButton.frame=CGRectMake(CGRectGetMaxX(self.cancelButton.frame)+16, CGRectGetMaxY(self.contentLabel.frame), 108, 44);
}

-(UIView *)bgView{
    if(!_bgView){
        _bgView=[[UIView alloc] init];
        _bgView.backgroundColor=UIColorWithRGB(0x0D1634);
        _bgView.alpha=0.4;
    }
    return _bgView;
}
-(UIView *)topView{
    if(!_topView){
        _topView=[[UIView alloc] init];
        _topView.backgroundColor=[UIColor whiteColor];
        _topView.layer.cornerRadius = 8;
        _topView.layer.masksToBounds=YES;
    }
    return _topView;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel=[[UILabel alloc] init];
        _titleLabel.font=[UIFont boldSystemFontOfSize:16];
        _titleLabel.textColor=UIColorWithRGB(0x444444);
        _titleLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _titleLabel;
}
-(UILabel *)contentLabel{
    if(!_contentLabel){
        _contentLabel=[[UILabel alloc] init];
        _contentLabel.font=[UIFont systemFontOfSize:14];
        _contentLabel.textColor=UIColorWithRGB(0x666666);
        _contentLabel.numberOfLines=0;
        _contentLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _contentLabel;
}
-(UIButton *)confirmButton{
    if(!_confirmButton){
        _confirmButton=[[UIButton alloc] init];
        [_confirmButton setBackgroundColor:UIColorWithRGB(0x6653FF)];
        _confirmButton.layer.cornerRadius = 8;
        _confirmButton.layer.masksToBounds=YES;
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmButton.titleLabel.font=[UIFont systemFontOfSize:16];
        [_confirmButton addTarget:self action:@selector(requestToUpdate) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}


-(void)requestToClose{
    [self removeFromSuperview];
}


-(UIButton *)cancelButton{
    if(!_cancelButton){
        _cancelButton=[[UIButton alloc] init];
        [_cancelButton setBackgroundColor:[UIColor whiteColor]];
        _cancelButton.layer.cornerRadius = 8;
        _cancelButton.layer.masksToBounds=YES;
        _cancelButton.layer.borderWidth=1;
        _cancelButton.layer.borderColor=UIColorWithRGB(0x6653FF).CGColor;
        [_cancelButton setTitleColor:UIColorWithRGB(0x6653FF) forState:UIControlStateNormal];
        _cancelButton.titleLabel.font=[UIFont systemFontOfSize:16];
        [_cancelButton addTarget:self action:@selector(requestToClose) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

-(void)requestToUpdate{
     [self removeFromSuperview];
    if(self.clickRightItemOperationBlock){
        self.clickRightItemOperationBlock();
    }
}

 
@end

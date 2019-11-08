//
//  BICVerificationHeaderView.m
//  Biconome
//
//  Created by a on 2019/10/5.
//  Copyright © 2019 qsm. All rights reserved.
// KScreenWidth-61

#import "BICVerificationHeaderView.h"

@implementation BICVerificationHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self==[super initWithFrame:frame]){
        [self setUpUI];
    }
    return self;
}
-(void)setUpUI{
    [self addSubview:self.imgView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.contentLabel];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.imgView.frame=CGRectMake((KScreenWidth-160)/2, 64, 160, 160);
    self.titleLabel.frame=CGRectMake(0, CGRectGetMaxY(self.imgView.frame), KScreenWidth, 23);
    self.contentLabel.frame=CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame)+8, KScreenWidth, 60);
}

-(UIImageView *)imgView{
    if(!_imgView){
        _imgView=[[UIImageView alloc] init];
    }
    return _imgView;
}
-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel=[[UILabel alloc] init];
        _titleLabel.font=[UIFont systemFontOfSize:16];
        _titleLabel.textColor=UIColorWithRGB(0x64666C);
        _titleLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _titleLabel;
}
-(UILabel *)contentLabel{
    if(!_contentLabel){
        _contentLabel=[[UILabel alloc] init];
        _contentLabel.font=[UIFont systemFontOfSize:14];
        _contentLabel.textColor=UIColorWithRGB(0x95979D);
        _contentLabel.numberOfLines=0;
        _contentLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _contentLabel;
}
@end

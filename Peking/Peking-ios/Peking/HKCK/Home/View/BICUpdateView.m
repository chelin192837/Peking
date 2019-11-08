//
//  BICUpdateView.m
//  Biconome
//
//  Created by a on 2019/10/10.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "BICUpdateView.h"
@interface BICUpdateView ()
@property (strong, nonatomic)  UIView *bgView;
@property (strong, nonatomic)  UIView *topView;
@property (strong, nonatomic)  UIView *bottomView;
@property (strong, nonatomic)  UILabel *titleLabel;
@property (strong, nonatomic)  UILabel *contentLabel;
@property (strong, nonatomic)  UIButton *updateButton;
@property (strong, nonatomic)  UIButton *closeButton;
@property (strong, nonatomic)  UIImageView *imgView;
@end
@implementation BICUpdateView

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
    [self addSubview:self.bottomView];
    [self.bottomView addSubview:self.titleLabel];
    [self.bottomView addSubview:self.contentLabel];
    [self.bottomView addSubview:self.updateButton];
    [self addSubview:self.closeButton];
    [self addSubview:self.imgView];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.bgView.frame=CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    self.topView.frame=CGRectMake((KScreenWidth-280)/2, (KScreenHeight-377)/2, 280, 100);
    [_topView addRoundedCorners:UIRectCornerTopLeft | UIRectCornerTopRight withRadii:CGSizeMake(8, 8)];
    self.bottomView.frame=CGRectMake(CGRectGetMinX(self.topView.frame), CGRectGetMaxY(self.topView.frame), 280, 277);
    [_bottomView addRoundedCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight withRadii:CGSizeMake(8, 8)];
    self.titleLabel.frame=CGRectMake(0, 12, CGRectGetWidth(self.bottomView.frame), 23);
    self.contentLabel.frame=CGRectMake(24, CGRectGetMaxY(self.titleLabel.frame)+12, 232, 126);
    self.updateButton.frame=CGRectMake(24, CGRectGetMaxY(self.contentLabel.frame)+24, 232, 44);
    self.closeButton.frame=CGRectMake((KScreenWidth-40)/2, CGRectGetMaxY(self.bottomView.frame)+15, 40, 40);
    self.imgView.frame=CGRectMake((KScreenWidth-280)/2, CGRectGetMinY(self.topView.frame)-58, 280, 158);
}

-(void)setResponse:(BICAppStoreResponse *)response{
    _response=response;
    if([response.data.compel intValue]){
        self.closeButton.hidden=YES;
    }else{
        self.closeButton.hidden=NO;
    }
    NSString *temp= [response.data.remark stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
       [paragraphStyle setLineSpacing:2];
       NSDictionary *attributes = @{NSFontAttributeName:_contentLabel.font,NSForegroundColorAttributeName:UIColorWithRGB(0x666666),NSParagraphStyleAttributeName:paragraphStyle};
    NSMutableAttributedString *str=[[NSMutableAttributedString alloc] initWithString:temp attributes:attributes];

    _contentLabel.attributedText=str;
}
-(NSString *)createString:(NSString *)remark{
    NSArray *aArray = [remark componentsSeparatedByString:@"\n"];
    NSMutableString *temp;
    for(int i=0;i<aArray.count;i++){
        [temp appendString:[aArray objectAtIndex:i]];
        if(i<aArray.count-1){
            [temp appendString:@"\n"];
        }
    }
    return temp;
}
-(UIView *)bgView{
    if(!_bgView){
        _bgView=[[UIView alloc] init];
        _bgView.backgroundColor=UIColorWithRGB(0x0D1634);
        _bgView.alpha=0.4;
        UITapGestureRecognizer*tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgButtonClick)];
        [_bgView addGestureRecognizer:tapGesture];
    }
    return _bgView;
}
-(void)bgButtonClick{
    [self endEditing:YES];
}
-(UIView *)topView{
    if(!_topView){
        _topView=[[UIView alloc] init];
        _topView.backgroundColor=UIColorWithRGB(0x6653FF);
    }
    return _topView;
}
-(UIView *)bottomView{
    if(!_bottomView){
        _bottomView=[[UIView alloc] init];
        _bottomView.backgroundColor=[UIColor whiteColor];
        
    }
    return _bottomView;
}
-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel=[[UILabel alloc] init];
        _titleLabel.font=[UIFont systemFontOfSize:16];
        _titleLabel.textColor=UIColorWithRGB(0x444444);
        _titleLabel.textAlignment=NSTextAlignmentCenter;
        _titleLabel.text=LAN(@"版本更新");
    }
    return _titleLabel;
}
-(UILabel *)contentLabel{
    if(!_contentLabel){
        _contentLabel=[[UILabel alloc] init];
        _contentLabel.font=[UIFont systemFontOfSize:14];
        _contentLabel.textColor=UIColorWithRGB(0x666666);
        _contentLabel.numberOfLines=0;
    }
    return _contentLabel;
}
-(UIButton *)updateButton{
    if(!_updateButton){
        _updateButton=[[UIButton alloc] init];
        [_updateButton setBackgroundColor:UIColorWithRGB(0x6653FF)];
        _updateButton.layer.cornerRadius = 8;
        _updateButton.layer.masksToBounds=YES;
        [_updateButton setTitle:LAN(@"更新") forState:UIControlStateNormal];
        [_updateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _updateButton.titleLabel.font=[UIFont systemFontOfSize:16];
        [_updateButton addTarget:self action:@selector(requestToUpdate) forControlEvents:UIControlEventTouchUpInside];
    }
    return _updateButton;
}


-(void)requestToUpdate{
    if(![self.response.data.compel intValue]){
        [self removeFromSuperview];
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.response.data.appUrl] options:[NSDictionary dictionary] completionHandler:nil];
}

-(UIButton *)closeButton{
    if(!_closeButton){
        _closeButton=[[UIButton alloc] init];
        [_closeButton setImage:[UIImage imageNamed:@"version_update_close"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(requestToClose) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

-(void)requestToClose{
    [self removeFromSuperview];
}

-(UIImageView *)imgView{
    if(!_imgView){
        _imgView=[[UIImageView alloc] init];
        _imgView.image=[UIImage imageNamed:@"version_update_bitmap"];
    }
    return _imgView;
}
@end

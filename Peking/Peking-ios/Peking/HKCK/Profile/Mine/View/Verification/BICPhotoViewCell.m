//
//  BICPhotoViewCell.m
//  Biconome
//
//  Created by a on 2019/10/6.
//  Copyright © 2019 qsm. All rights reserved.
// 268

#import "BICPhotoViewCell.h"
@interface BICPhotoViewCell()

@end
@implementation BICPhotoViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *reuseIdentifier = @"BICPhotoViewCell";
    BICPhotoViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if(!cell){
        cell=[[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.backgroundColor=kBICHistoryCellBGColor;
        [self setupUI];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.bgView.frame=CGRectMake(16, 0, KScreenWidth-32, 268);
    CGFloat marge=(CGRectGetWidth(self.bgView.frame)-295)/2;
    self.titleLabel.frame=CGRectMake(marge, 20, 200, 23);
    self.bgImgView.frame=CGRectMake(marge, CGRectGetMaxY(self.titleLabel.frame)+16, 295, 185);
//    CGFloat marge=24;
//    self.titleLabel.frame=CGRectMake(marge, 20, 200, 23);
//    self.bgImgView.frame=CGRectMake(marge, CGRectGetMaxY(self.titleLabel.frame)+16, 295, 185);
    self.delImgView.frame=CGRectMake(0, 0, 20, 20);
    self.delImgView.center=CGPointMake(CGRectGetMaxX(self.bgImgView.frame), CGRectGetMinY(self.bgImgView.frame));
}
-(void)setupUI{
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.bgImgView];
    [self.bgView addSubview:self.cameraImgView];
    [self.bgView addSubview:self.delImgView];
}
-(UIView *)bgView{
    if(!_bgView){
        _bgView=[[UIView alloc] init];
        _bgView.backgroundColor=[UIColor whiteColor];
        _bgView.layer.cornerRadius = 4;
        _bgView.layer.masksToBounds=YES;
    }
    return _bgView;
}
-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel=[[UILabel alloc] init];
        _titleLabel.font=[UIFont systemFontOfSize:16];
        _titleLabel.textColor=UIColorWithRGB(0x64666C);
    }
    return _titleLabel;
}
-(UIImageView *)bgImgView{
    if(!_bgImgView){
        _bgImgView=[[UIImageView alloc] init];
        _bgImgView.layer.cornerRadius = 6;
        _bgImgView.layer.masksToBounds=YES;
    }
    return _bgImgView;
}
-(UIImageView *)cameraImgView{
    if(!_cameraImgView){
        _cameraImgView=[[UIImageView alloc] init];
    }
    return _cameraImgView;
}
-(UIImageView *)delImgView{
    if(!_delImgView){
        _delImgView=[[UIImageView alloc] init];
        _delImgView.image=[UIImage imageNamed:@"icon_subtract"];
        _delImgView.hidden=YES;
        _delImgView.userInteractionEnabled=YES;
        UITapGestureRecognizer*tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(delClick)];
        [_delImgView addGestureRecognizer:tapGesture];
    }
    return _delImgView;
}
-(void)delClick{
    if(self.delClickItemOperationBlock){
        self.delClickItemOperationBlock();
    }
}
-(void)setFrame:(CGRect)frame{
    frame.origin.y+=16;
    frame.size.height-=16;
    [super setFrame:frame];
}
@end

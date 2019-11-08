//
//  BICMineCell.m
//  Biconome
//
//  Created by 车林 on 2019/8/31.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICMineVerCell.h"

@implementation BICMineVerCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *reuseIdentifier = @"BICMineVerCell";
    BICMineVerCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if(!cell){
        cell=[[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.backgroundColor=UIColorWithRGB(0xF3F5FB);
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    [self.contentView addSubview:self.bgView];
//    [self.bgView addSubview:self.titleImg];
    [self.bgView addSubview:self.titleTexLab];
    [self.bgView addSubview:self.tipImg];
    [self.bgView addSubview:self.detailLabel];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.bgView.frame=CGRectMake(16, 0, KScreenWidth-32, 56);
//    self.titleImg.frame=CGRectMake(19, 18, 19, 20);
    self.titleTexLab.frame=CGRectMake(16, 0, 100, 56);
    self.tipImg.frame=CGRectMake(CGRectGetWidth(self.bgView.frame)-12-18, 19, 18, 18);
    self.detailLabel.frame=CGRectMake(CGRectGetMinX(self.tipImg.frame)-4-200, 0, 200, 56);
}
-(UIView *)bgView{
    if(!_bgView){
        _bgView=[[UIView alloc] init];
        _bgView.backgroundColor=[UIColor whiteColor];
        _bgView.layer.cornerRadius = 8;
        _bgView.layer.masksToBounds=YES;
    }
    return _bgView;
}
-(UIImageView *)titleImg{
    if(!_titleImg){
        _titleImg=[[UIImageView alloc] init];
    }
    return _titleImg;
}
-(UIImageView *)tipImg{
    if(!_tipImg){
        _tipImg=[[UIImageView alloc] init];
        _tipImg.image=[UIImage imageNamed:@"arrow_more"];
    }
    return _tipImg;
}
-(UILabel *)titleTexLab{
    if(!_titleTexLab){
        _titleTexLab=[[UILabel alloc] init];
        _titleTexLab.font=[UIFont systemFontOfSize:16];
        _titleTexLab.textColor=UIColorWithRGB(0x33353B);
    }
    return _titleTexLab;
}
-(UILabel *)detailLabel{
    if(!_detailLabel){
        _detailLabel=[[UILabel alloc] init];
        _detailLabel.font=[UIFont systemFontOfSize:15];
        _detailLabel.textColor=UIColorWithRGB(0xFB9300);
        _detailLabel.textAlignment=NSTextAlignmentRight;
    }
    return _detailLabel;
}

-(void)setFrame:(CGRect)frame{
    if(self.ishaveTop){
        frame.origin.y+=12;
    }
    if(self.ishaveBottom){
        frame.size.height-=12;
    }
    [super setFrame:frame];
}
@end

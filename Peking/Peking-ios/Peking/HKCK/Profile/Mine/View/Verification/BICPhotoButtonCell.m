//
//  BICPhotoViewCell.m
//  Biconome
//
//  Created by a on 2019/10/6.
//  Copyright © 2019 qsm. All rights reserved.
// 84

#import "BICPhotoButtonCell.h"
@interface BICPhotoButtonCell()

@end
@implementation BICPhotoButtonCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *reuseIdentifier = @"BICPhotoButtonCell";
    BICPhotoButtonCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
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
    self.bgView.frame=CGRectMake(16, 0, KScreenWidth-32, 84);
    CGFloat marge=(CGRectGetWidth(self.bgView.frame)-295)/2;
    self.subButton.frame=CGRectMake(marge, 20, 295, 44);
}
-(void)setupUI{
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.subButton];
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
-(UILabel *)subButton{
    if(!_subButton){
        _subButton=[[UILabel alloc] init];
        _subButton.backgroundColor=UIColorWithRGB(0x6653FF);
        _subButton.layer.cornerRadius = 4;
        _subButton.layer.masksToBounds=YES;
        _subButton.text=LAN(@"提交");
        _subButton.textColor=[UIColor whiteColor];
        _subButton.font=[UIFont systemFontOfSize:17];
        _subButton.textAlignment=NSTextAlignmentCenter;
    }
    return _subButton;
}
-(void)setFrame:(CGRect)frame{
    frame.origin.y+=16;
    frame.size.height-=16;
    [super setFrame:frame];
}
@end

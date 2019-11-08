//
//  BICLinkTypeViewCell.m
//  Biconome
//
//  Created by a on 2019/9/25.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "BICLinkTypeViewCell.h"
#import "UIImage+Color.h"
@interface BICLinkTypeViewCell()
@property(nonatomic,strong)UIView *conView;
@property(nonatomic,strong)UILabel *typeLabel;
@property(nonatomic,strong)UIButton *omniButton;
@property(nonatomic,strong)UIButton *ercButton;
@end
@implementation BICLinkTypeViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *topicCellId = @"BICLinkTypeViewCell";
    BICLinkTypeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topicCellId];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:topicCellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    [self.contentView addSubview:self.conView];
    [self.conView addSubview:self.typeLabel];
    [self.conView addSubview:self.omniButton];
    [self.conView addSubview:self.ercButton];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.conView.frame=CGRectMake(16, 0, KScreenWidth-32, 105);
    [_conView addRoundedCorners:UIRectCornerTopLeft | UIRectCornerTopRight withRadii:CGSizeMake(8, 8)];
    self.typeLabel.frame=CGRectMake(24, 24, 200, 20);
    self.omniButton.frame=CGRectMake(24, CGRectGetMaxY(self.typeLabel.frame)+10, 94, 44);
    self.ercButton.frame=CGRectMake(CGRectGetMaxX(self.omniButton.frame)+8, CGRectGetMaxY(self.typeLabel.frame)+10, 94, 44);
}
-(UIView *)conView{
    if(!_conView){
        _conView=[[UIView alloc] init];
        _conView.backgroundColor=[UIColor whiteColor];
    }
    return _conView;
}
-(UILabel *)typeLabel{
    if(!_typeLabel){
        _typeLabel=[[UILabel alloc] init];
        _typeLabel.font=[UIFont systemFontOfSize:14];
        _typeLabel.textColor=UIColorWithRGB(0x64666C);
        _typeLabel.text=LAN(@"链类型");
    }
    return _typeLabel;
}
-(UIButton *)omniButton{
    if(!_omniButton){
        _omniButton=[[UIButton alloc] init];
        [_omniButton setTitle:LAN(@"Omni") forState:UIControlStateNormal];
        [_omniButton setTitleColor:UIColorWithRGB(0x33353B) forState:UIControlStateNormal];
        [_omniButton setTitleColor:UIColorWithRGB(0x6653FF) forState:UIControlStateSelected];
        _omniButton.titleLabel.font=[UIFont systemFontOfSize:15];
        _omniButton.layer.cornerRadius = 4;
        _omniButton.layer.masksToBounds=YES;
        _omniButton.layer.borderWidth=1;
        _omniButton.layer.borderColor=UIColorWithRGB(0x6653FF).CGColor;
        [_omniButton addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
        _omniButton.selected=YES;
        _omniButton.tag=100;
        [_omniButton setBackgroundColor:UIColorWithRGB(0xF3F5FB)];
    }
    return _omniButton;
}
-(UIButton *)ercButton{
    if(!_ercButton){
        _ercButton=[[UIButton alloc] init];
        [_ercButton setTitle:LAN(@"ERC-20") forState:UIControlStateNormal];
        [_ercButton setTitleColor:UIColorWithRGB(0x33353B) forState:UIControlStateNormal];
        [_ercButton setTitleColor:UIColorWithRGB(0x6653FF) forState:UIControlStateSelected];
        _ercButton.titleLabel.font=[UIFont systemFontOfSize:15];
        _ercButton.layer.cornerRadius = 4;
        _ercButton.layer.masksToBounds=YES;
        [_ercButton addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
        _ercButton.tag=101;
        [_ercButton setBackgroundColor:UIColorWithRGB(0xF3F5FB)];
    }
    return _ercButton;
}

-(void)selectType:(UIButton *)button{
    if(button.tag==100){
        if(self.typeSelectItemOperationBlock){
            self.typeSelectItemOperationBlock(0);
        }
        _omniButton.selected=YES;
        _ercButton.selected=NO;
        _omniButton.layer.borderWidth=1;
        _omniButton.layer.borderColor=UIColorWithRGB(0x6653FF).CGColor;
        _ercButton.layer.borderWidth=0;
    }else{
        if(self.typeSelectItemOperationBlock){
            self.typeSelectItemOperationBlock(1);
        }
        _ercButton.selected=YES;
        _omniButton.selected=NO;
        _ercButton.layer.borderWidth=1;
        _ercButton.layer.borderColor=UIColorWithRGB(0x6653FF).CGColor;
        _omniButton.layer.borderWidth=0;
    }
}
@end

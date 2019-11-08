//
//  BICBoardTableViewCell.m
//  Biconome
//
//  Created by 车林 on 2019/8/10.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICBoardTableViewCell.h"
#import "XHVerticalScrollview.h"

@implementation BICBoardTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
      

    }
    return self;
}
-(void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    
    [self setupUI:titleArray];
    
}
-(void)setupUI:(NSArray*)titleArray{
    
    
    XHVerticalScrollview *scroller = [[XHVerticalScrollview alloc] initWithDelegate:self DataArray:titleArray BgColor:[UIColor grayColor] Frame:CGRectMake(0,0,KScreenWidth-14-10-44, 50)];
    [self addSubview:scroller];
    
    UIButton *arrowBtn = [[UIButton alloc] init];
    [arrowBtn setBackgroundImage:[UIImage imageNamed:@"arrow_right"] forState:UIControlStateNormal];
    [arrowBtn addTapBlock:^(UIButton *btn) {
        NSLog(@"arrowBtn");
    }];
    [self addSubview:arrowBtn];
    [arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-14);
        make.centerY.equalTo(scroller);
        make.height.equalTo(@24);
        make.width.equalTo(@14);
    }];
    
    UIView* lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHexColorString:@"cccccc"];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(scroller.mas_bottom);
        make.height.equalTo(@1);
    }];
    
    [self layoutIfNeeded];
}
+(instancetype)exitWithTableView:(UITableView*)tableView
{
    NSString* cellId = @"BICBoardTableViewCell";
    BICBoardTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

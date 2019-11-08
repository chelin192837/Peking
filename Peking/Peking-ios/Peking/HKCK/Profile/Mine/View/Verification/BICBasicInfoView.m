//
//  BICBasicInfoView.m
//  Biconome
//
//  Created by a on 2019/10/5.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "BICBasicInfoView.h"
@interface BICBasicInfoView()
@property (strong, nonatomic)  UILabel *nameLabel;
@property (strong, nonatomic)  UILabel *nameVLabel;
@property (strong, nonatomic)  UILabel *middleNameLabel;
@property (strong, nonatomic)  UILabel *middleNameVLabel;
@property (strong, nonatomic)  UILabel *firstNameLabel;
@property (strong, nonatomic)  UILabel *firstNameVLabel;
@property (strong, nonatomic)  UILabel *sexLabel;
@property (strong, nonatomic)  UILabel *sexVLabel;
@property (strong, nonatomic)  UILabel *ageLabel;
@property (strong, nonatomic)  UILabel *ageVLabel;
@property (strong, nonatomic)  UILabel *birthLabel;
@property (strong, nonatomic)  UILabel *birthVLabel;
@end
@implementation BICBasicInfoView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self==[super initWithFrame:frame]){
        [self setUpUI];
    }
    return self;
}
-(void)setUpUI{
    [self addSubview:self.nameLabel];
    [self addSubview:self.nameVLabel];
    [self addSubview:self.middleNameLabel];
    [self addSubview:self.middleNameVLabel];
    [self addSubview:self.firstNameLabel];
    [self addSubview:self.firstNameVLabel];
    [self addSubview:self.sexLabel];
    [self addSubview:self.sexVLabel];
    [self addSubview:self.ageLabel];
    [self addSubview:self.ageVLabel];
    [self addSubview:self.birthLabel];
    [self addSubview:self.birthVLabel];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w=KScreenWidth-32;
    self.nameLabel.frame=CGRectMake(32, 24, w, 20);
    self.nameVLabel.frame=CGRectMake(32, CGRectGetMaxY(self.nameLabel.frame)+8, w, 23);
    self.middleNameLabel.frame=CGRectMake(32, CGRectGetMaxY(self.nameVLabel.frame)+24, w, 20);
    self.middleNameVLabel.frame=CGRectMake(32, CGRectGetMaxY(self.middleNameLabel.frame)+8, w, 23);
    self.firstNameLabel.frame=CGRectMake(32,CGRectGetMaxY(self.middleNameVLabel.frame)+24,w,20);
    self.firstNameVLabel.frame=CGRectMake(32,CGRectGetMaxY(self.firstNameLabel.frame)+8,w,23);
    self.sexLabel.frame=CGRectMake(32, CGRectGetMaxY(self.firstNameVLabel.frame)+24, w, 20);
    self.sexVLabel.frame=CGRectMake(32, CGRectGetMaxY(self.sexLabel.frame)+8, w, 23);
    self.ageLabel.frame=CGRectMake(32, CGRectGetMaxY(self.sexVLabel.frame)+24, w, 20);
    self.ageVLabel.frame=CGRectMake(32, CGRectGetMaxY(self.ageLabel.frame)+8, w, 23);
    self.birthLabel.frame=CGRectMake(32, CGRectGetMaxY(self.ageVLabel.frame)+24, w, 20);
    self.birthVLabel.frame=CGRectMake(32, CGRectGetMaxY(self.birthLabel.frame)+8, w, 23);
}
-(void)setResponse:(BICAuthInfoResponse *)response{
    _response=response;
    self.nameVLabel.text=response.data.name;
    self.middleNameVLabel.text=response.data.middleName;
    self.firstNameVLabel.text=response.data.familyName;
    self.sexVLabel.text=response.data.gender;
    self.birthVLabel.text=response.data.birthday;
    self.ageVLabel.text=response.data.age;
}
-(UILabel *)nameLabel{
    if(!_nameLabel){
        _nameLabel=[[UILabel alloc] init];
        _nameLabel.font=[UIFont systemFontOfSize:14];
        _nameLabel.textColor=UIColorWithRGB(0x64666C);
        _nameLabel.text=LAN(@"名字");
    }
    return _nameLabel;
}
 -(UILabel *)nameVLabel{
     if(!_nameVLabel){
         _nameVLabel=[[UILabel alloc] init];
         _nameVLabel.font=[UIFont systemFontOfSize:16];
         _nameVLabel.textColor=UIColorWithRGB(0x33353B);
     }
     return _nameVLabel;
 }
 -(UILabel *)middleNameLabel{
     if(!_middleNameLabel){
         _middleNameLabel=[[UILabel alloc] init];
         _middleNameLabel.font=[UIFont systemFontOfSize:14];
         _middleNameLabel.textColor=UIColorWithRGB(0x64666C);
         _middleNameLabel.text=LAN(@"中间名");
     }
     return _middleNameLabel;
 }
  -(UILabel *)middleNameVLabel{
      if(!_middleNameVLabel){
          _middleNameVLabel=[[UILabel alloc] init];
          _middleNameVLabel.font=[UIFont systemFontOfSize:16];
          _middleNameVLabel.textColor=UIColorWithRGB(0x33353B);
      }
      return _middleNameVLabel;
  }
 -(UILabel *)firstNameLabel{
     if(!_firstNameLabel){
         _firstNameLabel=[[UILabel alloc] init];
         _firstNameLabel.font=[UIFont systemFontOfSize:14];
         _firstNameLabel.textColor=UIColorWithRGB(0x64666C);
         _firstNameLabel.text=LAN(@"姓氏");
     }
     return _firstNameLabel;
 }
  -(UILabel *)firstNameVLabel{
      if(!_firstNameVLabel){
          _firstNameVLabel=[[UILabel alloc] init];
          _firstNameVLabel.font=[UIFont systemFontOfSize:16];
          _firstNameVLabel.textColor=UIColorWithRGB(0x33353B);
      }
      return _firstNameVLabel;
  }
 -(UILabel *)sexLabel{
     if(!_sexLabel){
         _sexLabel=[[UILabel alloc] init];
         _sexLabel.font=[UIFont systemFontOfSize:14];
         _sexLabel.textColor=UIColorWithRGB(0x64666C);
         _sexLabel.text=LAN(@"性别");
     }
     return _sexLabel;
 }
  -(UILabel *)sexVLabel{
      if(!_sexVLabel){
          _sexVLabel=[[UILabel alloc] init];
          _sexVLabel.font=[UIFont systemFontOfSize:16];
          _sexVLabel.textColor=UIColorWithRGB(0x33353B);
      }
      return _sexVLabel;
  }
-(UILabel *)ageLabel{
    if(!_ageLabel){
        _ageLabel=[[UILabel alloc] init];
        _ageLabel.font=[UIFont systemFontOfSize:14];
        _ageLabel.textColor=UIColorWithRGB(0x64666C);
        _ageLabel.text=LAN(@"年龄");
    }
    return _ageLabel;
}
 -(UILabel *)ageVLabel{
     if(!_ageVLabel){
         _ageVLabel=[[UILabel alloc] init];
         _ageVLabel.font=[UIFont systemFontOfSize:16];
         _ageVLabel.textColor=UIColorWithRGB(0x33353B);
     }
     return _ageVLabel;
 }
 -(UILabel *)birthLabel{
     if(!_birthLabel){
         _birthLabel=[[UILabel alloc] init];
         _birthLabel.font=[UIFont systemFontOfSize:14];
         _birthLabel.textColor=UIColorWithRGB(0x64666C);
         _birthLabel.text=LAN(@"出生日期");
     }
     return _birthLabel;
 }
  -(UILabel *)birthVLabel{
      if(!_birthVLabel){
          _birthVLabel=[[UILabel alloc] init];
          _birthVLabel.font=[UIFont systemFontOfSize:16];
          _birthVLabel.textColor=UIColorWithRGB(0x33353B);
      }
      return _birthVLabel;
  }
@end

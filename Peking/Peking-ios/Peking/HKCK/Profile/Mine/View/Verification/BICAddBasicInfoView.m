//
//  BICBasicInfoView.m
//  Biconome
//
//  Created by a on 2019/10/5.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "BICAddBasicInfoView.h"
#import "BICTextFileView.h"
#import "RSDCLSelectPage.h"
#import "WMCustomDatePicker.h"
#import "BICAuthInfoRequest.h"
@interface BICAddBasicInfoView()
@property (strong, nonatomic)  UILabel *nameLabel;
@property (strong, nonatomic)  BICTextFileView *nametextField;
@property (strong, nonatomic)  UILabel *middleNameLabel;
@property (strong, nonatomic)  BICTextFileView *middleNametextField;
@property (strong, nonatomic)  UILabel *firstNameLabel;
@property (strong, nonatomic)  BICTextFileView *firstNametextField;
@property (strong, nonatomic)  UILabel *sexLabel;
@property (strong, nonatomic)  BICTextFileView *sextextField;
@property (strong, nonatomic)  UILabel *ageLabel;
@property (strong, nonatomic)  BICTextFileView *agetextField;
@property (strong, nonatomic)  UILabel *birthLabel;

//@property (strong, nonatomic)  WMCustomDatePicker *picker;
@end
@implementation BICAddBasicInfoView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self==[super initWithFrame:frame]){
        [self setUpUI];
    }
    return self;
}
-(void)setUpUI{
    [self addSubview:self.nameLabel];
    [self addSubview:self.nametextField];
    [self addSubview:self.middleNameLabel];
    [self addSubview:self.middleNametextField];
    [self addSubview:self.firstNameLabel];
    [self addSubview:self.firstNametextField];
    [self addSubview:self.sexLabel];
    [self addSubview:self.sextextField];
    [self addSubview:self.ageLabel];
    [self addSubview:self.agetextField];
    [self addSubview:self.birthLabel];
    [self addSubview:self.birthtextField];
    [self addSubview:self.subButton];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w=KScreenWidth-80;
    CGFloat margin=40;
    self.nameLabel.frame=CGRectMake(margin, 24, w, 20);
    self.nametextField.frame=CGRectMake(margin, CGRectGetMaxY(self.nameLabel.frame)+8, w, 44);
    self.middleNameLabel.frame=CGRectMake(margin, CGRectGetMaxY(self.nametextField.frame)+24, w, 20);
    self.middleNametextField.frame=CGRectMake(margin, CGRectGetMaxY(self.middleNameLabel.frame)+8, w, 44);
    self.firstNameLabel.frame=CGRectMake(margin,CGRectGetMaxY(self.middleNametextField.frame)+24,w,20);
    self.firstNametextField.frame=CGRectMake(margin,CGRectGetMaxY(self.firstNameLabel.frame)+8,w,44);
    self.sexLabel.frame=CGRectMake(margin, CGRectGetMaxY(self.firstNametextField.frame)+24, w, 20);
    self.sextextField.frame=CGRectMake(margin, CGRectGetMaxY(self.sexLabel.frame)+8, w, 44);
    self.ageLabel.frame=CGRectMake(margin, CGRectGetMaxY(self.sextextField.frame)+24, w, 20);
    self.agetextField.frame=CGRectMake(margin, CGRectGetMaxY(self.ageLabel.frame)+8, w, 44);
    self.birthLabel.frame=CGRectMake(margin, CGRectGetMaxY(self.agetextField.frame)+24, w, 20);
    self.birthtextField.frame=CGRectMake(margin, CGRectGetMaxY(self.birthLabel.frame)+8, w, 44);
    self.subButton.frame=CGRectMake(margin, CGRectGetMaxY(self.birthtextField.frame)+40, w, 44);
}

-(void)setResponse:(BICAuthInfoResponse *)response{
    _response=response;
    self.nametextField.textField.text=response.data.name;
    self.middleNametextField.textField.text=response.data.middleName;
    self.firstNametextField.textField.text=response.data.familyName;
    if(self.response.data.gender && ![self.response.data.gender isEqualToString:@""]){
        self.sextextField.textField.text=response.data.gender;
    }
    self.agetextField.textField.text=response.data.age;
    self.birthtextField.textField.text=response.data.birthday;
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
 -(BICTextFileView *)nametextField{
     if(!_nametextField){
         _nametextField=[[BICTextFileView alloc] init];
         _nametextField.textField.placeholder=LAN(@"请输入名字");
     }
     return _nametextField;
 }
 -(UILabel *)middleNameLabel{
     if(!_middleNameLabel){
         _middleNameLabel=[[UILabel alloc] init];
         _middleNameLabel.font=[UIFont systemFontOfSize:14];
         _middleNameLabel.textColor=UIColorWithRGB(0x64666C);
         _middleNameLabel.text=LAN(@"中间名(可选)");
     }
     return _middleNameLabel;
 }
  -(BICTextFileView *)middleNametextField{
      if(!_middleNametextField){
          _middleNametextField=[[BICTextFileView alloc] init];
          _middleNametextField.textField.placeholder=LAN(@"请输入中间名");
      }
      return _middleNametextField;
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
  -(BICTextFileView *)firstNametextField{
      if(!_firstNametextField){
          _firstNametextField=[[BICTextFileView alloc] init];
          _firstNametextField.textField.placeholder=LAN(@"请输入姓氏");
      }
      return _firstNametextField;
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
  -(BICTextFileView *)sextextField{
      if(!_sextextField){
          _sextextField=[[BICTextFileView alloc] init];
          _sextextField.tipImageView.image=[UIImage imageNamed:@"arrow_more"];
          _sextextField.textField.userInteractionEnabled=NO;
          _sextextField.textField.text=LAN(@"男");
          UITapGestureRecognizer*tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectSexClick)];
          [_sextextField.bgView addGestureRecognizer:tapGesture];
//          _sextextField.textField.text=SDUserDefaultsGET(BICSexConfigType);
      }
      return _sextextField;
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
  -(BICTextFileView *)agetextField{
      if(!_agetextField){
          _agetextField=[[BICTextFileView alloc] init];
          _agetextField.textField.placeholder=LAN(@"请输入年龄");
          _agetextField.textField.keyboardType=UIKeyboardTypeNumberPad;
//          _agetextField.tipImageView.image=[UIImage imageNamed:@"arrow_more"];
//          _agetextField.textField.userInteractionEnabled=NO;
//          UITapGestureRecognizer*tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectAgeClick)];
//          [_agetextField.bgView addGestureRecognizer:tapGesture];
//          _sextextField.textField.text=SDUserDefaultsGET(BICSexConfigType);
      }
      return _agetextField;
  }
-(void)selectAgeClick{}
 -(UILabel *)birthLabel{
     if(!_birthLabel){
         _birthLabel=[[UILabel alloc] init];
         _birthLabel.font=[UIFont systemFontOfSize:14];
         _birthLabel.textColor=UIColorWithRGB(0x64666C);
         _birthLabel.text=LAN(@"出生日期");
     }
     return _birthLabel;
 }
  -(BICTextFileView *)birthtextField{
      if(!_birthtextField){
          _birthtextField=[[BICTextFileView alloc] init];
          _birthtextField.tipImageView.image=[UIImage imageNamed:@"icon_authentication_calendar"];
          _birthtextField.textField.placeholder=LAN(@"请输入出生日期");
          _birthtextField.textField.userInteractionEnabled=NO;
          UITapGestureRecognizer*tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dateSexClick)];
          [_birthtextField.bgView addGestureRecognizer:tapGesture];
      }
      return _birthtextField;
  }

-(void)selectSexClick{
    RSDCLSelectPage * selectPage = [[RSDCLSelectPage alloc] init];
    selectPage.titleStr = LAN(@"选择性别");
    selectPage.dateItemArray = @[LAN(@"男"),LAN(@"女")];
    selectPage.selectPageType = SelectPage_Type_Sex;
    selectPage.typeBlock = ^(NSString *str, NSIndexPath *indexPath) {
        self.sextextField.textField.text=SDUserDefaultsGET(BICSexConfigType);
    };
    [[UtilsManager getCurrentVC].navigationController pushViewController:selectPage animated:YES];
    
}
-(void)dateSexClick{
    if(self.dataSelectItemOperationBlock){
        self.dataSelectItemOperationBlock();
    }
}
-(UIButton *)subButton{
    if(!_subButton){
        _subButton=[[UIButton alloc] init];
        [_subButton setBackgroundColor:UIColorWithRGB(0x6653FF)];
        _subButton.layer.cornerRadius = 4;
        _subButton.layer.masksToBounds=YES;
        [_subButton setTitle:LAN(@"提交") forState:UIControlStateNormal];
        [_subButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _subButton.titleLabel.font=[UIFont systemFontOfSize:17];
        [_subButton addTarget:self action:@selector(requestAddBasicInfo) forControlEvents:UIControlEventTouchUpInside];
    }
    return _subButton;
}

-(void)requestAddBasicInfo{
    if(self.nametextField.textField.text.length==0){
        [BICDeviceManager AlertShowTip:LAN(@"请输入名字")];
        return;
    }
    if(self.firstNametextField.textField.text.length==0){
        [BICDeviceManager AlertShowTip:LAN(@"请输入姓氏")];
        return;
    }
    if(self.sextextField.textField.text.length==0){
        [BICDeviceManager AlertShowTip:LAN(@"请输入性别")];
        return;
    }
    if(self.agetextField.textField.text.length==0){
        [BICDeviceManager AlertShowTip:LAN(@"请输入年龄")];
        return;
    }
    if(self.birthtextField.textField.text.length==0){
        [BICDeviceManager AlertShowTip:LAN(@"请输入出生日期")];
        return;
    }
    
    BICAuthInfoRequest *request=[[BICAuthInfoRequest alloc] init];
    request.name=self.nametextField.textField.text;
    request.middleName=self.middleNametextField.textField.text;
    request.familyName=self.firstNametextField.textField.text;
    request.gender=self.sextextField.textField.text;
    request.birthday=self.birthtextField.textField.text;
    request.age=self.agetextField.textField.text;
    [[BICProfileService sharedInstance] analyticaladdAuthBasicInfo:request serverSuccessResultHandler:^(id response) {
        BICBaseResponse  *responseM = (BICBaseResponse*)response;
        if (responseM.code==200) {
            [[UtilsManager getCurrentVC].navigationController popViewControllerAnimated:YES];
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
    } failedResultHandler:^(id response) {
     
    } requestErrorHandler:^(id error) {
     
    }];
}
@end

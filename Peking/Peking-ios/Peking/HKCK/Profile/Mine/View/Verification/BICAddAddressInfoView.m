//
//  BICBasicInfoView.m
//  Biconome
//
//  Created by a on 2019/10/5.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "BICAddAddressInfoView.h"
#import "NSObject+Extension.h"
#import "BICTextFileView.h"
#import "XWCountryCodeController.h"
@interface BICAddAddressInfoView()
@property (strong, nonatomic)  UILabel *addressLabel;
@property (strong, nonatomic)  BICTextFileView *addresstextField;
@property (strong, nonatomic)  UILabel *cityLabel;
@property (strong, nonatomic)  BICTextFileView *citytextField;
@property (strong, nonatomic)  UILabel *postLabel;
@property (strong, nonatomic)  BICTextFileView *posttextField;
@property (strong, nonatomic)  UILabel *detailLabel;
@property (strong, nonatomic)  BICTextFileView *detailtextField;
@property (strong, nonatomic)  UIButton *subButton;
@end
@implementation BICAddAddressInfoView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self==[super initWithFrame:frame]){
        [self setUpUI];
    }
    return self;
}
-(void)setUpUI{
    [self addSubview:self.addressLabel];
    [self addSubview:self.addresstextField];
    [self addSubview:self.cityLabel];
    [self addSubview:self.citytextField];
    [self addSubview:self.postLabel];
    [self addSubview:self.posttextField];
    [self addSubview:self.detailLabel];
    [self addSubview:self.detailtextField];
    [self addSubview:self.subButton];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w=KScreenWidth-80;
    CGFloat margin=40;
    self.addressLabel.frame=CGRectMake(margin, 24, w, 20);
    self.addresstextField.frame=CGRectMake(margin, CGRectGetMaxY(self.addressLabel.frame)+8, w, 44);
    self.cityLabel.frame=CGRectMake(margin, CGRectGetMaxY(self.addresstextField.frame)+24, w, 20);
    self.citytextField.frame=CGRectMake(margin, CGRectGetMaxY(self.cityLabel.frame)+8, w, 44);
    self.postLabel.frame=CGRectMake(margin,CGRectGetMaxY(self.citytextField.frame)+24,w,20);
    self.posttextField.frame=CGRectMake(margin,CGRectGetMaxY(self.postLabel.frame)+8,w,44);
    self.detailLabel.frame=CGRectMake(margin, CGRectGetMaxY(self.posttextField.frame)+24, w, 20);
//    CGFloat textViewH=[self handleHeightWithStringForHZ:@"" lineSpace:5 font:[UIFont systemFontOfSize:16] lineNumbers:MAXFLOAT maxWidth:w];
    self.detailtextField.frame=CGRectMake(margin, CGRectGetMaxY(self.detailLabel.frame)+8, w, 44);
    self.subButton.frame=CGRectMake(margin, CGRectGetMaxY(self.detailtextField.frame)+40, w, 44);
}

-(void)setResponse:(BICAuthInfoResponse *)response{
    _response=response;
    self.addresstextField.textField.text=response.data.country;
    self.citytextField.textField.text=response.data.city;
    self.posttextField.textField.text=response.data.postcode;
    self.detailtextField.textField.text=response.data.address;
}

-(UILabel *)addressLabel{
    if(!_addressLabel){
        _addressLabel=[[UILabel alloc] init];
        _addressLabel.font=[UIFont systemFontOfSize:14];
        _addressLabel.textColor=UIColorWithRGB(0x64666C);
        _addressLabel.text=LAN(@"国家/地区");
    }
    return _addressLabel;
}
  -(BICTextFileView *)addresstextField{
      if(!_addresstextField){
          _addresstextField=[[BICTextFileView alloc] init];
          _addresstextField.tipImageView.image=[UIImage imageNamed:@"arrow_more"];
          _addresstextField.textField.userInteractionEnabled=NO;
          _addresstextField.textField.placeholder=LAN(@"请输入国家/地区");
          UITapGestureRecognizer*tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectAddressClick)];
          [_addresstextField.bgView addGestureRecognizer:tapGesture];
      }
      return _addresstextField;
  }

-(void)selectAddressClick{
    XWCountryCodeController *CountryCodeVC = [[XWCountryCodeController alloc] init];
    CountryCodeVC.type=XWCountry_type_Other;
    CountryCodeVC.returnCountryCodeBlock = ^(NSString *countryName, NSString *code) {
        self.addresstextField.textField.text=[NSString stringWithFormat:@"%@ +%@",countryName,code];
    };
    CountryCodeVC.isWhiteNavBg=YES;
    [[UtilsManager getCurrentVC].navigationController pushViewController:CountryCodeVC animated:YES];
}
 -(UILabel *)cityLabel{
     if(!_cityLabel){
         _cityLabel=[[UILabel alloc] init];
         _cityLabel.font=[UIFont systemFontOfSize:14];
         _cityLabel.textColor=UIColorWithRGB(0x64666C);
         _cityLabel.text=LAN(@"城市");
     }
     return _cityLabel;
 }
-(BICTextFileView *)citytextField{
    if(!_citytextField){
        _citytextField=[[BICTextFileView alloc] init];
        _citytextField.textField.placeholder=LAN(@"请输入城市");
    }
    return _citytextField;
}
 -(UILabel *)postLabel{
     if(!_postLabel){
         _postLabel=[[UILabel alloc] init];
         _postLabel.font=[UIFont systemFontOfSize:14];
         _postLabel.textColor=UIColorWithRGB(0x64666C);
         _postLabel.text=LAN(@"邮编");
     }
     return _postLabel;
 }
-(BICTextFileView *)posttextField{
    if(!_posttextField){
        _posttextField=[[BICTextFileView alloc] init];
        _posttextField.textField.placeholder=LAN(@"请输入邮编");
        _posttextField.textField.keyboardType=UIKeyboardTypeNumberPad;
    }
    return _posttextField;
}
 -(UILabel *)detailLabel{
     if(!_detailLabel){
         _detailLabel=[[UILabel alloc] init];
         _detailLabel.font=[UIFont systemFontOfSize:14];
         _detailLabel.textColor=UIColorWithRGB(0x64666C);
         _detailLabel.text=LAN(@"地址");
     }
     return _detailLabel;
 }
-(BICTextFileView *)detailtextField{
    if(!_detailtextField){
        _detailtextField=[[BICTextFileView alloc] init];
        _detailtextField.textField.placeholder=LAN(@"请输入地址");
    }
    return _detailtextField;
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
    if(self.addresstextField.textField.text.length==0){
        [BICDeviceManager AlertShowTip:LAN(@"请输入国家/地区")];
        return;
    }
    if(self.citytextField.textField.text.length==0){
        [BICDeviceManager AlertShowTip:LAN(@"请输入城市")];
        return;
    }
    if(self.posttextField.textField.text.length==0){
        [BICDeviceManager AlertShowTip:LAN(@"请输入邮编")];
        return;
    }
    if(self.detailtextField.textField.text.length==0){
        [BICDeviceManager AlertShowTip:LAN(@"请输入地址")];
        return;
    }
    
    BICAuthInfoRequest *request=[[BICAuthInfoRequest alloc] init];
    request.country=self.addresstextField.textField.text;
    request.city=self.citytextField.textField.text;
    request.postcode=self.posttextField.textField.text;
    request.address=self.detailtextField.textField.text;
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

//
//  BICBasicInfoView.m
//  Biconome
//
//  Created by a on 2019/10/5.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "BICAddIdentifyInfoView.h"
#import "NSObject+Extension.h"
#import "BICTextFileView.h"
#import "XWCountryCodeController.h"
#import "VPickView.h"
#import "BICCardExpirationView.h"
#import "RSDCLSelectPage.h"
@interface BICAddIdentifyInfoView()
@property (strong, nonatomic)  UILabel *addressLabel;
@property (strong, nonatomic)  BICTextFileView *addresstextField;
@property (strong, nonatomic)  UILabel *cardTypeLabel;
@property (strong, nonatomic)  BICTextFileView *cardTypetextField;
@property (strong, nonatomic)  UILabel *cardNumLabel;
@property (strong, nonatomic)  BICTextFileView *cardNumtextField;
@property (strong, nonatomic)  UILabel *cardExpirationLabel;
@property (strong, nonatomic)  BICCardExpirationView *cardExpirationtextField;
@property (strong, nonatomic)  UIButton *subButton;
@property (strong, nonatomic) VPickView *picker;
@property (assign, nonatomic) int index;
@property (assign, nonatomic) int cardTypeNum;
@end
@implementation BICAddIdentifyInfoView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self==[super initWithFrame:frame]){
        [self setUpUI];
    }
    return self;
}
-(void)setUpUI{
    [self addSubview:self.addressLabel];
    [self addSubview:self.addresstextField];
    [self addSubview:self.cardTypeLabel];
    [self addSubview:self.cardTypetextField];
    [self addSubview:self.cardNumLabel];
    [self addSubview:self.cardNumtextField];
    [self addSubview:self.cardExpirationLabel];
    [self addSubview:self.cardExpirationtextField];
    [self addSubview:self.subButton];
    [self addSubview:self.picker];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w=KScreenWidth-80;
    CGFloat margin=40;
    self.addressLabel.frame=CGRectMake(margin, 24, w, 20);
    self.addresstextField.frame=CGRectMake(margin, CGRectGetMaxY(self.addressLabel.frame)+8, w, 44);
    self.cardTypeLabel.frame=CGRectMake(margin, CGRectGetMaxY(self.addresstextField.frame)+24, w, 20);
    self.cardTypetextField.frame=CGRectMake(margin, CGRectGetMaxY(self.cardTypeLabel.frame)+8, w, 44);
    self.cardNumLabel.frame=CGRectMake(margin,CGRectGetMaxY(self.cardTypetextField.frame)+24,w,20);
    self.cardNumtextField.frame=CGRectMake(margin,CGRectGetMaxY(self.cardNumLabel.frame)+8,w,44);
    self.cardExpirationLabel.frame=CGRectMake(margin, CGRectGetMaxY(self.cardNumtextField.frame)+24, w, 20);
//    CGFloat textViewH=[self handleHeightWithStringForHZ:@"" lineSpace:5 font:[UIFont systemFontOfSize:16] lineNumbers:MAXFLOAT maxWidth:w];
    self.cardExpirationtextField.frame=CGRectMake(margin, CGRectGetMaxY(self.cardExpirationLabel.frame)+8, w, 44);
    self.subButton.frame=CGRectMake(margin, CGRectGetMaxY(self.cardExpirationtextField.frame)+40, w, 44);
}

-(void)setResponse:(BICAuthInfoResponse *)response{
    _response=response;
    self.addresstextField.textField.text=response.data.issueCountry;
    self.cardTypetextField.textField.text=response.data.cardType;
    NSArray *array= @[LAN(@"身份证"),LAN(@"护照"),LAN(@"驾驶证")];
    self.cardTypetextField.textField.text=[array objectAtIndex:[response.data.cardType intValue]-1];
    self.cardTypeNum=[response.data.cardType intValue];
    self.cardNumtextField.textField.text=response.data.idNumber;
    self.cardExpirationtextField.textField.text=response.data.cardBeginTime;
    self.cardExpirationtextField.textField2.text=response.data.cardLastTime;
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
          _addresstextField.textField.placeholder=LAN(@"请输入国家/地区");
          _addresstextField.tipImageView.image=[UIImage imageNamed:@"arrow_more"];
          _addresstextField.textField.userInteractionEnabled=NO;
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
 -(UILabel *)cardTypeLabel{
     if(!_cardTypeLabel){
         _cardTypeLabel=[[UILabel alloc] init];
         _cardTypeLabel.font=[UIFont systemFontOfSize:14];
         _cardTypeLabel.textColor=UIColorWithRGB(0x64666C);
         _cardTypeLabel.text=LAN(@"证件类型");
     }
     return _cardTypeLabel;
 }
-(BICTextFileView *)cardTypetextField{
    if(!_cardTypetextField){
        _cardTypetextField=[[BICTextFileView alloc] init];
        _cardTypetextField.textField.placeholder=LAN(@"请选择证件类型");
        _cardTypetextField.tipImageView.image=[UIImage imageNamed:@"arrow_more"];
        _cardTypetextField.textField.userInteractionEnabled=NO;
        UITapGestureRecognizer*tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectcardTypeClick)];
        [_cardTypetextField.bgView addGestureRecognizer:tapGesture];
    }
    return _cardTypetextField;
}
-(void)selectcardTypeClick{
    RSDCLSelectPage * selectPage = [[RSDCLSelectPage alloc] init];
    selectPage.titleStr = LAN(@"证件类型");
    selectPage.dateItemArray = @[LAN(@"身份证"),LAN(@"护照"),LAN(@"驾驶证")];
    selectPage.selectPageType = SelectPage_Type_CardType;
    WEAK_SELF
    selectPage.typeBlock = ^(NSString *str, NSIndexPath *indexPath) {
        weakSelf.cardTypetextField.textField.text=SDUserDefaultsGET(BICCardConfigType);
        weakSelf.cardTypeNum=(int)indexPath.row+1;
    };
    [[UtilsManager getCurrentVC].navigationController pushViewController:selectPage animated:YES];
}
 -(UILabel *)cardNumLabel{
     if(!_cardNumLabel){
         _cardNumLabel=[[UILabel alloc] init];
         _cardNumLabel.font=[UIFont systemFontOfSize:14];
         _cardNumLabel.textColor=UIColorWithRGB(0x64666C);
         _cardNumLabel.text=LAN(@"证件号码");
     }
     return _cardNumLabel;
 }
-(BICTextFileView *)cardNumtextField{
    if(!_cardNumtextField){
        _cardNumtextField=[[BICTextFileView alloc] init];
        _cardNumtextField.textField.placeholder=LAN(@"请输入证件号码");
    }
    return _cardNumtextField;
}
 -(UILabel *)cardExpirationLabel{
     if(!_cardExpirationLabel){
         _cardExpirationLabel=[[UILabel alloc] init];
         _cardExpirationLabel.font=[UIFont systemFontOfSize:14];
         _cardExpirationLabel.textColor=UIColorWithRGB(0x64666C);
         _cardExpirationLabel.text=LAN(@"证件有效期");
     }
     return _cardExpirationLabel;
 }
-(BICCardExpirationView *)cardExpirationtextField{
    if(!_cardExpirationtextField){
        _cardExpirationtextField=[[BICCardExpirationView alloc] init];
        _cardExpirationtextField.tipImageView.image=[UIImage imageNamed:@"icon_authentication_calendar"];
        _cardExpirationtextField.textField.userInteractionEnabled=NO;
        _cardExpirationtextField.textField2.userInteractionEnabled=NO;
        _cardExpirationtextField.textField.placeholder=LAN(@"开始日期");
        _cardExpirationtextField.textField2.placeholder=LAN(@"结束日期");
        WEAK_SELF
        _cardExpirationtextField.dataSelectItemOperationBlock = ^(int index) {
            weakSelf.index=index;
            [weakSelf selectData];
        };
    }
    return _cardExpirationtextField;
}

-(void)selectData{
    WEAK_SELF
    CGRect f=weakSelf.picker.frame;
    if(KScreenHeight-kNavBar_Height==f.origin.y){
        f.origin.y-=180;
    }else{
        f.origin.y+=180;
    }
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.picker.frame=f;
    }];
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
        [_subButton addTarget:self action:@selector(requestAddCardInfo) forControlEvents:UIControlEventTouchUpInside];
    }
    return _subButton;
}

-(void)requestAddCardInfo{
    if(self.addresstextField.textField.text.length==0){
        [BICDeviceManager AlertShowTip:LAN(@"请选择签发国家/地区")];
        return;
    }
    if(self.cardTypetextField.textField.text.length==0){
        [BICDeviceManager AlertShowTip:LAN(@"请选择证件类型")];
        return;
    }
    if(self.cardNumtextField.textField.text.length==0){
        [BICDeviceManager AlertShowTip:LAN(@"请输入证件号码")];
        return;
    }
    if(self.cardExpirationtextField.textField.text.length==0 || self.cardExpirationtextField.textField2.text.length==0){
        [BICDeviceManager AlertShowTip:LAN(@"请输入证件有效期")];
        return;
    }
    
    BICAuthInfoRequest *request=[[BICAuthInfoRequest alloc] init];
    request.issueCountry=self.addresstextField.textField.text;
    request.cardType=[NSString stringWithFormat:@"%d",self.cardTypeNum];
    request.idNumber=self.cardNumtextField.textField.text;
    request.cardBeginTimeStr=self.cardExpirationtextField.textField.text;
    request.cardLastTimeStr=self.cardExpirationtextField.textField2.text;
    [[BICProfileService sharedInstance] analyticaladdAuthCardInfo:request serverSuccessResultHandler:^(id response) {
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

-(VPickView *)picker{
    if(!_picker){
        _picker=[[VPickView alloc] initWithFrame:CGRectMake(0, KScreenHeight-kNavBar_Height, KScreenWidth, 180)];
        WEAK_SELF
        _picker.selectedItemOperationBlock = ^(NSString * _Nonnull str) {
             if(weakSelf.index==1){
                  weakSelf.cardExpirationtextField.textField.text=str;
             }else{
                  weakSelf.cardExpirationtextField.textField2.text=str;
             }
        };
    }
    return _picker;
}
-(NSString *)todayString{
    //用于格式化NSDate对象
   NSDateFormatter*dateFormatter=[[NSDateFormatter alloc]init];
   //设置格式：zzz表示时区
   [dateFormatter setDateFormat:@"yyyy-MM-dd"];
   return [dateFormatter stringFromDate:[NSDate date]];
}
//-(void)finishDidSelectDatePicker:(WMCustomDatePicker *)datePicker
//date:(NSDate *)date{
//    //用于格式化NSDate对象
//    NSDateFormatter*dateFormatter=[[NSDateFormatter alloc]init];
//    //设置格式：zzz表示时区
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    if(self.index==1){
//         self.cardExpirationtextField.textField.text=[dateFormatter stringFromDate:date];
//    }else{
//         self.cardExpirationtextField.textField2.text=[dateFormatter stringFromDate:date];
//    }
//
//}
@end

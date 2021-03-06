//
//  BICBasicInfoView.m
//  Biconome
//
//  Created by a on 2019/10/5.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "BICIdentifyInfoView.h"
#import "NSObject+Extension.h"
@interface BICIdentifyInfoView()
@property (strong, nonatomic)  UILabel *addressLabel;
@property (strong, nonatomic)  UILabel *addressVLabel;
@property (strong, nonatomic)  UILabel *cityLabel;
@property (strong, nonatomic)  UILabel *cityVLabel;
@property (strong, nonatomic)  UILabel *postLabel;
@property (strong, nonatomic)  UILabel *postVLabel;
@property (strong, nonatomic)  UILabel *detailLabel;
@property (strong, nonatomic)  UILabel *detailVLabel;
@end
@implementation BICIdentifyInfoView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self==[super initWithFrame:frame]){
        [self setUpUI];
    }
    return self;
}
-(void)setUpUI{
    [self addSubview:self.addressLabel];
    [self addSubview:self.addressVLabel];
    [self addSubview:self.cityLabel];
    [self addSubview:self.cityVLabel];
    [self addSubview:self.postLabel];
    [self addSubview:self.postVLabel];
    [self addSubview:self.detailLabel];
    [self addSubview:self.detailVLabel];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w=KScreenWidth-32-32;
    self.addressLabel.frame=CGRectMake(32, 24, w, 20);
    self.addressVLabel.frame=CGRectMake(32, CGRectGetMaxY(self.addressLabel.frame)+8, w, 23);
    self.cityLabel.frame=CGRectMake(32, CGRectGetMaxY(self.addressVLabel.frame)+24, w, 20);
    self.cityVLabel.frame=CGRectMake(32, CGRectGetMaxY(self.cityLabel.frame)+8, w, 23);
    self.postLabel.frame=CGRectMake(32,CGRectGetMaxY(self.cityVLabel.frame)+24,w,20);
    self.postVLabel.frame=CGRectMake(32,CGRectGetMaxY(self.postLabel.frame)+8,w,23);
    self.detailLabel.frame=CGRectMake(32, CGRectGetMaxY(self.postVLabel.frame)+24, w, 20);
    CGFloat textViewH=[self handleHeightWithStringForHZ:[NSString stringWithFormat:@"%@~%@",self.response.data.cardBeginTime,self.response.data.cardLastTime] lineSpace:5 font:[UIFont systemFontOfSize:16] lineNumbers:10 maxWidth:w];
    self.detailVLabel.frame=CGRectMake(32, CGRectGetMaxY(self.detailLabel.frame)+8, w, textViewH);
}

-(void)setResponse:(BICAuthInfoResponse *)response{
    _response=response;
    self.addressVLabel.text=response.data.issueCountry;
    if([response.data.cardType intValue]==1){
        self.cityVLabel.text=LAN(@"身份证");
    }else if([response.data.cardType intValue]==2){
        self.cityVLabel.text=LAN(@"护照");
    }else{
        self.cityVLabel.text=LAN(@"驾驶证");
    }
    self.postVLabel.text=response.data.idNumber;
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
          [paragraphStyle setLineSpacing:5];
          NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:UIColorWithRGB(0x33353B),NSParagraphStyleAttributeName:paragraphStyle};
       NSMutableAttributedString *date=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@~%@",response.data.cardBeginTime,response.data.cardLastTime] attributes:attributes];
    self.detailVLabel.attributedText=date;
    [self setNeedsLayout];
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
 -(UILabel *)addressVLabel{
     if(!_addressVLabel){
         _addressVLabel=[[UILabel alloc] init];
         _addressVLabel.font=[UIFont systemFontOfSize:16];
         _addressVLabel.textColor=UIColorWithRGB(0x33353B);
     }
     return _addressVLabel;
 }
 -(UILabel *)cityLabel{
     if(!_cityLabel){
         _cityLabel=[[UILabel alloc] init];
         _cityLabel.font=[UIFont systemFontOfSize:14];
         _cityLabel.textColor=UIColorWithRGB(0x64666C);
         _cityLabel.text=LAN(@"证件类型");
     }
     return _cityLabel;
 }
  -(UILabel *)cityVLabel{
      if(!_cityVLabel){
          _cityVLabel=[[UILabel alloc] init];
          _cityVLabel.font=[UIFont systemFontOfSize:16];
          _cityVLabel.textColor=UIColorWithRGB(0x33353B);
      }
      return _cityVLabel;
  }
 -(UILabel *)postLabel{
     if(!_postLabel){
         _postLabel=[[UILabel alloc] init];
         _postLabel.font=[UIFont systemFontOfSize:14];
         _postLabel.textColor=UIColorWithRGB(0x64666C);
         _postLabel.text=LAN(@"证件号码");
     }
     return _postLabel;
 }
  -(UILabel *)postVLabel{
      if(!_postVLabel){
          _postVLabel=[[UILabel alloc] init];
          _postVLabel.font=[UIFont systemFontOfSize:16];
          _postVLabel.textColor=UIColorWithRGB(0x33353B);
      }
      return _postVLabel;
  }
 -(UILabel *)detailLabel{
     if(!_detailLabel){
         _detailLabel=[[UILabel alloc] init];
         _detailLabel.font=[UIFont systemFontOfSize:14];
         _detailLabel.textColor=UIColorWithRGB(0x64666C);
         _detailLabel.text=LAN(@"证件有效期");
     }
     return _detailLabel;
 }
  -(UILabel *)detailVLabel{
      if(!_detailVLabel){
          _detailVLabel=[[UILabel alloc] init];
          _detailVLabel.font=[UIFont systemFontOfSize:16];
          _detailVLabel.textColor=UIColorWithRGB(0x33353B);
          _detailVLabel.numberOfLines=0;
      }
      return _detailVLabel;
  }

@end

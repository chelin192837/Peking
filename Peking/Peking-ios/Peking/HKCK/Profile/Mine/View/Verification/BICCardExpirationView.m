//
//  UITextFileView.m
//  Biconome
//
//  Created by a on 2019/10/5.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "BICCardExpirationView.h"
@interface BICCardExpirationView ()<UITextFieldDelegate>
@property (strong, nonatomic)  UIView *fieldView;
@property (strong, nonatomic)  UIView *fieldView2;

@end
@implementation BICCardExpirationView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self==[super initWithFrame:frame]){
        [self setUpUI];
    }
    return self;
}
-(void)setUpUI{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.textField];
    [self.bgView addSubview:self.textLabel];
    [self.bgView addSubview:self.textField2];
    [self.bgView addSubview:self.tipImageView];
    [self.bgView addSubview:self.fieldView];
    [self.bgView addSubview:self.fieldView2];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.bgView.frame=CGRectMake(0, 0, KScreenWidth-80, 44);
    self.textField.frame=CGRectMake(16, 0, 100, 44);
    self.textLabel.frame=CGRectMake(CGRectGetMaxX(self.textField.frame), 0, 10, 44);
    self.textField2.frame=CGRectMake(CGRectGetMaxX(self.textLabel.frame)+16, 0, 100, 44);
    self.tipImageView.frame=CGRectMake( CGRectGetWidth(self.bgView.frame)-16-14,15, 14, 14);
    self.fieldView.frame=CGRectMake(16, 0, 100, 44);
    self.fieldView2.frame=CGRectMake(CGRectGetMaxX(self.textLabel.frame)+16, 0, 100, 44);
}
-(UIView *)bgView{
    if(!_bgView){
        _bgView=[[UIView alloc] init];
        _bgView.layer.cornerRadius = 4;
        _bgView.layer.masksToBounds=YES;
        _bgView.layer.borderWidth=1;
        _bgView.layer.borderColor=UIColorWithRGB(0xC6C8CE).CGColor;
    }
    return _bgView;
}

-(UITextField *)textField{
    if(!_textField){
        _textField=[[UITextField alloc] init];
        _textField.font =[UIFont systemFontOfSize:16];
       NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:@"" attributes:@{NSForegroundColorAttributeName : UIColorWithRGB(0xC6C8CE)}];
        _textField.attributedPlaceholder = placeholderString;
        _textField.delegate = self;
        _textField.textColor = UIColorWithRGB(0x33353B);
        _textField.returnKeyType = UIReturnKeyNext;
        _textField.keyboardType=UIKeyboardTypeDefault;
        [_textField addTarget:self action:@selector(textValueChanged) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

//-(UILabel *)textField{
//    if(!_textField){
//            _textField=[[UILabel alloc] init];
//            _textField.font=[UIFont systemFontOfSize:16];
//            _textField.textColor=UIColorWithRGB(0x33353B);
//            _textField.userInteractionEnabled=YES;
//            UITapGestureRecognizer*tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dataClick)];
//            [_textField addGestureRecognizer:tapGesture];
////          attributes:@{NSForegroundColorAttributeName : UIColorWithRGB(0xC6C8CE)}];
//       }
//       return _textField;
//}
-(void)dataClick{
    if(self.dataSelectItemOperationBlock){
        self.dataSelectItemOperationBlock(1);
    }
}
//-(UILabel *)textField2{
//    if(!_textField2){
//           _textField2=[[UILabel alloc] init];
//           _textField2.font=[UIFont systemFontOfSize:16];
//           _textField2.textColor=UIColorWithRGB(0x33353B);
//          _textField2.userInteractionEnabled=YES;
//          UITapGestureRecognizer*tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dataClick2)];
//          [_textField2 addGestureRecognizer:tapGesture];
//       }
//       return _textField2;
//}
-(void)dataClick2{
    if(self.dataSelectItemOperationBlock){
        self.dataSelectItemOperationBlock(2);
    }
}
-(UILabel *)textLabel{
    if(!_textLabel){
        _textLabel=[[UILabel alloc] init];
        _textLabel.font=[UIFont systemFontOfSize:16];
        _textLabel.textColor=UIColorWithRGB(0x33353B);
        _textLabel.text=@"~";
    }
    return _textLabel;
}
-(UITextField *)textField2{
    if(!_textField2){
        _textField2=[[UITextField alloc] init];
        _textField2.font =[UIFont systemFontOfSize:16];
       NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:@"" attributes:@{NSForegroundColorAttributeName : UIColorWithRGB(0xC6C8CE)}];
        _textField2.attributedPlaceholder = placeholderString;
        _textField2.delegate = self;
        _textField2.textColor = UIColorWithRGB(0x33353B);
        _textField2.returnKeyType = UIReturnKeyNext;
        _textField2.keyboardType=UIKeyboardTypeDefault;
        [_textField2 addTarget:self action:@selector(textValueChanged) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField2;
}
-(void)textValueChanged{
    
}

-(UIView *)fieldView{
    if(!_fieldView){
        _fieldView=[[UIView alloc] init];
        UITapGestureRecognizer*tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dataClick)];
        [_fieldView addGestureRecognizer:tapGesture];
    }
    return _fieldView;
}
-(UIView *)fieldView2{
    if(!_fieldView2){
        _fieldView2=[[UIView alloc] init];
        UITapGestureRecognizer*tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dataClick2)];
        [_fieldView2 addGestureRecognizer:tapGesture];
    }
    return _fieldView2;
}
-(UIImageView *)tipImageView{
    if(!_tipImageView){
        _tipImageView=[[UIImageView alloc] init];
    }
    return _tipImageView;
}
@end

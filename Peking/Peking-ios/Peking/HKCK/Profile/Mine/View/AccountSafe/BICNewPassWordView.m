//
//  BICPassWordView.m
//  Biconome
//
//  Created by a on 2019/9/26.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "BICNewPassWordView.h"
@interface BICNewPassWordView()<UITextFieldDelegate>
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *desLabel;

@property(nonatomic,strong)UILabel *passLabel;
@property(nonatomic,strong)UIView *passfieldView;


@property(nonatomic,strong)UILabel *confirmLabel;
@property(nonatomic,strong)UIView *confirmfieldView;



@end
@implementation BICNewPassWordView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
         [self setupUI];
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.titleLabel];
    [self addSubview:self.desLabel];
    [self addSubview:self.passLabel];
    [self addSubview:self.passfieldView];
    [self addSubview:self.passField];
    [self addSubview:self.confirmLabel];
    [self addSubview:self.confirmfieldView];
    [self addSubview:self.confirmField];
    [self addSubview:self.nextButton];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.frame=CGRectMake(40, 16, KScreenWidth-80, 40);
    self.desLabel.frame=CGRectMake(40, CGRectGetMaxY(self.titleLabel.frame)+10, KScreenWidth-80, 45);
    self.passLabel.frame=CGRectMake(40, CGRectGetMaxY(self.desLabel.frame)+24, KScreenWidth-80, 20);
    self.passfieldView.frame=CGRectMake(40,CGRectGetMaxY(self.passLabel.frame)+8, KScreenWidth-80, 48);
    self.passField.frame=CGRectMake(40+12,CGRectGetMaxY(self.passLabel.frame)+8, KScreenWidth-80-24, 48);
    self.confirmLabel.frame=CGRectMake(40, CGRectGetMaxY(self.passField.frame)+16, KScreenWidth-80, 20);
    self.confirmfieldView.frame=CGRectMake(40, CGRectGetMaxY(self.confirmLabel.frame)+8, KScreenWidth-80, 48);
    self.confirmField.frame=CGRectMake(40+12, CGRectGetMaxY(self.confirmLabel.frame)+8, KScreenWidth-80-24, 48);
    self.nextButton.frame=CGRectMake(40, CGRectGetMaxY(self.confirmField.frame)+32, KScreenWidth-80, 48);
}
-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel=[[UILabel alloc] init];
        _titleLabel.text=LAN(@"修改密码");
        _titleLabel.textColor=UIColorWithRGB(0x33353B);
        _titleLabel.font=[UIFont systemFontOfSize:24];
    }
    return _titleLabel;
}
-(UILabel *)desLabel{
    if(!_desLabel){
        _desLabel=[[UILabel alloc] init];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:5];
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:UIColorWithRGB(0xFF9822),NSParagraphStyleAttributeName:paragraphStyle};
         _desLabel.attributedText=[[NSMutableAttributedString alloc] initWithString:LAN(@"为了账户安全，重置登录密码后24小时禁止提币") attributes:attributes];
        _desLabel.textColor=UIColorWithRGB(0xFF9822);
        _desLabel.font=[UIFont systemFontOfSize:16];
        _desLabel.numberOfLines=2;
    }
    return _desLabel;
}
-(UILabel *)passLabel{
    if(!_passLabel){
        _passLabel=[[UILabel alloc] init];
        _passLabel.text=LAN(@"密码");
        _passLabel.textColor=UIColorWithRGB(0x64666C);
        _passLabel.font=[UIFont systemFontOfSize:14];
    }
    return _passLabel;
}
-(UIView *)passfieldView{
    if(!_passfieldView){
        _passfieldView=[[UIView alloc] init];
        _passfieldView.layer.cornerRadius = 4;
        _passfieldView.layer.masksToBounds=YES;
        _passfieldView.layer.borderWidth=1;
        _passfieldView.layer.borderColor=UIColorWithRGB(0xC6C8CE).CGColor;
        _passfieldView.layer.shouldRasterize=YES;
    }
    return _passfieldView;
}
-(UITextField *)passField{
    if(!_passField){
        _passField=[[UITextField alloc] init];
        _passField.font =[UIFont systemFontOfSize:16];
        _passField.placeholder = LAN(@"设置新密码");
//        [_passField setValue:UIColorWithRGB(0xC6C8CE) forKeyPath:@"_placeholderLabel.textColor"];
        NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:_passField.placeholder attributes:@{NSForegroundColorAttributeName : UIColorWithRGB(0xC6C8CE)}];
        _passField.attributedPlaceholder = placeholderString;
        _passField.delegate = self;
        _passField.textColor = UIColorWithRGB(0x64666C);
        _passField.clearButtonMode=UITextFieldViewModeWhileEditing;
        _passField.returnKeyType = UIReturnKeyNext;
        _passField.keyboardType=UIKeyboardTypeDefault;
        _passField.secureTextEntry = YES;
        [_passField addTarget:self action:@selector(textValueChanged) forControlEvents:UIControlEventEditingChanged];
    }
    return _passField;
}

-(UILabel *)confirmLabel{
    if(!_confirmLabel){
        _confirmLabel=[[UILabel alloc] init];
        _confirmLabel.text=LAN(@"确认密码");
        _confirmLabel.textColor=UIColorWithRGB(0x64666C);
        _confirmLabel.font=[UIFont systemFontOfSize:14];
    }
    return _confirmLabel;
}
-(UIView *)confirmfieldView{
    if(!_confirmfieldView){
        _confirmfieldView=[[UIView alloc] init];
        _confirmfieldView.layer.cornerRadius = 4;
        _confirmfieldView.layer.masksToBounds=YES;
        _confirmfieldView.layer.borderWidth=1;
        _confirmfieldView.layer.borderColor=UIColorWithRGB(0xC6C8CE).CGColor;
        _confirmfieldView.layer.shouldRasterize=YES;
    }
    return _confirmfieldView;
}
-(UITextField *)confirmField{
    if(!_confirmField){
        _confirmField=[[UITextField alloc] init];
        _confirmField.font =[UIFont systemFontOfSize:16];
        _confirmField.placeholder = LAN(@"确认新密码");
//        [_confirmField setValue:UIColorWithRGB(0xC6C8CE) forKeyPath:@"_placeholderLabel.textColor"];
        NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:_confirmField.placeholder attributes:@{NSForegroundColorAttributeName : UIColorWithRGB(0xC6C8CE)}];
        _confirmField.attributedPlaceholder = placeholderString;
        _confirmField.delegate = self;
        _confirmField.textColor = UIColorWithRGB(0x64666C);
        _confirmField.clearButtonMode=UITextFieldViewModeWhileEditing;
        _confirmField.returnKeyType = UIReturnKeyNext;
        _confirmField.keyboardType=UIKeyboardTypeDefault;
        _confirmField.secureTextEntry = YES;
        [_confirmField addTarget:self action:@selector(textValueChanged) forControlEvents:UIControlEventEditingChanged];
    }
    return _confirmField;
}
-(UIButton *)nextButton{
    if(!_nextButton){
        _nextButton=[[UIButton alloc] init];
        [_nextButton setTitle:LAN(@"下一步") forState:UIControlStateNormal];
        [_nextButton setTitleColor:UIColorWithRGB(0xFFFFFF) forState:UIControlStateNormal];
        [_nextButton setBackgroundColor:UIColorWithRGB(0x6653FF)];
        _nextButton.titleLabel.font=[UIFont systemFontOfSize:18];
        _nextButton.layer.cornerRadius = 4;
        _nextButton.layer.masksToBounds=YES;
    }
    return _nextButton;
}
-(void)textValueChanged{
    
}
@end

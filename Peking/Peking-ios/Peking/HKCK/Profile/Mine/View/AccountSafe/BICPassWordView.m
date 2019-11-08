//
//  BICPassWordView.m
//  Biconome
//
//  Created by a on 2019/9/26.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "BICPassWordView.h"
@interface BICPassWordView()<UITextFieldDelegate>
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *desLabel;
@property(nonatomic,strong)UILabel *origenLabel;
@property(nonatomic,strong)UIView *fieldView;


@end
@implementation BICPassWordView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
         [self setupUI];
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.titleLabel];
    [self addSubview:self.desLabel];
    [self addSubview:self.origenLabel];
    [self addSubview:self.fieldView];
    [self addSubview:self.pwdField];
    [self addSubview:self.nextButton];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.frame=CGRectMake(40, 16, KScreenWidth-80, 40);
    self.desLabel.frame=CGRectMake(40, CGRectGetMaxY(self.titleLabel.frame)+10, KScreenWidth-80, 45);
    self.origenLabel.frame=CGRectMake(40, CGRectGetMaxY(self.desLabel.frame)+24, KScreenWidth-80, 20);
    self.fieldView.frame=CGRectMake(40,CGRectGetMaxY(self.origenLabel.frame)+8, KScreenWidth-80, 48);
    self.pwdField.frame=CGRectMake(40+12,CGRectGetMaxY(self.origenLabel.frame)+8, KScreenWidth-80-24, 48);
    self.nextButton.frame=CGRectMake(40, CGRectGetMaxY(self.pwdField.frame)+32, KScreenWidth-80, 48);
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
-(UILabel *)origenLabel{
    if(!_origenLabel){
        _origenLabel=[[UILabel alloc] init];
        _origenLabel.text=LAN(@"原密码");
        _origenLabel.textColor=UIColorWithRGB(0x64666C);
        _origenLabel.font=[UIFont systemFontOfSize:14];
    }
    return _origenLabel;
}
-(UIView *)fieldView{
    if(!_fieldView){
        _fieldView=[[UIView alloc] init];
        _fieldView.layer.cornerRadius = 4;
        _fieldView.layer.masksToBounds=YES;
        _fieldView.layer.borderWidth=1;
        _fieldView.layer.borderColor=UIColorWithRGB(0xC6C8CE).CGColor;
        _fieldView.layer.shouldRasterize=YES;
    }
    return _fieldView;
}
-(UITextField *)pwdField{
    if(!_pwdField){
        _pwdField=[[UITextField alloc] init];
        _pwdField.font =[UIFont systemFontOfSize:16];
        _pwdField.placeholder = LAN(@"输入原密码");
//        [_pwdField setValue:UIColorWithRGB(0xC6C8CE) forKeyPath:@"_placeholderLabel.textColor"];
        NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:_pwdField.placeholder attributes:@{NSForegroundColorAttributeName : UIColorWithRGB(0xC6C8CE)}];
         _pwdField.attributedPlaceholder = placeholderString;
        _pwdField.delegate = self;
        _pwdField.textColor = UIColorWithRGB(0x64666C);
        _pwdField.clearButtonMode=UITextFieldViewModeWhileEditing;
        _pwdField.returnKeyType = UIReturnKeyNext;
        _pwdField.keyboardType=UIKeyboardTypeDefault;
        _pwdField.secureTextEntry = YES;
        [_pwdField addTarget:self action:@selector(textValueChanged) forControlEvents:UIControlEventEditingChanged];
    }
    return _pwdField;
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
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    if (textField == self.pwdField) {
//        NSString *textStr = [NSString stringWithFormat:@"%@%@",textField.text,string];
//        if (textStr.length > 18) {
//            textField.text = [textStr substringToIndex:18];
//            return NO;
//        }
//    }
    return YES;
}
-(void)textValueChanged{
    
}
@end

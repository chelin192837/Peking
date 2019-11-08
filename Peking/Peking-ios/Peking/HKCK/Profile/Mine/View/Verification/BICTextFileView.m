//
//  UITextFileView.m
//  Biconome
//
//  Created by a on 2019/10/5.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "BICTextFileView.h"
#import "NSString+WH.h"
@interface BICTextFileView ()<UITextFieldDelegate>


@end
@implementation BICTextFileView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self==[super initWithFrame:frame]){
        [self setUpUI];
    }
    return self;
}
-(void)setUpUI{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.textField];;
    [self.bgView addSubview:self.tipImageView];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.bgView.frame=CGRectMake(0, 0, KScreenWidth-80, 44);
    self.tipImageView.frame=CGRectMake( CGRectGetWidth(self.bgView.frame)-16-14,15, 14, 14);
    self.textField.frame=CGRectMake(16, 0, CGRectGetMinX(self.tipImageView.frame)-16, 44);
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
//        _textField.clearButtonMode=UITextFieldViewModeWhileEditing;
        _textField.returnKeyType = UIReturnKeyNext;
        _textField.keyboardType=UIKeyboardTypeDefault;
//        _textField.secureTextEntry = YES;
        [_textField addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}
-(BOOL)isNineKeyBoard:(NSString *)string
{
    NSString *other = @"➋➌➍➎➏➐➑➒";
    int len = (int)string.length;
    for(int i=0;i<len;i++)
    {
        if(!([other rangeOfString:string].location != NSNotFound))
            return NO;
    }
    return YES;
}
/**
 *  判断字符串中是否存在emoji
 * @param string 字符串
 * @return YES(含有表情)
 */
- (BOOL)stringContainsEmoji:(NSString *)string {
    
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}
/**
 *  判断字符串中是否存在emoji
 * @param string 字符串
 * @return YES(含有表情)
 */
- (BOOL)hasEmoji:(NSString*)string;
{
    NSString *pattern = @"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}
 
 //去除字符串中所带的表情
 - (NSString *)disable_emoji:(NSString *)text{
     NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"options:NSRegularExpressionCaseInsensitive error:nil];
     NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                                options:0
                                                                  range:NSMakeRange(0, [text length])
                                                           withTemplate:@""];
     return modifiedString;
 }
  
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self stringContainsEmoji:textField.text]) {
//        [self LGShowMsg:@"禁止输入表情,请重新输入"];
        NSLog(@"有表情");
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([textField isFirstResponder]) {
        //判断键盘是不是九宫格键盘
        if ([self isNineKeyBoard:string] ){
            return YES;
        }else{
            if ([self hasEmoji:string] || [self stringContainsEmoji:string]){
//                [self LGShowMsg:ForbiddenMsg];
                return NO;
            }
        }
        if ([[[textField textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textField textInputMode] primaryLanguage]) {
//            [self LGShowMsg:ForbiddenMsg];
            return NO;
        }
    }
    
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textValueChanged:(UITextField *)TextField
{
    if (TextField.text.length > 0 && [self stringContainsEmoji:TextField.text]) {
//        [self LGShowMsg:ForbiddenMsg];
//        NSLog(@"有表情");
        // 禁止系统表情的输入
        NSString *text = [self disable_emoji:[TextField text]];
        TextField.text = text;
    }
    
    if(TextField.text.length>250){
         NSString *text = [[TextField text] substringToIndex:250];
         TextField.text = text;
    }
}
 

-(UIImageView *)tipImageView{
    if(!_tipImageView){
        _tipImageView=[[UIImageView alloc] init];
    }
    return _tipImageView;
}
@end

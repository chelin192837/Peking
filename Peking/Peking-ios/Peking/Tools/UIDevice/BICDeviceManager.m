//
//  BICDeviceManager.m
//  Biconome
//
//  Created by 车林 on 2019/8/15.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICDeviceManager.h"
#import "TopAlertView.h"
#import "BICSendRegCodeRequest.h"
#import "BICLoginVC.h"
#import "SDArchiverTools.h"

@implementation BICDeviceManager

//获取不同版本的语言
+(NSString*)getLanguage:(NSString*)string
{
    
    NSString* str = @"";

    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"language_type"]) {
        str = [[NSUserDefaults standardUserDefaults] objectForKey:@"language_type"];
    }else if(LanguageIsEnglish)
    {
        str = @"en";
    }else{
       str = @"zh-Hans";
    }
  
    NSString *path = [[NSBundle mainBundle] pathForResource:str ofType:@"lproj"];
    NSString *labelString = [[NSBundle bundleWithPath:path] localizedStringForKey:string value:nil table:@"BTCLocalizable"];

    return labelString;
}

//获取不同版本的语言
+(NSString*)getLanguageCurrencyStr
{
    NSString* str = @"";
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"language_type"]) {
       NSString* str1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"language_type"];
        if ([str1 isEqualToString:@"en"]) {
            str = @"en_US";
        }else if([str1 isEqualToString:@"zh-Hans"])
        {
            str = @"zh_CN";
        }
    }else if(LanguageIsEnglish)
    {
        str = @"en_US";
    }else{
        str = @"zh_CN";
    }
    
    return str;
}

+(BOOL)languageIsChinese
{
    NSString* str = @"";
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"language_type"]) {
        str = [[NSUserDefaults standardUserDefaults] objectForKey:@"language_type"];
    }else if(LanguageIsEnglish)
    {
        str = @"en";
    }else{
        str = @"zh-Hans";
    }
    if ([str isEqualToString:@"zh-Hans"]) {
        return YES;
    }else
    {
        return NO;
    }
}

+(void)AlertShowTip:(NSString*)string
{
    [TopAlertView SetUpbackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:1] andStayTime:2 andImageName:@"tips" andTitleStr:string andTitleColor:[UIColor colorFromHexRGB:@"00CC99"]];
}

//+(BOOL)passwordVertify:(NSString *)string
//{
#pragma mark --密码同时包含6~18位数字和大小写字母，不包含特殊字符的判断方法（正则表达式）
+(BOOL)passwordVertify:(NSString *)string
{
    return [self isOrNoPassword:string];
}


+ (BOOL)isOrNoPassword:(NSString *)passWordName
{
    
    if (passWordName.length<6)
    {
        return NO;
        
    }else if (passWordName.length>18)
    {
        return NO;
    }
    else if ([self JudgeTheillegalCharacter:passWordName])
    {
        return NO;
    }
    else if (![self judgePassWordLegal:passWordName])
    {
        return NO;
    }
    
    return YES;
}

+ (NSString *)isOrNoPasswordStyle:(NSString *)passWordName
    {
        NSString * message;
        
        if (passWordName.length<8)
        {
            message=LAN(@"密码不能少于8位，请您重新输入");
        }else if (passWordName.length>18)
        {
            message = LAN(@"密码最大长度为18位，请您重新输入");
        }
        else if ([self JudgeTheillegalCharacter:passWordName])
        {
            message = LAN(@"密码不能包含特殊字符，请您重新输入");
        }
        else if (![self judgePassWordLegal:passWordName])
        {
            message = LAN(@"密码必须同时包含大小写字母和数字");
        }
        
        return message;
    }

+ (BOOL)JudgeTheillegalCharacter:(NSString *)content{
        //提示标签不能输入特殊字符
        NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
        
        NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
        
        if (![emailTest evaluateWithObject:content]) {
            
            return YES;
        }
        return NO;
}
    
+ (BOOL)judgePassWordLegal:(NSString *)pass{
        BOOL result ;
        // 判断长度大于6位后再接着判断是否同时包含数字和大小写字母

        NSString * regex =@"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{1,16}$";

        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        
        result = [pred evaluateWithObject:pass];
    
        return result;
}

+(void)addDottedBorderWithView:(UIView*)view{
    CGFloat viewWidth = view.mj_w;
    CGFloat viewHeight = view.mj_h;
    view.layer.cornerRadius = 8;
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.bounds = CGRectMake(0, 0, viewWidth, viewHeight);
    borderLayer.position = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds));
    borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:borderLayer.bounds cornerRadius:8].CGPath;
    borderLayer.lineWidth = 1. / [[UIScreen mainScreen] scale];
    borderLayer.lineDashPattern = @[@4, @4];
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = [UIColor redColor].CGColor;
    [view.layer addSublayer:borderLayer];
}
//判断是否全为数字
+(BOOL)deptNumInputShouldNumber:(NSString*)text{
   
    NSString *regex =@"[0-9]*";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
 
//    if (![pred evaluateWithObject:text]) {
//             return YES;
//       }
    return [pred evaluateWithObject:text];
}

+(float)getRandomNumber:(int)from to:(int)to
{
    return (float)(from + (arc4random() % (to-from + 1)));
}
+(NSString*)GetPairCoinName
{
    NSArray * arr = SDUserDefaultsGET(BICEXCChangeCoinPair);
    if (arr.count>1) {
        return arr[0];
    }
    return @"BTC";
}

+(NSString*)GetPairUnitName
{
    NSArray * arr = SDUserDefaultsGET(BICEXCChangeCoinPair);
    if (arr.count>1) {
        return arr[1];
    }
    return @"USDT";
}
+(float)GetUSDTToYuan
{
    NSNumber * yuanNum = SDUserDefaultsGET(BICUSDTYANG);
    float yuan = yuanNum.floatValue;
    return yuan?:0.f;
}
+(float)GetBICToUSDT
{
    NSNumber * usdNum = SDUserDefaultsGET(BICBTCTOUSDT);
    float usdNu = usdNum.doubleValue;
    return usdNu?:0.f;
}
//获取当前制定币种的个数
+(double)GetCoinCount:(NSString*)coin
{
    return 0.001f;
}
//获取我的钱包列表
+(NSArray*)GetWalletList
{

    NSArray *tempArray = [SDArchiverTools unarchiverObjectByKey:BICWALLETLISTOFMINE];
    
    return tempArray;
}

//获取我的钱包的BTC估值
+(double)GetWalletBtcValue
{
    NSNumber * btc = SDUserDefaultsGET(BICWalletBtcValue);
      double btcNum = btc.doubleValue;
      return btcNum?:0.f;
}

//复制
+(void)pasteboard:(NSString*)str
{
    UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:str];
}
//获取当前汇率类型。CNY USD
+(NSString*)getCurrentRate
{
    NSString * str = SDUserDefaultsGET(BICRateConfigType);
    if (!str) {
        return @"CNY";
    }
    return str;
}
+(NSString*)getCurrentSex
{
    NSString * str = SDUserDefaultsGET(BICSexConfigType);
    if (!str) {
        return LAN(@"男");
    }
    return str;
}

+(NSString*)getCurrentCardType
{
    NSString * str = SDUserDefaultsGET(BICCardConfigType);
    if (!str) {
        return LAN(@"身份证");
    }
    return str;
}
//判断是否登录
+(BOOL)isLogin
{
    NSString *str = SDUserDefaultsGET(APPID);
    if (!str) {
        return NO;
    }
    return YES;
}
+(void)PushToLoginView
{
        BICLoginVC * loginVC = [[BICLoginVC alloc] initWithNibName:@"BICLoginVC" bundle:nil];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
            
        }];
}

//数字千分位
+(NSString*)countNumAndChangeformat:(NSString*)num
{
    int count = 0;
    
    long long int a = num.longLongValue;
    
    while (a != 0)
        
    {
        
        count++;
        
        a /= 10;
        
    }
    
    NSMutableString *string = [NSMutableString stringWithString:num];
    
    NSMutableString *newstring = [NSMutableString string];
    
    while (count > 3) {
        
        count -= 3;
        
        NSRange rang = NSMakeRange(string.length - 3, 3);
        
        NSString *str = [string substringWithRange:rang];
        
        [newstring insertString:str atIndex:0];
        
        [newstring insertString:@"," atIndex:0];
        
        [string deleteCharactersInRange:rang];
        
    }
    
    [newstring insertString:string atIndex:0];
    
    return newstring;
    
}
 
+(NSString*)changeFormatter:(NSString *)str  length:(NSInteger)length
{
    NSArray *arr=[str componentsSeparatedByString:@"."];
    if(arr.count>1){
        NSString *pointstr=[arr objectAtIndex:1];
        if(pointstr.length>length){
            str=[NSString stringWithFormat:@"%@.%@",[arr objectAtIndex:0],[pointstr substringToIndex:length]];
        }
    }
   return str;
}
//转化为千分位格式,例如 :33369080 输出：33,369,080
+(NSString*)changeNumberFormatter:(NSString*)str
{
    
    NSArray *arr=[str componentsSeparatedByString:@"."];
    if(arr.count>1){
        NSString *pointstr=[arr objectAtIndex:1];
        if(pointstr.length>8){
            str=[NSString stringWithFormat:@"%@.%@",[arr objectAtIndex:0],[pointstr substringToIndex:8]];
        }
    }
   return [self addComma:str];

//
//    NSString *numString = [NSString stringWithFormat:@"%@",str];
//    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
//    NSNumber *number = [formatter numberFromString:numString];
//    formatter.numberStyle=kCFNumberFormatterDecimalStyle;
//    NSString *string = [formatter stringFromNumber:number];
//    if(string.floatValue < 1) {
//        return str;
//    }
//    return string;
}
+ (NSString *)addComma:(id)str{
    
    NSString *string=@"";
    
    if([str isKindOfClass:[NSString class]]){
        string=str;
    }else{
        string=[NSString stringWithFormat:@"%@",str];
    }
    
    if(string.length == 0)
    {
        return nil;
    }
    

    NSRange range = [string rangeOfString:@"."];
    
    NSMutableString *temp = [NSMutableString stringWithString:string];
    int i;
    if (range.length > 0) {
        //有.
        i = (int)range.location;
    }
    else
    {
        i = (int)string.length;
    }
    
    while ((i-=3) > 0) {
        
        [temp insertString:@"," atIndex:i];
    }
    
    return temp;
}
//快排法
//NSMutableArray *arr = [[NSMutableArray alloc] initWithObjects:@(6), @(1),@(2),@(5),@(9),@(4),@(3),@(7),nil];
//[self quickSortArray:arr withLeftIndex:0 andRightIndex:arr.count - 1];
+ (void)quickSortArray:(NSMutableArray *)array withLeftIndex:(NSInteger)leftIndex andRightIndex:(NSInteger)rightIndex
{
    if (leftIndex >= rightIndex) {//如果数组长度为0或1时返回
        return ;
    }
    
    NSInteger i = leftIndex;
    NSInteger j = rightIndex;
    //记录比较基准数
    NSInteger key = [array[i] integerValue];
    
    while (i < j) {
        /**** 首先从右边j开始查找比基准数小的值 ***/
        while (i < j && [array[j] integerValue] >= key) {//如果比基准数大，继续查找
            j--;
        }
        //如果比基准数小，则将查找到的小值调换到i的位置
        array[i] = array[j];
        
        /**** 当在右边查找到一个比基准数小的值时，就从i开始往后找比基准数大的值 ***/
        while (i < j && [array[i] integerValue] <= key) {//如果比基准数小，继续查找
            i++;
        }
        //如果比基准数大，则将查找到的大值调换到j的位置
        array[j] = array[i];
        
    }
    
    //将基准数放到正确位置
    array[i] = @(key);
    
    /**** 递归排序 ***/
    //排序基准数左边的
    [BICDeviceManager quickSortArray:array withLeftIndex:leftIndex andRightIndex:i - 1];
    //排序基准数右边的
    [BICDeviceManager quickSortArray:array withLeftIndex:i + 1 andRightIndex:rightIndex];
}


@end





























































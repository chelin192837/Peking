//
//  SDDeviceManager.m
//  Agent
//
//  Created by 七扇门 on 16/1/6.
//  Copyright © 2016年 七扇门. All rights reserved.
//

#import "SDDeviceManager.h"
#import <sys/utsname.h>
#import "SDRuleView.h"
#import "SDArchiverTools.h"

@implementation SDDeviceManager


+ (BOOL)isIPhone4s{
    return ([[self class]screenHeight] == 480.0);
}
+(BOOL)isIPhone5{
    return ([[self class] screenHeight] == 568.0);
}
+(BOOL)isIPhone5or4{
    return ([[self class] screenWidth] == 320.0);
}
+(BOOL)isIPhone6
{
    return [[self class] screenWidth] == 375.0;
}
+(BOOL)isIPhone6p
{
    return [[self class] screenWidth] == 414.0;
}
+ (BOOL)isIPhone6s {
    NSLog(@"%@",[SDDeviceManager deviceModel]);
    return ([[NSNumber numberWithUnsignedChar:[[SDDeviceManager deviceModel] characterAtIndex:6]] intValue] >= 56);
}
+ (NSString *)deviceModel {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return deviceString;
}

+(BOOL)isIOS6orLater{
    return ([[[UIDevice currentDevice] systemVersion] doubleValue]>=6.0);
}

+(BOOL)isIOS7orLater{
    return ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0);
}

+(BOOL)isIOS8orLater{
    return ([[[UIDevice currentDevice] systemVersion] doubleValue]>=8.0);
}

+ (BOOL)isIOS9orLater {
    return [[[UIDevice currentDevice] systemVersion] doubleValue]>=9.0;
}
+ (BOOL)isIOS11orLater
{
    return [[[UIDevice currentDevice] systemVersion] doubleValue]>=11.0;
}
+(NSString *)isSwitchStatusNum{
    return [[NSUserDefaults standardUserDefaults] objectForKey:SWITCHSTATUS];
}
+(NSString *)isDecoratorStatusNum{
    return [[NSUserDefaults standardUserDefaults] objectForKey:DECORATOR_STATUS];
}
+(NSString *)isDecoratorIdentityNum{
    return [[NSUserDefaults standardUserDefaults] objectForKey:DECORATOR_IDENTITY];
}
+(NSString *)isStatusNum
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:STATUS];
}
+(NSString *)isStatusNumCard
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:STATUSCARD];
}

+ (BOOL)showLoginSwitchAuthenView:(BOOL)isNeedLogin{
//    if (isNeedLogin && STATUS0) {
//        SDLoginViewController  *loginVC = [[SDLoginViewController alloc] initWithNibName:@"SDLoginViewController" bundle:nil];
//        [[UtilsManager getCurrentVC].navigationController pushViewController:loginVC animated:YES];
//        return NO;
//    }
//
//    if ((STATUS1 && DEC_STATUS2 && SWITCH_STATUS0) ||
//        (STATUS1 && DEC_STATUS3 && SWITCH_STATUS0) ||
//        (!STATUS1 && DEC_STATUS1 && SWITCH_STATUS1)) {
//        [[SDRuleView publishView] tipToSwitchStatus];
//        return NO;
//    }
//    if ((STATUS8 && DEC_STATUS1) || (DEC_STATUS2 && STATUS1)) {
//        SDMainView *nmView = [[[NSBundle mainBundle] loadNibNamed:@"SDMainView" owner:nil options:nil] firstObject];
//        [nmView showPendingStateAlertView];
//        return NO;
//    }
//    if (STATUS1) {
//        if (DEC_STATUS1 || DEC_STATUS4) {
//            [SDMainView showAuthenAlertView];
//            return NO;
//        }
//    }
    return YES;
}

+(UIColor *)colorFromHexRGB:(NSString *)inColorString
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode];	// ignore error
    }
    redByte		= (unsigned char) (colorCode >> 16);
    greenByte	= (unsigned char) (colorCode >> 8);
    blueByte	= (unsigned char) (colorCode);	// masks off high bits
    result = [UIColor
              colorWithRed:		(float)redByte	/ 0xff
              green:	(float)greenByte/ 0xff
              blue:	(float)blueByte	/ 0xff
              alpha:1.0f];
    return result;
}
+(CGFloat)screenWidth{
    return [UIScreen mainScreen].bounds.size.width;
}

+(CGFloat)screenHeight{
    return [UIScreen mainScreen].bounds.size.height;
}
+ (BOOL)isIOS8OrHigher
{
    float versionNumber = floor(NSFoundationVersionNumber);
    return versionNumber > NSFoundationVersionNumber_iOS_8_0;
}
+(BOOL)validateMobileNumber:(NSString *)mobileNum
{
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@"^(1)[3-9][0-9]\\d{8}$"
                                  options:NSRegularExpressionCaseInsensitive
                                  error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:mobileNum
                                                        options:0
                                                          range:NSMakeRange(0, [mobileNum length])];
    return numberOfMatches > 0;
}

+(BOOL)validateCurrencyNumberStringFormat:(NSString *)moneyAmountString
{
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@"^((\\d*)\\.{0,1})\\d{0,2}$"
                                  options:NSRegularExpressionCaseInsensitive
                                  error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:moneyAmountString
                                                        options:0
                                                          range:NSMakeRange(0, [moneyAmountString length])];
    return numberOfMatches > 0;
}
+(BOOL)validateDigitOrDotString:(NSString *)stringToBeValidated
{
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@"\\d|\\."
                                  options:NSRegularExpressionCaseInsensitive
                                  error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:stringToBeValidated
                                                        options:0
                                                          range:NSMakeRange(0, [stringToBeValidated length])];
    return numberOfMatches > 0 || [stringToBeValidated isEqualToString:@""];
}
+(BOOL)validateIDCardNumberStringFormat:(NSString *)idCardNumberString
{
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@"^(\\d{18,18}|\\d{15,15}|\\d{17,17}(x|X))$"
                                  options:NSRegularExpressionCaseInsensitive
                                  error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:idCardNumberString
                                                        options:0
                                                          range:NSMakeRange(0, [idCardNumberString length])];
    return numberOfMatches > 0;
}
+(BOOL)validateContactPhoneIsMobileNumber:(NSString *)phoneNum;
{
    NSError *error = NULL;
    /**
     1xx-xxxx-xxxx;
     **/
    NSRegularExpression *regexFormat1 = [NSRegularExpression
                                         regularExpressionWithPattern:@"^(1\\d{2})(-|\\s)(\\d{4})(-|\\s)(\\d{4})$"
                                         options:NSRegularExpressionCaseInsensitive
                                         error:&error];
    NSUInteger numberOfMatchesFormat1 = [regexFormat1 numberOfMatchesInString:phoneNum
                                                                      options:0
                                                                        range:NSMakeRange(0, [phoneNum length])];
    /**
     +86 1xx-xxxx-xxxx;
     **/
    NSRegularExpression *regexFormat2 = [NSRegularExpression
                                         regularExpressionWithPattern:@"^(\\+86)(-|\\s)(1\\d{2})(-|\\s)(\\d{4})(-|\\s)(\\d{4})$"
                                         options:NSRegularExpressionCaseInsensitive
                                         error:&error];
    NSUInteger numberOfMatchesFormat2 = [regexFormat2 numberOfMatchesInString:phoneNum
                                                                      options:0
                                                                        range:NSMakeRange(0, [phoneNum length])];
    /*
     1xxxxxxxxxx
     */
    NSRegularExpression *regexFormat3 = [NSRegularExpression
                                         regularExpressionWithPattern:@"^(1)\\d{10}$"
                                         options:NSRegularExpressionCaseInsensitive
                                         error:&error];
    NSUInteger numberOfMatchesFormat3 = [regexFormat3 numberOfMatchesInString:phoneNum
                                                                      options:0
                                                                        range:NSMakeRange(0, [phoneNum length])];
    BOOL contactPhoneIsMobile = numberOfMatchesFormat1 > 0 || numberOfMatchesFormat2 > 0 || numberOfMatchesFormat3 > 0;
    return contactPhoneIsMobile;
}
+(NSString *)trimNonDigitInMobileString:(NSString *)phoneNumString
{
    NSRange foundRange;
    while ((foundRange = [phoneNumString rangeOfString:@"^(\\+86)" options:NSRegularExpressionSearch]).location != NSNotFound)
        phoneNumString = [phoneNumString stringByReplacingCharactersInRange:foundRange withString:@""];
    
    while ((foundRange = [phoneNumString rangeOfString:@"[^0-9]" options:NSRegularExpressionSearch]).location != NSNotFound)
        phoneNumString = [phoneNumString stringByReplacingCharactersInRange:foundRange withString:@""];
    return phoneNumString;
}
+(CGSize)calculateScreenSizeInPixels
{
    float scaleFactor = [[UIScreen mainScreen] scale];
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat widthInPixel = screen.size.width * scaleFactor;
    CGFloat heightInPixel = screen.size.height * scaleFactor;
    CGSize screenPixelsSize = CGSizeMake(widthInPixel, heightInPixel);
    return screenPixelsSize;
}

//后加入的
+ (UIColor *) getColor: (NSString *) hexColor alpha:(CGFloat)alpha
{
    unsigned int red, green, blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:alpha];
}


#pragma mark - Font
+ (float)getTextHeight:(NSString *)text fontSize:(CGFloat)fontSize width:(float)width{
    
    CGSize maxsize = CGSizeMake(width, kCGGlyphMax);
    UIFont *tfont = [UIFont systemFontOfSize:fontSize];
    return [SDDeviceManager getTextSize:text font:tfont size:maxsize].height;
    
}
+ (float)getTextWidth:(NSString*)text FontSize:(CGFloat)fontSize
{
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}];
    
    CGFloat textWidth = size.width ;
    
    return textWidth ;
}
+ (float)getTextHeight:(NSString *)text fontSize:(CGFloat)fontSize width:(float)width lineSpace:(CGFloat)linespace
{
    NSMutableParagraphStyle *paraghStyle =[[NSMutableParagraphStyle alloc] init];
    [paraghStyle setLineSpacing:linespace];
    NSDictionary *attribute =@{NSFontAttributeName:text,NSParagraphStyleAttributeName:paraghStyle};
    CGSize size = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
  
    return size.height;
}
/*
 *  设置行间距和字间距
 *
 *  @param string    字符串
 *  @param lineSpace 行间距
 *  @param kern      字间距
 *  @param font      字体大小
 *
 *  @return 富文本
 */
+ (NSAttributedString *)getAttributedWithString:(NSString *)string WithLineSpace:(CGFloat)lineSpace kern:(CGFloat)kern font:(UIFont *)font{
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    //调整行间距
    paragraphStyle.lineSpacing = lineSpace;
    NSDictionary *attriDict = @{NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@(kern),
                                NSFontAttributeName:font};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:string attributes:attriDict];
    return attributedString;
}

/* 获取富文本的高度
 *
 * @param string    文字
 * @param lineSpace 行间距
 * @param kern      字间距
 * @param font      字体大小
 * @param width     文本宽度
 *
 * @return size
 */
+ (CGFloat)getAttributionHeightWithString:(NSString *)string lineSpace:(CGFloat)lineSpace kern:(CGFloat)kern font:(UIFont *)font width:(CGFloat)width {
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = lineSpace;
    NSDictionary *attriDict = @{
                                NSParagraphStyleAttributeName:paragraphStyle,
                                NSKernAttributeName:@(kern),
                                NSFontAttributeName:font};
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attriDict context:nil].size;
    return size.height;
}

+ (CGSize)getTextSize:(NSString *)text font:(UIFont *)font size:(CGSize)size{
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    if ([SDDeviceManager isIOS8OrHigher]) {
        CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil];
        return rect.size;
    }else{
#ifndef __IPHONE_7_0
        CGSize size =[text sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
        return size;
#endif
    }
    return CGSizeZero;
}
+ (void)callTelephoneNumber:(NSString *)numString
{
    UIDevice *device = [UIDevice currentDevice];
    if ([[device model] isEqualToString:@"iPhone"] ) {
        NSString *urlStr = [NSString stringWithFormat:@"telprompt://%@", numString];
        NSURL *url = [NSURL URLWithString:urlStr];
        [[UIApplication sharedApplication] openURL:url];
    } else {
        UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"提示" message:@"设备不支持此功能" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [Notpermitted show];
    }
}

+ (BOOL)isMobileNumber:(NSString *)mobileNum {
    
    NSString * MOBILE = @"^[1][3456789]\\d{9}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:mobileNum];
}


+ (NSString *)getFirstUrlFromString:(NSString *)searchText {  
    
    NSRange range = [searchText rangeOfString:@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)" options:NSRegularExpressionSearch];  
    if (range.location != NSNotFound) {  
        NSString *url = [searchText substringWithRange:range];  
        if (!([url hasPrefix:@"http://"] || [url hasPrefix:@"https://"])) {  
            url = [@"http://" stringByAppendingString:url];  
        }  
        
        return url;  
    }  
    
    return nil;  
}  


//- (MJRefreshNormalHeader *)refreshWithTarget:(id)target action:(SEL)selector {
//    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:selector];
//    header.lastUpdatedTimeLabel.hidden = YES;
//    return header;
//}


/** 对象转json */
+ (NSString*)JSONStringWithJSONObject:(id)obj
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

/** 时间戳转时间字符串 */ // momo
+ (NSString *)timeStringFromTimeStamp:(NSString *)timeStamp
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
//    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSInteger ts = [timeStamp integerValue];
    NSDate *nowTime = [NSDate dateWithTimeIntervalSince1970:ts];
    NSString *timeStr = [formatter stringFromDate:nowTime];
    return timeStr;
}


/** 时间字符串转时间戳 */ // momo
+ (NSNumber *)TimeStampFromTimeString:(NSString *)dateStr
{
    //时间转时间戳 add by momo
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    NSDate *date = [df dateFromString:dateStr];
    NSTimeInterval interval = [date timeIntervalSince1970];
    
    return @(interval);
}

/** 时间字符串转时间戳 */ // momo
+ (NSNumber *)TimeStampFromTime_String:(NSString *)dateStr
{
    //时间转时间戳 add by momo
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [df dateFromString:dateStr];
    NSTimeInterval interval = [date timeIntervalSince1970];
    
    return @(interval);
}

+ (int)getTimestampNow
{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time=[date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return [timeString intValue];
}

/**物业汉字转单词*/
+(NSString *)wuYeDanCiFromWuYeHanZi:(NSString *)wuYe
{
    if ([wuYe isEqualToString:@"住宅"]) {
        return @"house";
    } else if ([wuYe isEqualToString:@"商业"]) {
        return @"business";
    } else if ([wuYe isEqualToString:@"别墅"]) {
        return @"villa";
    } else if ([wuYe isEqualToString:@"写字楼"]) {
        return @"offices";
    } else if ([wuYe isEqualToString:@"公寓"]) {
        return @"apartment";
    } else if ([wuYe isEqualToString:@"综合楼"]) {
        return @"synthesize";
    } else if ([wuYe isEqualToString:@"企业独栋"]) {
        return @"enterprise";
    } else if ([wuYe isEqualToString:@"经济适用房"]) {
        return @"affordable";
    } else if ([wuYe isEqualToString:@"商铺"]) {
        return @"shop";
    } else
        
        return nil;
    
//    if ([wuYe isEqualToString:@"住宅"]) {
//        return @"house";
//    } else if ([wuYe isEqualToString:@"经济适用房"]) {
//        return @"affordable";
//    } else if ([wuYe isEqualToString:@"别墅"]) {
//        return @"villa";
//    } else if ([wuYe isEqualToString:@"写字楼"]) {
//        return @"offices";
//    } else if ([wuYe isEqualToString:@"商铺"]) {
//        return @"shop";
//    }
//    else if ([wuYe isEqualToString:@"全部"]) {
//        return @"";
//    }
//    
//    else
//        
//        return nil;
}
/** 物业单词转物业汉字 */
+(NSString *)wuYeHanZiFromWuYeDanCi:(NSString *)wuYe
{
//    住宅(house) 商业(business) 别墅(villa) 写字楼(offices) 公寓(apartment) 综合楼(synthesize) 企业独栋(enterprise)  //经济适用房(affordable) 商铺(shop)
    if ([wuYe isEqualToString:@"house"]) {
        return @"住宅";
    } else if ([wuYe isEqualToString:@"business"]) {
        return @"商业";
    } else if ([wuYe isEqualToString:@"villa"]) {
        return @"别墅";
    } else if ([wuYe isEqualToString:@"offices"]) {
        return @"写字楼";
    } else if ([wuYe isEqualToString:@"apartment"]) {
        return @"公寓";
    } else if ([wuYe isEqualToString:@"synthesize"]) {
        return @"综合楼";
    } else if ([wuYe isEqualToString:@"enterprise"]) {
        return @"企业独栋";
    } else if ([wuYe isEqualToString:@"affordable"]) {
        return @"经济适用房";
    } else if ([wuYe isEqualToString:@"shop"]) {
        return @"商铺";
    } else
        
    return nil;
//    if ([wuYe isEqualToString:@"house"]) {
//        return @"住宅";
//    } else if ([wuYe isEqualToString:@"affordable"]) {
//        return @"经济适用房";
//    } else if ([wuYe isEqualToString:@"villa"]) {
//        return @"别墅";
//    } else if ([wuYe isEqualToString:@"offices"]) {
//        return @"写字楼";
//    } else if ([wuYe isEqualToString:@"shop"]) {
//        return @"商铺";
//    } else
//        
//        return nil;
//    
    

}

+(void)writeToFileWithName:(NSString*)str Data:(NSArray*)data
{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, true) firstObject];
    NSString *filePath = [docPath stringByAppendingPathComponent:str];
    [data writeToFile:filePath atomically:true];
    if([data writeToFile:filePath atomically:true])
    {
        RSDLog(@"保存数据成功**");
    }
}

+(NSArray*)getDataFromFileWithName:(NSString*)str
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, true) lastObject];
    NSString *filePath = [cachePath stringByAppendingPathComponent:str];
    NSArray *dataArr = [NSArray arrayWithContentsOfFile:filePath];
    return dataArr;
}

//获取首页cityId
+(NSString*)getCityId
{
//    NSData* data =  SDUserDefaultsGET(kUser_LocationModel) ;
//    RSDLocationCityToolModel * model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//
//    if (model.id.integerValue == 41) { //朝阳区也属于北京
//        return @"1";
//    }
//    if (STATUS0) {
//        return @"1";
//    }
//    if (!model.id) {
//        return @"1";
//    }
//    return [NSString stringWithFormat:@"%@",model.id];
    return nil;
}

//获取gpsID
+(NSString*)getGPSCityId
{
    
    return nil;
}

+ (void)advertTapClickCountType:(NSString *)type andAdvertID:(NSString *)advertId{
//    RSDAdvertCountRequest *request = [[RSDAdvertCountRequest alloc]init];
//    request.type = type;
//    request.act_id = advertId;
//    [[RSDHomeInterfaceService sharedInstance] analyticalHomeData_3500:request serverSuccessResultHandler:^(id response) {
//    } failedResultHandler:^(id response) {
//    } requestErrorHandler:^(id error) {
//    }];
}

//友盟统计
+ (void)UMMobClickEvent:(NSString *)eventId attributes:(NSDictionary *)attributes{
//    [MobClick event:eventId attributes:BROKERID_md5];
    
//    SDMainView *nmView = [[[NSBundle mainBundle] loadNibNamed:@"SDMainView" owner:nil options:nil] firstObject];
//    nmView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
//    nmView.labelTitle.text = eventId;
//    nmView.labelTitle.textAlignment = NSTextAlignmentCenter;
//    nmView.isOnlyOneChoose = YES;
//    [nmView.gotoBtn setTitle:@"确定" forState:UIControlStateNormal];
//    [[UIApplication sharedApplication].keyWindow addSubview:nmView];
}



+ (void)nearAdvertClick {
    
//    if ([RSDRequestParamModel shareInstance].hotNearManId) {
//        [SDDeviceManager advertTapClickCountType:@"nearby" andAdvertID:[NSString stringWithFormat:@"%@",[RSDRequestParamModel shareInstance].hotNearManId]];
//    }
}

@end




















//
//  SDDeviceManager.h
//  Agent
//
//  Created by 七扇门 on 16/1/6.
//  Copyright © 2016年 七扇门. All rights reserved.
//公共功能方法

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UILabel+textOfOnePointNumber.h"

@interface SDDeviceManager : NSObject
//Color
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define CDGrayColor [SDDeviceManager getColor:@"9B9B9B" alpha:1.0]

#define CDGreenColor RGBACOLOR(105, 172, 73, 1)
#define CDELEMEGreenColor RGBACOLOR(67, 213, 81, 1)
#define CDItemGrayColor RGBACOLOR(51, 82, 130 ,1)
//[DeviceManager getColor:@"1AFF00" alpha:1.0]
#define OXCLightGrayColor [DeviceManager getColor:@"E6E6E6" alpha:1.0]
#define WIDTH self.view.bounds.size.width
#define HEIGHT self.view.bounds.size.height
#define GreenColor @"00AF36"
#define SHENGrayColor @"323232"
#define ZHONGGrayColor @"5c6368"
#define QIANGrayColor @"919191"
#define LINEColor @"EEEEEE"
#define iPhone5 [SDDeviceManager isIPhone5]
#define iPhone4s [SDDeviceManager isIPhone4s]

//友盟统计 brokerId md5
#define BROKERID_md5 @{@"broker_id":[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:BROKERUID]].md5String, @"app_version":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]}
/*
 noaudit : 游客
 pending : 经纪人审核中
 audited : 经纪人
 身分证绑定状态(1020接口新增字段 bind_status) : notbind (未绑定身分), binding (绑定身分中), binded(已绑定)
 是否置业顾问(1020接口新增字段 is_counselor) : 0 否, 1 是
 
 */

#define STATUS0 (![SDDeviceManager isStatusNum])

#define STATUS1 ([[SDDeviceManager isStatusNum] isEqualToString:@"noaudit"])

#define STATUS2 ([[SDDeviceManager isStatusNum] isEqualToString:@"audited"])

#define STATUS8 ([[SDDeviceManager isStatusNum] isEqualToString:@"pending"])

#define STATUSCARD1 ([[SDDeviceManager isStatusNumCard] isEqualToString:@"notbind"])

#define STATUSCARD2 ([[SDDeviceManager isStatusNumCard] isEqualToString:@"binded"])

#define STATUSCARD8 ([[SDDeviceManager isStatusNumCard] isEqualToString:@"binding"])

#define SHOWTASK [[NSUserDefaults standardUserDefaults] objectForKey:@"is_show_task"]
//曝光量
#define EXPOSENUMCOUNT @"expose_Num_Count_ofHotPush"
// 曝光量 上传状态
#define EXPOSENUMCOUNT_REQUESTFINISH @"expose_Num_Count_ofHotPush_RequestFinish"

//装修认证状态
#define DEC_STATUS1 ([[SDDeviceManager isDecoratorStatusNum] isEqualToString:@"noaudit"])
#define DEC_STATUS2 ([[SDDeviceManager isDecoratorStatusNum] isEqualToString:@"pending"])
#define DEC_STATUS3 ([[SDDeviceManager isDecoratorStatusNum] isEqualToString:@"audited"])
#define DEC_STATUS4 ([[SDDeviceManager isDecoratorStatusNum] isEqualToString:@"audit_failer"])
//装修身份状态
#define DEC_IDENTOTY1 ([[SDDeviceManager isDecoratorIdentityNum] isEqualToString:@"noidentity"])//无身份
#define DEC_IDENTOTY2 ([[SDDeviceManager isDecoratorIdentityNum] isEqualToString:@"counselor"])//装修顾问
#define DEC_IDENTOTY3 ([[SDDeviceManager isDecoratorIdentityNum] isEqualToString:@"boss"])//超管 老板

//身份切换
#define SWITCH_STATUS0 ([[SDDeviceManager isSwitchStatusNum] isEqualToString:@"switch_agent"])//经纪人switch_agent
#define SWITCH_STATUS1 ([[SDDeviceManager isSwitchStatusNum] isEqualToString:@"switch_deco"]) //装修switch_deco

//登录 切换  认证 弹框
#define LOGIN_SWITCH_AUDID_STATUS(isNeedLogin)  \
if (![SDDeviceManager showLoginSwitchAuthenView:isNeedLogin]) {\
    return;\
}
+(BOOL)showLoginSwitchAuthenView:(BOOL)isNeedLogin;


//判断app切换状态SWITCHSTATUS
+(NSString *)isSwitchStatusNum;

//判断登录返回的装修状态DECORATOR_STATUS
+(NSString *)isDecoratorStatusNum;
+(NSString *)isDecoratorIdentityNum;


//判断登录返回的状态STATUS

+(NSString *)isStatusNum;
+(NSString *)isStatusNumCard;

//判断是否是手机号
+ (BOOL)isMobileNumber:(NSString *)mobileNum;


+(BOOL)isIOS6orLater;
//判断是否是iOS7
+(BOOL)isIOS7orLater;
+(BOOL)isIOS8orLater;
+ (BOOL)isIOS9orLater;
+ (BOOL)isIOS11orLater;

+(BOOL)isIPhone5;
+ (BOOL)isIPhone4s;
+ (BOOL)isIPhone6s;
+(BOOL)isIPhone6;
+(BOOL)isIPhone6p;
+(BOOL)isIPhone5or4;

//返回主屏幕宽度
+(CGFloat)screenWidth;
//返回主屏幕高度
+(CGFloat)screenHeight;

+(UIColor *)colorFromHexRGB:(NSString *)inColorString;

+(BOOL)isIOS8OrHigher;

+(BOOL)validateMobileNumber:(NSString *)mobileNum;

+(BOOL)validateCurrencyNumberStringFormat:(NSString *)moneyAmountString;

+(BOOL)validateDigitOrDotString:(NSString *)stringToBeValidated;

+(BOOL)validateIDCardNumberStringFormat:(NSString *)idCardNumberString;

+(BOOL)validateContactPhoneIsMobileNumber:(NSString *)phoneNum;

+(NSString *)trimNonDigitInMobileString:(NSString *)phoneNumString;

+(CGSize)calculateScreenSizeInPixels;


//后加入的
//Color
+ (UIColor *) getColor: (NSString *) hexColor alpha:(CGFloat)alpha;


+ (float)getTextHeight:(NSString *)text fontSize:(CGFloat)fontSize width:(float)width;

+ (float)getTextHeight:(NSString *)text fontSize:(CGFloat)fontSize width:(float)width lineSpace:(CGFloat)linespace;

+ (float)getTextWidth:(NSString*)text FontSize:(CGFloat)fontSize;

+ (NSAttributedString *)getAttributedWithString:(NSString *)string WithLineSpace:(CGFloat)lineSpace kern:(CGFloat)kern font:(UIFont *)font;

+ (CGFloat)getAttributionHeightWithString:(NSString *)string lineSpace:(CGFloat)lineSpace kern:(CGFloat)kern font:(UIFont *)font width:(CGFloat)width;



// 字符串是否包含url
+ (NSString *)getFirstUrlFromString:(NSString *)searchText;

/**
 *  下拉刷新
 */
//- (MJRefreshNormalHeader *)refreshWithTarget:(id)target action:(SEL)selector;
+ (void)callTelephoneNumber:(NSString *)numString;

/** 对象转json */
+ (NSString*)JSONStringWithJSONObject:(id)obj;

/** 时间戳转时间字符串 */ // momo
+ (NSString *)timeStringFromTimeStamp:(NSString *)timeStamp;

/** 时间字符串转时间戳 */ // momo
+ (NSNumber *)TimeStampFromTimeString:(NSString *)dateStr;
+ (NSNumber *)TimeStampFromTime_String:(NSString *)dateStr;
/** 物业单词转物业汉字 */
+(NSString *)wuYeHanZiFromWuYeDanCi:(NSString *)wuYe;
/** 物业汉字转物业单词 */
+(NSString *)wuYeDanCiFromWuYeHanZi:(NSString *)wuYe;

+(int)getTimestampNow;

+(void)writeToFileWithName:(NSString*)str Data:(NSArray*)data;

+(NSArray*)getDataFromFileWithName:(NSString*)str ;

//获取首页cityId
+(NSString*)getCityId;
//获取gpsID
+(NSString*)getGPSCityId;

//广告点击统计
+ (void)advertTapClickCountType:(NSString *)type andAdvertID:(NSString *)advertId;

//友盟统计
+ (void)UMMobClickEvent:(NSString *)eventId attributes:(NSDictionary *)attributes;

//曝光量
+ (void)exposeNumCountAnalytical;

//附近经纪人广告点击统计
+ (void)nearAdvertClick;

@end

//
//  KLine.h
//  Biconome
//
//  Created by 车林 on 2019/8/6.
//  Copyright © 2019年 qsm. All rights reserved.
//

#ifndef KLine_h
#define KLine_h

#import <SocketRocket.h>
#import "MJExtension.h"
#import "FDNetworkHelper.h"
#import "CommonMethod.h"
#import "UIView+Extension.h"
#import "UIView+ExtensionOther.h"
#import "UIButton+ImageTitleSpacing.h"
#import "NSString+WH.h"
#import "UILabel+TextSpace.h"
#import "UIButton+WHButton.h"
#import "Util.h"

#define URL_pushMain @"ws://43.231.184.237:8004"

#define KBICURL_pushMain @"ws://39.100.122.157:"
//#define KBICURL_pushMain @"ws://192.168.0.139:"

#define kApplication        [UIApplication sharedApplication]
#define kAppWindow          [UIApplication sharedApplication].delegate.window
#define kAppDelegate        [AppDelegate shareAppDelegate]

//#define BTLanguage(text) NSLocalizedString(text, nil)
#define BTLanguage(text) LAN(text)
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define RGB(r,g,b) RGBA(r, g, b, 1)
#define DEFAULT_FONT_NAME @"PingFangSC-Regular"
#define FONT_WITH_SIZE(fontSize) [UIFont fontWithName:DEFAULT_FONT_NAME size:(fontSize)]
#define BOLDSYSTEMFONT(FONTSIZE)[UIFont boldSystemFontOfSize:FONTSIZE]
#define IMAGE_NAMED(name) [UIImage imageNamed:name]
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define SafeAreaTopHeight ((KScreenHeight >= 812.0) && [[UIDevice currentDevice].model isEqualToString:@"iPhone"] ? 24 : 0)
#define SafeAreaBottomHeight ((KScreenHeight >= 812.0) && [[UIDevice currentDevice].model isEqualToString:@"iPhone"]  ? 34 : 0)
#define SafeKLineBottomHeight ((KScreenHeight >= 812.0) && [[UIDevice currentDevice].model isEqualToString:@"iPhone"]  ? 15 : 0)
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define kTopHeight (kStatusBarHeight + kNavBarHeight)

//获取屏幕宽高
#define KScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define KScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreen_Bounds [UIScreen mainScreen].bounds

//强弱引用
#define kWeakSelf(type)  __weak typeof(type) weak##type = type;
#define kStrongSelf(type) __strong typeof(type) type = weak##type;

//拼接字符串
#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]

#define HexRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define HexRGBA(rgbValue,alp) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:alp]
#endif /* KLine_h */

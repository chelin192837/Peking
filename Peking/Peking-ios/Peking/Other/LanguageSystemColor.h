//
//  LanguageSystemColor.h
//  Biconome
//
//  Created by 车林 on 2019/8/15.
//  Copyright © 2019年 qsm. All rights reserved.
//

#ifndef LanguageSystemColor_h
#define LanguageSystemColor_h

//历史记录宏
#define kHistoryName @"kHistoryName"

//首页缓存的设置
#define kHomePageSystemImage @"kHomePageSystemImage"
#define kHomePageNoticeList @"kHomePageNoticeList"
#define kHomePageHomeList @"kHomePageHomeList"
#define kHomePageZhaList @"kHomePageZhaList"
#define BICHomeRefreshSortBy_One @"BICHomeRefreshSortBy_One"
#define BICHomeRefreshSortBy_Two @"BICHomeRefreshSortBy_Two"

//通知
#define NSNotificationCenterPriceType @"NSNotificationCenterPriceType"
#define NSNotificationCenterEXCBannerConstent @"NSNotificationCenterEXCBannerConstent"
#define NSNotificationCenterEXCBottomToNav @"NSNotificationCenterEXCBottomToNav"
#define NSNotificationCenterCoinTransactionPair @"NSNotificationCenterCoinTransactionPair"
#define NSNotificationCenterCoinTransactionPairNav @"NSNotificationCenterCoinTransactionPairNav"
#define NSNotificationCenterBICChangeSocketView @"NSNotificationCenterBICChangeSocketView"
#define NSNotificationCenterProfileHeader @"NSNotificationCenterProfileHeader"
#define NSNotificationCenterBICChangePriceConfig @"NSNotificationCenterBICChangePriceConfig"
#define NSNotificationCenterBICWalletList @"NSNotificationCenterBICWalletList"
#define NSNotificationCenterBICWalletHideBalance @"NSNotificationCenterBICWalletHideBalance"
//当前委托通知
#define NSNotificationCenterCurrentEntrust @"NSNotificationCenterCurrentEntrust"

#define NSNotificationCenterkLinePushIMP @"NSNotificationCenterkLinePushIMP"
#define NSNotificationCenterkLinePushIMPMarket @"NSNotificationCenterkLinePushIMPMarket"

#define NSNotificationCenterLoginSucceed @"NSNotificationCenterLoginSucceed"
#define NSNotificationCenterLoginOut @"NSNotificationCenterLoginOut"
#define NSNotificationCenterBindGoogleSucceed @"NSNotificationCenterBindGoogleSucceed"

#define NSNotificationCenterSelectToExchangeIndex @"NSNotificationCenterSelectToExchangeIndex"

#define NSNotificationCenterSelectCoinToDrawRecharge @"NSNotificationCenterSelectCoinToDrawRecharge"
#define NSNotificationCenterWithDrawBackRefWeb @"NSNotificationCenterWithDrawBackRefWeb"
#define NSNotificationCenterHorLineToChangePrice @"NSNotificationCenterHorLineToChangePrice"

#define NSNotificationCenterCurrentDelegateNotify @"NSNotificationCenterCurrentDelegateNotify"

#define NSNotificationCenterBICRateConfig @"NSNotificationCenterBICRateConfig"
#define BICRateConfigType @"BICRateConfigType"
#define BICSexConfigType @"BICSexConfigType"
#define BICCardConfigType @"BICCardConfigType"

#define NSNotificationCenterMarketGet @"NSNotificationCenterMarketGet"
#define NSNotificationCenterOpenOrdersToAll @"NSNotificationCenterOpenOrdersToAll"
#define NSNotificationCenterExchangeScrollerToNav @"NSNotificationCenterExchangeScrollerToNav"

//交易页面缓存设置
#define BICEXCPCListUserPublishType @"BICEXCPCListUserPublishType"
#define BICEXCPCListUserOrderType @"BICEXCPCListUserOrderType"

//交易对
#define BICEXCChangeCoinPair @"BICEXCChangeCoinPair"

#define kBTCImageIcon [UIImage imageNamed:@"btc"]

///Sock ----- 相关通知 ---
//更新钱包
#define NSNotificationCenterWallectUpdate @"NSNotificationCenterWallectUpdate"

//行情
#define NSNotificationCenteSockJSTopicMarket @"NSNotificationCenteSockJSTopicMarket"

//盘口
#define NSNotificationCenteSockJSTopicSubscription @"NSNotificationCenteSockJSTopicSubscription"

//历史成交记录
#define NSNotificationCenteSockJSTopicHistory @"NSNotificationCenteSockJSTopicHistory"



//更新主k线图的reloadFlag
#define NSNotificationCenteSockJSReloadFlag @"NSNotificationCenteSockJSReloadFlag"
//添加，取消收藏
#define NSNotificationCenterBICCancelCollection @"NSNotificationCenterBICCancelCollection"

////内置核心缓存
/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////

//美元对人民币汇率
#define BICUSDTYANG @"BICUSDTYANG"
//BTC对美元汇率
#define BICBTCTOUSDT @"BICBTCTOUSDT"
//我的钱包BTC估值
#define BICWalletBtcValue @"BICWalletBtcValue"
//我的钱包列表
#define BICWALLETLISTOFMINE @"BICWALLETLISTOFMINE"

//当前委托信息
#define BICCURRENTENTRUSTMESS @"BICCURRENTENTRUSTMESS"
//当前盘口信息
#define BICCURRENPOSITIONMESS @"BICCURRENPOSITIONMESS"
//当前请求交易对最新信息
#define BICCURRENTRSACTIONMESS @"BICCURRENTRSACTIONMESS"
//请求币对配置信息
#define BICCURRCONFIGMESS @"BICCURRCONFIGMESS"

///////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////


//基本汇率


#define kADDNSNotificationCenter(key1) [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notify:) name:key1 object:nil]

#define kPOSTNSNotificationCenter(key1,key2) [[NSNotificationCenter defaultCenter] postNotificationName:key1 object:key2]

//多语言设置
#define LAN(key) [BICDeviceManager getLanguage:key]

//千分位设置
#define NumFormat(key) [BICDeviceManager changeNumberFormatter:key]


#define NSNotificationCenterUpdateUI @"NSNotificationCenterUpdateUI"
#define NSNotificationCenterGAINER @"NSNotificationCenterGAINER"
#define NSNotificationCenterVOLUMETOP @"NSNotificationCenterVOLUMETOP"

#define NSNotificationCenterScrollToView @"NSNotificationCenterScrollToView"

#define LanguageIsChinese [BICDeviceManager languageIsChinese]

#define AppdelegateEnterForeground @"AppdelegateEnterForeground"

//切换背景颜色时,文字颜色切换

//控件背景颜色

//圆角

#define kBICCornerRadius 4.f

#define kBICMargin 16.f

#define kBICMainBGColor [UIColor colorWithHexColorString:@"6653FF"]

//判断系统语言
#define CURR_LANG ([[NSLocale preferredLanguages] objectAtIndex:0])

#define LanguageIsEnglish ([CURR_LANG isEqualToString:@"en-US"] || [CURR_LANG isEqualToString:@"en-CA"] || [CURR_LANG isEqualToString:@"en-GB"] || [CURR_LANG isEqualToString:@"en-CN"] || [CURR_LANG isEqualToString:@"en"])

#define INTERNATIONCODE @"internationalCode"

#define kBICSYSTEMBGColor [UIColor colorWithHexColorString:@"6653FF"]
#define kBICSYSTETitleColor [UIColor colorWithHexColorString:@"6653FF"]

#define kNVABICSYSTEMBGColor [UIColor colorWithHexColorString:@"FFFFFF"]

#define kNVABICSYSTEMTitleColor [UIColor colorWithHexColorString:@"33353B"]

#define kBoardTextColor [UIColor colorWithHexColorString:@"64666C"]

#define kBICWhiteColor [UIColor whiteColor]

#define kBICHomeBGColor [UIColor colorFromHexRGB:@"EEF0F6"]
//主背景
#define kBICMainListBGColor [UIColor colorFromHexRGB:@"F3F5FB"]

//首页中间接口
#define kBICGetHomeTitleColor [UIColor colorFromHexRGB:@"33353B"]
#define kBICGetHomeAmountColor [UIColor colorFromHexRGB:@"64666C"]
#define kBICGetHomePriceColor [UIColor colorFromHexRGB:@"95979D"]
#define kBICGetHomePercentGColor [UIColor colorFromHexRGB:@"00CC66"]
#define kBICGetHomePercentRColor [UIColor colorFromHexRGB:@"FF3366"]

#define kBICGetHomePercentBGRColor [UIColor colorFromHexRGB:@"FF3366"]
#define kBICGetHomePercentBGGColor [UIColor colorFromHexRGB:@"00CC66"]



#define kBICGetHomeZhRColor [UIColor colorFromHexRGB:@"333333"]
#define kBICGetHomeCHRColor [UIColor colorFromHexRGB:@"64666C"]

#define kBICGetHomeBtcKindColor [UIColor colorFromHexRGB:@"95979D"]

#define kBICGetHomeCellTitleColor [UIColor colorFromHexRGB:@"33353B"]
#define kBICGetHomeCellLastPriceColor [UIColor colorFromHexRGB:@"33353B"]
#define kBICGetHomeCellAmountColor [UIColor colorFromHexRGB:@"64666C"]
#define kBICGetHomeCellPriceColor [UIColor colorFromHexRGB:@"64666C"]

//涨跌幅按钮颜色
#define kBICGetHomeCellBtnRColor [UIColor colorFromHexRGB:@"FF3366"]
#define kBICGetHomeCellBtnGColor [UIColor colorFromHexRGB:@"00CC99"]



//行情
#define kBICHistoryTitleColor [UIColor colorFromHexRGB:@"64666C"]
#define kBICHistoryCellBGColor [UIColor colorFromHexRGB:@"F3F5FB"]

#define kBICTitleTextColor [UIColor colorFromHexRGB:@"33353B"]

//交易
#define kBICSaleBorderColor [UIColor colorFromHexRGB:@"C6C8CE"]


#define kBICSaleBgColor [UIColor colorFromHexRGB:@"00CC99"]
#define kBICBuyBgColor [UIColor colorFromHexRGB:@"FF3366"]

#define kBICExcProTextColor [UIColor colorFromHexRGB:@"1B1D23"]
#define kBICExcProCicleColor [UIColor colorFromHexRGB:@"00E72C"]

//个人中心
#define kBICNoBindColor [UIColor colorFromHexRGB:@"FF9822"]
#define kBICBindedColor [UIColor colorFromHexRGB:@"00CC99"]

//
#define BICHomeRefresh @"BICHomeRefresh"
#define BICHomeRefreshBack @"BICHomeRefreshBack"

#define BICHomeRefreshSortBy @"BICHomeRefreshsortBy"

#define BICMarketRefreshByBtcKind @"BICMarketRefreshByBtcKind"

#endif /* LanguageSystemColor_h */

//
//  BICDeviceManager.h
//  Biconome
//
//  Created by 车林 on 2019/8/15.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICDeviceManager : NSObject

//获取不同版本的语言
+(NSString*)getLanguage:(NSString*)string;

+(void)AlertShowTip:(NSString*)string;

//密码验证
+(BOOL)passwordVertify:(NSString*)string;

+(NSString *)isOrNoPasswordStyle:(NSString *)passWordName;

+(void)addDottedBorderWithView:(UIView*)view;

+(BOOL)deptNumInputShouldNumber:(NSString*)text;

+(BOOL)languageIsChinese;

+(NSString*)getLanguageCurrencyStr;

+(float)getRandomNumber:(int)from to:(int)to;

//当前币
+(NSString*)GetPairCoinName;
//基本币
+(NSString*)GetPairUnitName;

+(float)GetUSDTToYuan;

+(float)GetBICToUSDT;

//获取我的钱包列表
+(NSArray*)GetWalletList;

//获取我的钱包的BTC估值
+(double)GetWalletBtcValue;

//获取当前制定币种的个数
+(double)GetCoinCount:(NSString*)coin;

//复制
+(void)pasteboard:(NSString*)str;

//获取当前汇率类型。CNY USD 
+(NSString*)getCurrentRate;

//判断是否登录
+(BOOL)isLogin;

+(void)PushToLoginView;

//数字千分位
+(NSString*)countNumAndChangeformat:(NSString*)num;

+(NSString*)changeNumberFormatter:(NSString*)str;

+ (NSString *)addComma:(id)str;

+(NSString*)getCurrentSex;
+(NSString*)getCurrentCardType;
+(NSString*)changeFormatter:(NSString *)str  length:(NSInteger)length;
+ (void)quickSortArray:(NSMutableArray *)array withLeftIndex:(NSInteger)leftIndex andRightIndex:(NSInteger)rightIndex;
@end

NS_ASSUME_NONNULL_END


//
//  BICSockJSRouter.h
//  Biconome
//
//  Created by 车林 on 2019/9/19.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Y_KLineGroupModel,Y_KLineModel;

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,SockJS_Type)
{
    SockJS_Type_Market = 99, // 行情
    SockJS_Type_BuySellClient, //盘口
    SockJS_Type_History, //历史成交记录
    SockJS_Type_KLine, //k线
    SockJS_Type_TopicGainer, //涨跌幅
    SockJS_Type_TopicVolumeTop, //成交额
    SockJS_Type_CurrentEntrust,//当前委托
};
typedef void(^KLineArrayBlock)(Y_KLineModel *lineModel,NSString *type);
@interface BICSockJSRouter : NSObject

+(instancetype)shareInstance;

@property(nonatomic,copy)KLineArrayBlock kLineBlock;

-(void)SockJSStartSockJS_Type:(SockJS_Type)sockJsType CurrencyPair:(NSString*)currencyPair ForParameter:(NSString *)parameter;

-(void)SockJSStopSockJS_Type:(SockJS_Type)sockJsType;

-(void)didNotConnetedSockJS_Type:(SockJS_Type)sockJsType;

-(void)SockJSGlobeStart;

-(void)SockJSGlobeStop;

-(void)SockJSGlobeReStart;
//当前委托
-(void)SockJSCurrentEntrustStart;
//k线单独处理
-(void)SockJSKLineStartSockJS_Type:(SockJS_Type)sockJsType
                      CurrencyPair:(NSString*)currencyPair
                           ForType:(NSString *)type
                   KLineArrayBlock:(KLineArrayBlock)kLineBlock;


-(void)SockJSKLineStop;

@end

NS_ASSUME_NONNULL_END

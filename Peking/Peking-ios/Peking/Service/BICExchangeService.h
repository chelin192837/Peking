//
//  BICExchangeService.h
//  Biconome
//
//  Created by 车林 on 2019/8/24.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSDBaseService.h"
#import "BICBaseRequest.h"

#import "BICListUserRequest.h"
#import "BICListUserResponse.h"
#import "BICOrderCancelRequest.h"
#import "BICLimitMarketRequest.h"
#import "BICKLineRequest.h"


NS_ASSUME_NONNULL_BEGIN

@interface BICExchangeService : RSDBaseService

+ (instancetype)sharedInstance;

//当前委托接口
- (void)analyticalPCListUserOrderData:(BICListUserRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;

//历史委托接口 8501/detail/pcListUserDetail
- (void)analyticalPcListUserDetailData:(BICListUserRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;

//接口 8501/order/cancel 撤销当前委托
- (void)analyticalOrderCancelData:(BICOrderCancelRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
//接口 8501/order/cancelAll 撤销当前所有委托
- (void)analyticalOrderCancelAllData:(BICOrderCancelRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;

//发布限价买单 8501/order/limitBuy
- (void)analyticalOrderLimitBuyData:(BICLimitMarketRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
//发布市价买单 /8501/order/marketBuy
- (void)analyticalOrderMarketBuyData:(BICLimitMarketRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
//发布限价卖单 8501/order/limitSell
- (void)analyticalOrderLimitSellData:(BICLimitMarketRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
//发布市价卖单 8501/order/marketSell
- (void)analyticalOrderMarketSellData:(BICLimitMarketRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;

//发布止盈止损卖单
//8510/order/stopSell
- (void)analyticalOrderStopSellData:(BICLimitMarketRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
//发布止盈止损买单
//8501/order/stopBuy
- (void)analyticalOrderStopBuyData:(BICLimitMarketRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;

//查询盘口卖单、买单 8501/order/listOrderByCoinAndUnit
- (void)analyticalListOrderByCoinAndUnitData:(BICLimitMarketRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;

//k线图 8601/market/query
- (void)analyticalMarketQueryData:(BICKLineRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;

//8601 /markey/getHistoryList
- (void)analyticalGetHistoryListData:(BICKLineRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;

//8601 选择交易对触发事件 8601/market/get
- (void)analyticalMarketGetData:(BICKLineRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
//8501/coin/getCoinByCurrencyPair
//查询币对的配置信息
- (void)analyticalGetCoinByCurrencyPairData:(BICLimitMarketRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;

//新---下单 "URL8501"cct/order/publishOrder
- (void)analyticalNewOrderData:(BICLimitMarketRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
@end

NS_ASSUME_NONNULL_END

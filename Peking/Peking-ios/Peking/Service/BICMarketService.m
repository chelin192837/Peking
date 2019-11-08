//
//  BICMarketService.m
//  Biconome
//
//  Created by 车林 on 2019/8/21.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICMarketService.h"

@implementation BICMarketService

static id sharedInstance = nil;
+ (id)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

//行情接口
- (void)analyticalgetQuoteCurrencyData:(BICBaseRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8601"/currency/getQuoteCurrency";
    [self doServerRequestWithModel:request ResponseName:@"BICMainCurrencyResponse" Url:urlStr requestType:HttpRequestTypeGet serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}

- (void)analyticalSearchCurrencyData:(BICSearchCurrencyRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8601"/currency/getCurrencyPairByCoin";
    [self doServerRequestWithModel:request ResponseName:@"BICMainCurrencyResponse" Url:urlStr requestType:HttpRequestTypeGet serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
- (void)analyticalgetTopListPageData:(BICSearchCurrencyRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8601"/market/getTopListPage";
    [self doServerRequestWithModel:request ResponseName:@"BICTopListPageResponse" Url:urlStr requestType:HttpRequestTypeGet serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
//market/getTopListPage
//查询收藏币对行情
//"URL8601"/collection/getCollectionCurrency
- (void)analyticaGetCollectionCurrencyData:(BICGetTopListRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8601"/collection/getCollectionCurrency";
    [self doServerRequestWithModel:request ResponseName:@"BICTopListPageResponse" Url:urlStr requestType:HttpRequestTypeGet serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}

@end

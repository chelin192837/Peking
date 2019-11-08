//
//  BICMarketService.h
//  Biconome
//
//  Created by 车林 on 2019/8/21.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSDBaseService.h"
#import "BICBaseRequest.h"

#import "BICSearchCurrencyRequest.h"

#import "BICGetTopListRequest.h"


NS_ASSUME_NONNULL_BEGIN


@interface BICMarketService : RSDBaseService

+ (instancetype)sharedInstance;

//行情接口 
- (void)analyticalgetQuoteCurrencyData:(BICBaseRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;

- (void)analyticalSearchCurrencyData:(BICSearchCurrencyRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;

- (void)analyticalgetTopListPageData:(BICGetTopListRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
//market/getTopListPage
//查询收藏币对行情
//8601/collection/getCollectionCurrency
- (void)analyticaGetCollectionCurrencyData:(BICGetTopListRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;



@end

NS_ASSUME_NONNULL_END

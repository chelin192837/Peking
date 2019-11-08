//
//  BICMainService.h
//  Biconome
//
//  Created by 车林 on 2019/8/3.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSDBaseService.h"
#import "BICBaseRequest.h"

#import "BICSystemImageResponse.h"

#import "BICGetTopListRequest.h"
#import "BICGetTopListResponse.h"
#import "BICVersionRequest.h"
#import "BICKLineRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface BICMainService : RSDBaseService
+ (instancetype)sharedInstance;

//轮播图接口
- (void)analyticalSystemImageListData:(BICBaseRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;

//公告接口 
- (void)analyticalSystemNoticeListData:(BICBaseRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;

//涨跌幅接口
- (void)analyticalGetTopListData:(BICGetTopListRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;

//首页中部接口
- (void)analyticalGetHomeListData:(BICGetTopListRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;

//添加收藏币对
//8601/collection/addCollectionCurrency
- (void)analyticalAddCollectionCurrencyData:(BICKLineRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
//取消币对收藏
//8601/collection/cancelCollectionCurrency
//请求方式：POST
- (void)analyticalCancelCollectionCurrencyData:(BICKLineRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
- (void)analyticalAppStoreVersionData:(BICBaseRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
- (void)analyticalNewVersionData:(BICVersionRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
@end

NS_ASSUME_NONNULL_END

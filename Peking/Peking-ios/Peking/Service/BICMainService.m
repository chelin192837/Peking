//
//  BICBICMainService.m
//  Biconome
//
//  Created by 车林 on 2019/8/3.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICMainService.h"
#import "BICVersionRequest.h"
@implementation BICMainService

static id sharedInstance = nil;
+ (id)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

//轮播图接口
- (void)analyticalSystemImageListData:(BICBaseRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8121"/systemImage/systemImageList";
    [self doServerRequestWithModel:request ResponseName:@"BICSystemImageResponse" Url:urlStr requestType:HttpRequestTypeGet serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}

//公告接口 systemNotice/systemNoticeList
- (void)analyticalSystemNoticeListData:(BICBaseRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8121"/systemNotice/systemNoticeList";
    [self doServerRequestWithModel:request ResponseName:@"BICSystemImageResponse" Url:urlStr requestType:HttpRequestTypeGet serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}

//涨跌幅接口
- (void)analyticalGetTopListData:(BICGetTopListRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8601"/market/getTopList";
    [self doServerRequestWithModel:request ResponseName:@"BICGetTopListResponse" Url:urlStr requestType:HttpRequestTypeGet serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
//首页中部接口
- (void)analyticalGetHomeListData:(BICGetTopListRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8601"/market/getHomeList";
    [self doServerRequestWithModel:request ResponseName:@"BICGetTopListResponse" Url:urlStr requestType:HttpRequestTypeGet serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}

//添加收藏币对
//"URL8601"/collection/addCollectionCurrency
- (void)analyticalAddCollectionCurrencyData:(BICGetTopListRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8601"/collection/addCollectionCurrency";
    [self doServerRequestWithModel:request ResponseName:@"BICBaseResponse" Url:urlStr requestType:HttpRequestTypePost serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
//取消币对收藏
//"URL8601"/collection/cancelCollectionCurrency
//请求方式：POST
- (void)analyticalCancelCollectionCurrencyData:(BICGetTopListRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    {
        NSString *urlStr = @""kBaseUrl""URL8601"/collection/cancelCollectionCurrency";
        [self doServerRequestWithModel:request ResponseName:@"BICBaseResponse" Url:urlStr requestType:HttpRequestTypePost serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
    }
}
//请求appstore version
- (void)analyticalAppStoreVersionData:(BICBaseRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr=[NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@&temp=%u",@"1168549212",arc4random()];
    [self doCommonServerRequestWithModel:request Url:urlStr serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
//根据设备类型获取最新app版本信息
- (void)analyticalNewVersionData:(BICVersionRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    {
        NSString *urlStr = @""kBaseUrl""URL8121"/version/findNewVersion";
        [self doServerRequestWithModel:request ResponseName:@"BICAppStoreResponse" Url:urlStr requestType:HttpRequestTypeGet serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
    }
}
@end

//
//  BICWalletService.m
//  Biconome
//
//  Created by 车林 on 2019/8/30.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICWalletService.h"

@implementation BICWalletService

static id sharedInstance = nil;

+ (id)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

//当前接口接口获取btc钱包资产
//8301/wallet/getWallets
- (void)analyticalWalletUsergetWalletsData:(BICListUserRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8301"/wallet/getWallets";
    [self doServerRequestWithModel:request ResponseName:@"BICGetWalletsResponse" Url:urlStr requestType:HttpRequestTypeGet serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
//新-获取资产
- (void)analyticalWalletUsergetWalletsNewData:(BICGetWalletsRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8101"/wallet/getWallets";
    [self doServerRequestWithModel:request ResponseName:@"BICGetWalletsResponse" Url:urlStr requestType:HttpRequestTypeGet serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
- (void)analyticalWalletUsergetWallets8201Data:(BICGetWalletsRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8201"/wallet/getWallets";
    [self doServerRequestWithModel:request ResponseName:@"BICGetWalletsResponse" Url:urlStr requestType:HttpRequestTypeGet serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
//"URL8501"/order/pcGetTransferInOut
- (void)analyticalPcGetTransferInOutData:(BICpcGetTransferInOutRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8501"/order/pcGetTransferInOut";
    [self doServerRequestWithModel:request ResponseName:@"BICpcGetTransferInOutResponse" Url:urlStr requestType:HttpRequestTypeGet serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
//"URL8601"/currency/getCurrencyConfig 查询币种是否允许充值、提现、是否需要备注
- (void)analyticalGetCurrencyConfigData:(BICGetCurrencyConfigRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8601"/currency/getCurrencyConfig";
    [self doServerRequestWithModel:request ResponseName:@"BICGetCurrencyConfigResponse" Url:urlStr requestType:HttpRequestTypeGet serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
//8301/walletParam/getGasConfig
- (void)analyticalGetGasConfigData:(BICGetCurrencyConfigRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8301"/walletParam/getGasConfig";
    [self doServerRequestWithModel:request ResponseName:@"BICGetGasConfigResponse" Url:urlStr requestType:HttpRequestTypeGet serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
//新：获取币种对应手续费，最小提币额度
- (void)analyticalNewGetGasConfigData:(BICGetCurrencyConfigRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8101"/wallet/getGasConfig";
    [self doServerRequestWithModel:request ResponseName:@"BICGetGasConfigResponse" Url:urlStr requestType:HttpRequestTypeGet serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
//8201/walletParam/getGasConfig
- (void)analyticalGetGasConfig8201Data:(BICGetCurrencyConfigRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8201"/walletParam/getGasConfig";
    [self doServerRequestWithModel:request ResponseName:@"BICGetGasConfigResponse" Url:urlStr requestType:HttpRequestTypeGet serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
//"URL8601"/market/getOutQuota #import "BICGetOutQuotaResponse.h"
- (void)analyticalGetOutQuotaData:(BICBaseRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8601"/market/getOutQuota";
    [self doServerRequestWithModel:request ResponseName:@"BICGetOutQuotaResponse" Url:urlStr requestType:HttpRequestTypeGet serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
//新提币
- (void)analyticalWithdrawAllType:(BICWalletTransferRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8101"/wallet/withdraw";
    [self doServerRequestWithModel:request ResponseName:@"BICGetWalletsResponse" Url:urlStr requestType:HttpRequestTypePost serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}

//8201/wallet/withdrawDeposit   ETH
- (void)analyticalWithdrawDepositData:(BICBaseRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8201"/wallet/withdrawDeposit";
    [self doServerRequestWithModel:request ResponseName:@"BICBaseResponse" Url:urlStr requestType:HttpRequestTypePost serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
//8301/walletTransfer/withdraw  BTC
- (void)analyticalWalletTransferWithdrawData:(BICBaseRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8301"/walletTransfer/withdraw";
    [self doServerRequestWithModel:request ResponseName:@"BICBaseResponse" Url:urlStr requestType:HttpRequestTypePost serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
//取消提币
- (void)analyticalWalletCancelWithdrawData:(BICWalletTransferRequest *)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8101"/wallet/cancelWithdraw";
    [self doServerRequestWithModel:request ResponseName:@"BICBaseResponse" Url:urlStr requestType:HttpRequestTypePost serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}

@end

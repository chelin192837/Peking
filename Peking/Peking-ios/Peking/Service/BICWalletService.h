//
//  BICWalletService.h
//  Biconome
//
//  Created by 车林 on 2019/8/30.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSDBaseService.h"
#import "BICBaseRequest.h"

#import "BICGetWalletsRequest.h"

#import "BICpcGetTransferInOutRequest.h"

#import "BICGetCurrencyConfigRequest.h"

#import "BICWalletTransferRequest.h"
NS_ASSUME_NONNULL_BEGIN

@interface BICWalletService : RSDBaseService
+ (instancetype)sharedInstance;

//当前接口接口获取btc钱包资产
//8301/wallet/getWallets
- (void)analyticalWalletUsergetWalletsData:(BICGetWalletsRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
//新-获取资产
- (void)analyticalWalletUsergetWalletsNewData:(BICGetWalletsRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
//8201/wallet/getWallets
- (void)analyticalWalletUsergetWallets8201Data:(BICGetWalletsRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
//8501/order/pcGetTransferInOut
- (void)analyticalPcGetTransferInOutData:(BICpcGetTransferInOutRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
//8601/currency/getCurrencyConfig
- (void)analyticalGetCurrencyConfigData:(BICGetCurrencyConfigRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
//8301/walletParam/getGasConfig
- (void)analyticalGetGasConfigData:(BICGetCurrencyConfigRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
//8201/walletParam/getGasConfig
- (void)analyticalGetGasConfig8201Data:(BICGetCurrencyConfigRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
//8601/market/getOutQuota
- (void)analyticalGetOutQuotaData:(BICBaseRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;

//8201/wallet/withdrawDeposit   ETH
- (void)analyticalWithdrawDepositData:(BICWalletTransferRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
//8301/walletTransfer/withdraw  BTC
- (void)analyticalWalletTransferWithdrawData:(BICWalletTransferRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
//新提币
- (void)analyticalWithdrawAllType:(BICWalletTransferRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
//新：获取币种对应手续费，最小提币额度
- (void)analyticalNewGetGasConfigData:(BICGetCurrencyConfigRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
//取消提币
- (void)analyticalWalletCancelWithdrawData:(BICWalletTransferRequest *)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
@end

NS_ASSUME_NONNULL_END

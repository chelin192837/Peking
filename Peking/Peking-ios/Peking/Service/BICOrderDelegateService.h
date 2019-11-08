//
//  BICOrderDelegateService.h
//  Biconome
//
//  Created by 车林 on 2019/8/29.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RSDBaseService.h"
#import "BICBaseRequest.h"

#import "BICDealListByUserRequest.h"
#import "BICListDetailByOrderIdRequest.h"


NS_ASSUME_NONNULL_BEGIN

@interface BICOrderDelegateService : RSDBaseService

+ (instancetype)sharedInstance;

//成交记录 8501/detail/dealListByUser
- (void)analyticalDealListByUserData:(BICDealListByUserRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
//成交记录详情 8501/detail/listDetailByOrderId
- (void)analyticalListDetailByOrderId:(BICListDetailByOrderIdRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;


@end

NS_ASSUME_NONNULL_END

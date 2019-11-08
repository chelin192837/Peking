//
//  BICOrderDelegateService.m
//  Biconome
//
//  Created by 车林 on 2019/8/29.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICOrderDelegateService.h"

@implementation BICOrderDelegateService
static id sharedInstance = nil;

+ (id)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

//成交记录 "URL8501"/detail/dealListByUser
- (void)analyticalDealListByUserData:(BICDealListByUserRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8501"/detail/dealListByUser";
    [self doServerRequestWithModel:request ResponseName:@"BICDealListByUserResponse" Url:urlStr requestType:HttpRequestTypeGet serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
//成交记录详情 "URL8501"/detail/listDetailByOrderId
- (void)analyticalListDetailByOrderId:(BICListDetailByOrderIdRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8501"/detail/listDetailByOrderId";
    [self doServerRequestWithModel:request ResponseName:@"BICListDetailByOrderIdResponse" Url:urlStr requestType:HttpRequestTypeGet serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
@end

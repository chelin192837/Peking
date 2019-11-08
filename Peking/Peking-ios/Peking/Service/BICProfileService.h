//
//  BICProfileService.h
//  Biconome
//
//  Created by 车林 on 2019/8/12.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSDBaseService.h"
#import "BICBaseRequest.h"
#import "BICRegisterRequest.h"
#import "BICBindGoogleRequest.h"
#import "BICAuthInfoRequest.h"
#import "BICPageRequest.h"
NS_ASSUME_NONNULL_BEGIN

@interface BICProfileService : RSDBaseService

+ (instancetype)sharedInstance;

//注册
- (void)analyticalRegisterData:(BICRegisterRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
//登陆密码接口
- (void)analyticalPasswordData:(BICRegisterRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
//忘记密码接口 login/tel
- (void)analyticalLoginTelData:(BICRegisterRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;

//登陆验证码接口
- (void)analyticalLoginByCodeData:(BICRegisterRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;

//获取验证码
- (void)analyticalSendRegisterCodeData:(BICBaseRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;

//修改密码
- (void)analyticalUpdatePasswordData:(BICRegisterRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
//验证手机验证码或谷歌验证码
- (void)analyticalResetPasswordVerifyData:(BICRegisterRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
//重置密码
- (void)analyticalResetPasswordData:(BICRegisterRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
//登出
- (void)analyticallogoutData:(BICRegisterRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;

// 获取登陆历史纪录
- (void)analyticalListUserLoginLogData:(BICRegisterRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;

// 查询账户安全信息 /user/me
- (void)analyticalUserMeData:(BICRegisterRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
//注册第一步验证
- (void)analyticalRegisterVerifyData:(BICRegisterRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
//register/verify
//获取登陆历史纪录：
//8101/userLoginLog/listUserLoginLog


//8101/user/getGoogleKey
//    获取谷歌验证码
- (void)analyticalGetGoogleKeyData:(BICRegisterRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
//谷歌验证
//8101/user/bindGoogle
- (void)analyticalBindGoogleData:(BICRegisterRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;

//校验原来密码
- (void)analyticalCheckOriginPass:(BICRegisterRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
//修改密码
- (void)analyticalupdatePass:(BICRegisterRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
//获取该用户认证信息
- (void)analyticalAuthInfo:(BICBaseRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
//上传基本信息认证
- (void)analyticaladdAuthBasicInfo:(BICAuthInfoRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
//上传证件信息
- (void)analyticaladdAuthCardInfo:(BICAuthInfoRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
//上传证件图片信息
- (void)analyticaladdAuthCardImageInfo:(BICAuthInfoRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;

//邀请返佣配置信息 /cct/config/invitationConfig
- (void)analytiCalinvitationConfigInfo:(BICBaseRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
//获取用户返佣金额，直接、间接邀请人数
///user/relation/info
- (void)analytiRelationInfo:(BICBaseRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
//获取用户邀请列表
///user/relation/invitationInfo
- (void)analytiInvitationInfo:(BICPageRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
//获取佣金排行榜
///user/relation/rankInfo
- (void)analytiRankInfo:(BICPageRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
//用户返佣记录
//btc/walletTransfer/invitationReturnList
- (void)analytiInvitationReturnList:(BICPageRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
@end
NS_ASSUME_NONNULL_END

//
//  ProfileService.m
//  Biconome
//
//  Created by 车林 on 2019/8/12.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICProfileService.h"
#import "BICImageManager.h"
@implementation BICProfileService

static id sharedInstance = nil;
+ (id)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

//注册接口
- (void)analyticalRegisterData:(BICRegisterRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8101"/login/register";
    [self doServerRequestWithModel:request ResponseName:@"BICRegisterResponse" Url:urlStr requestType:HttpRequestTypePost serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
//登陆密码接口
- (void)analyticalPasswordData:(BICRegisterRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8101"/login/password";
    [self doServerRequestWithModel:request ResponseName:@"BICRegisterResponse" Url:urlStr requestType:HttpRequestTypePost serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
//忘记密码验证接口 login/tel
- (void)analyticalLoginTelData:(BICRegisterRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
{
    NSString *urlStr = @""kBaseUrl""URL8101"/login/tel";
    [self doServerRequestWithModel:request ResponseName:@"BICRegisterResponse" Url:urlStr requestType:HttpRequestTypeGet serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
//登陆验证码接口
- (void)analyticalLoginByCodeData:(BICRegisterRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8101"/login/code";
    [self doServerRequestWithModel:request ResponseName:@"BICRegisterResponse" Url:urlStr requestType:HttpRequestTypePost serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}

//获取注册验证码
- (void)analyticalSendRegisterCodeData:(BICBaseRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8101"/login/sendSmsCode";
    [self doServerRequestWithModel:request ResponseName:@"BICBaseResponse" Url:urlStr requestType:HttpRequestTypeGet serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
//修改密码
- (void)analyticalUpdatePasswordData:(BICRegisterRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8101"/login/updatePassword";
    [self doServerRequestWithModel:request ResponseName:@"BICBaseResponse" Url:urlStr requestType:HttpRequestTypePost serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
//验证手机验证码或谷歌验证码
- (void)analyticalResetPasswordVerifyData:(BICRegisterRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8101"/login/resetPasswordVerify";
    [self doServerRequestWithModel:request ResponseName:@"BICBaseResponse" Url:urlStr requestType:HttpRequestTypePost serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
//重置密码
- (void)analyticalResetPasswordData:(BICRegisterRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
NSString *urlStr = @""kBaseUrl""URL8101"/login/resetPassword";
[self doServerRequestWithModel:request ResponseName:@"BICBaseResponse" Url:urlStr requestType:HttpRequestTypePost serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
//登出
- (void)analyticallogoutData:(BICRegisterRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8101"/login/logout";
    [self doServerRequestWithModel:request ResponseName:@"BICBaseResponse" Url:urlStr requestType:HttpRequestTypePost serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}

// 获取登陆历史纪录
- (void)analyticalListUserLoginLogData:(BICRegisterRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
{
    NSString *urlStr = @""kBaseUrl""URL8101"/serLoginLog/listUserLoginLog";
    [self doServerRequestWithModel:request ResponseName:@"BICBaseResponse" Url:urlStr requestType:HttpRequestTypePost serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
// 查询账户安全信息
- (void)analyticalUserMeData:(BICRegisterRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8101"/user/me";
    [self doServerRequestWithModel:request ResponseName:@"BICBaseResponse" Url:urlStr requestType:HttpRequestTypePost serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
//注册第一步验证
- (void)analyticalRegisterVerifyData:(BICRegisterRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8101"/login/register/verify";
    [self doServerRequestWithModel:request ResponseName:@"BICBaseResponse" Url:urlStr requestType:HttpRequestTypePost serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}

//"URL8101"/user/getGoogleKey
//    获取谷歌验证码
- (void)analyticalGetGoogleKeyData:(BICRegisterRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8101"/user/getGoogleKey";
    [self doServerRequestWithModel:request ResponseName:@"BICBindGoogleResponse" Url:urlStr requestType:HttpRequestTypeGet serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
//谷歌验证
//"URL8101"/user/bindGoogle
- (void)analyticalBindGoogleData:(BICRegisterRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8101"/user/bindGooglePC";
    [self doServerRequestWithModel:request ResponseName:@"BICBaseResponse" Url:urlStr requestType:HttpRequestTypePost serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
//检验原始密码
- (void)analyticalCheckOriginPass:(BICRegisterRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8101"/login/checkPassword";
    [self doServerRequestWithModel:request ResponseName:@"BICBaseResponse" Url:urlStr requestType:HttpRequestTypePost serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
//修改密码
- (void)analyticalupdatePass:(BICRegisterRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8101"/login/updatePassword";
    [self doServerRequestWithModel:request ResponseName:@"BICBaseResponse" Url:urlStr requestType:HttpRequestTypePost serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}

//获取该用户认证信息
- (void)analyticalAuthInfo:(BICBaseRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8101"/auth/getAuthInfo";
    [self doServerRequestWithModel:request ResponseName:@"BICAuthInfoResponse" Url:urlStr requestType:HttpRequestTypeGet serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
//上传基本信息认证
- (void)analyticaladdAuthBasicInfo:(BICAuthInfoRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8101"/auth/basic";
    [self doServerRequestWithModel:request ResponseName:@"BICBaseResponse" Url:urlStr requestType:HttpRequestTypePost serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
//上传证件信息
- (void)analyticaladdAuthCardInfo:(BICAuthInfoRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8101"/auth/appCardInfo";
    [self doServerRequestWithModel:request ResponseName:@"BICBaseResponse" Url:urlStr requestType:HttpRequestTypePost serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
//上传证件图片信息
- (void)analyticaladdAuthCardImageInfo:(BICAuthInfoRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8101"/auth/iosImgInfo";
    NSMutableArray *array=[NSMutableArray array];
    for(int i=0;i<request.files.count;i++){
        [array addObject:[NSString stringWithFormat:@"files%d.jpeg",i]];
    }
    [self uploadImageWithPath:urlStr photos:request.files paramsModel:nil responseModelClass:@"BICBaseResponse" imageParameterName:@"files" imageFileName:array success:succHandler failure:failedHandler error:requestError];
    
//    [self uploadSingleImageWithURLString:@""kBaseUrl""URL8101"/auth/iosCardInfo" parametersModel:nil responseModelClass:@"BICBaseResponse" imageParameterName:@"file" imageFileData:[BICImageManager zipNSDataWithImage:[request.files objectAtIndex:0]] imageFileName:@"files.jpeg" serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
//邀请返佣配置信息 /cct/config/invitationConfig
- (void)analytiCalinvitationConfigInfo:(BICBaseRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8501"/config/invitationReturnConfig";
    [self doServerRequestWithModel:request ResponseName:@"BICInvitationConfigResponse" Url:urlStr requestType:HttpRequestTypeGet serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
//获取用户返佣金额，直接、间接邀请人数
///user/relation/info
- (void)analytiRelationInfo:(BICBaseRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8101"/relation/info";
    [self doServerRequestWithModel:request ResponseName:@"BICRelationResponse" Url:urlStr requestType:HttpRequestTypeGet serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
//获取用户邀请列表
///user/relation/invitationInfo
- (void)analytiInvitationInfo:(BICPageRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8101"/relation/invitationInfo";
    [self doServerRequestWithModel:request ResponseName:@"BICInvitationInfoResponse" Url:urlStr requestType:HttpRequestTypeGet serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
//获取佣金排行榜
///user/relation/rankInfo
- (void)analytiRankInfo:(BICPageRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8101"/relation/rankInfo";
    [self doServerRequestWithModel:request ResponseName:@"BICInvitationInfoResponse" Url:urlStr requestType:HttpRequestTypeGet serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
//用户返佣记录
//btc/walletTransfer/invitationReturnList
- (void)analytiInvitationReturnList:(BICPageRequest*)request serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    NSString *urlStr = @""kBaseUrl""URL8301"/walletTransfer/invitationReturnList";
    [self doServerRequestWithModel:request ResponseName:@"BICInvitationInfoResponse" Url:urlStr requestType:HttpRequestTypeGet serverSuccessResultHandler:succHandler failedResultHandler:failedHandler requestErrorHandler:requestError];
}
@end

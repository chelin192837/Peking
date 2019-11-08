//
//  RSDBaseService.m
//  Agent
//
//  Created by wangliang on 2017/8/24.
//  Copyright © 2017年 七扇门. All rights reserved.
//

#import "RSDBaseService.h"
#import "ODAlertViewFactory.h"
#import "DSCoreManager.h"
#import "RSDBaseRequest.h"
#import "RSDBaseResponse.h"
#import "AppDelegate.h"
//#import "SDNavigationViewController.h"

#define ContactsFilePath  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"usercontacts.data"]

@interface RSDBaseService ()

@end

@implementation RSDBaseService

#pragma mark - 设置请求基类
-(id)init{
    self=[super init];
    if (self) {
        self.manager=[ODNetWorkTool instanceAFHTTPRequestOperationManager];
        [self.manager.reachabilityManager startMonitoring];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateManage) name:KUpdate_Token object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLanguage) name:KUpdate_Language object:nil];

    }
    return self;
}

//#MARK: 更新 APPID
- (void)updateManage
{
    NSString *finalyToken = [[NSString alloc]initWithFormat:@"Bearer %@",[[NSUserDefaults standardUserDefaults] objectForKey:APPID]];
    [self.manager.requestSerializer setValue:finalyToken forHTTPHeaderField:@"Authorization"];
    NSString *finalyToken1 = [[NSString alloc]initWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:APPID]];
  
    if ([[NSUserDefaults standardUserDefaults] objectForKey:APPID]) { //存在APPID
        [self.manager.requestSerializer setValue:finalyToken1 forHTTPHeaderField:@"X-Requested-Token"];
    }else{//不存在APPID
        [self.manager.requestSerializer setValue:nil forHTTPHeaderField:@"X-Requested-Token"];

    }
    
//    [self.manager.requestSerializer setValue:finalyToken1?:@"" forHTTPHeaderField:@"X-Requested-Token"];

}
- (void)updateLanguage
{
    [self.manager.requestSerializer setValue:[BICDeviceManager getLanguageCurrencyStr] forHTTPHeaderField:@"locale"];
}

//#MARK: 通用请求方法
- (void)doServerRequestWithModel:(id)request ResponseName:(NSString *)res Url:(NSString *)url requestType:(HttpRequestType)type serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    // 如果参数为空，实例化一个对象，否则有问题
    if (!request) {
        request = [[RSDBaseRequest alloc]init];
    }
    NSLog(@"doServerRequestWithModel..%@",url);
    if (self.manager.reachabilityManager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        [self failedHandle:requestError errorMessage:NotConnectNetwork];
    } else {
        switch (type) {
            case HttpRequestTypeGet:
            {
//                [ODAlertViewFactory showLoadingViewWithMessage:nil];
                [ODNetWorkTool getByUrl:url Parameters:[request toDictionary] success:^(NSURLSessionDataTask *task, id responseObject) {
//                    [ODAlertViewFactory hideAllHud];
//                     id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//                    NSLog(@"json--%@",json);
                    
                    id any=[[NSClassFromString(res)  alloc] initWithData:responseObject error:nil];
                    
                    [self handleServerSuccessResult:succHandler failedResult:failedHandler res:any];
                } Failure:^(NSString *errorMessage) {
//                    [ODAlertViewFactory hideAllHud];
                    [self failedHandle:requestError errorMessage:errorMessage];
                } Manager:self.manager];
            }
                break;
            case HttpRequestTypePost:
            {

//                [ODAlertViewFactory showLoadingViewWithMessage:nil];
                [ODNetWorkTool postByUrl:url Parameters:[request toDictionary] success:^(NSURLSessionDataTask *task, id responseObject) {
//                    [ODAlertViewFactory hideAllHud];
//                    id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//                    NSLog(@"json--%@",json);
                    
                    id any=[[NSClassFromString(res)  alloc] initWithData:responseObject error:nil];
                    
                    [self handleServerSuccessResult:succHandler failedResult:failedHandler res:any];
                    
                } Failure:^(NSString *errorMessage) {
//                    [ODAlertViewFactory hideAllHud];
                    [self failedHandle:requestError errorMessage:errorMessage];
                } Manager:self.manager];
            }
                break;
            case HttpRequestTypePut:
            {
                [ODNetWorkTool putByUrl:url Parameters:@{@"data":[request toJSONString]} success:^(NSURLSessionDataTask *task, id responseObject) {
                    id any=[[NSClassFromString(res)  alloc] initWithData:responseObject error:nil];
                    [self handleServerSuccessResult:succHandler failedResult:failedHandler res:any];
                } Failure:^(NSString *errorMessage) {
                    [self failedHandle:requestError errorMessage:errorMessage];
                } Manager:self.manager];
            }
                break;
            case HttpRequestTypeDelete:
            {
                [ODNetWorkTool deleteByUrl:url Parameters:@{@"data":[request toJSONString]} success:^(NSURLSessionDataTask *task, id responseObject) {
                    id any=[[NSClassFromString(res)  alloc] initWithData:responseObject error:nil];
                    [self handleServerSuccessResult:succHandler failedResult:failedHandler res:any];
                } Failure:^(NSString *errorMessage) {
                    [self failedHandle:requestError errorMessage:errorMessage];
                } Manager:self.manager];
            }
                break;
            default:
                break;
        }
    }
}

- (void)doCommonServerRequestWithModel:(id)request  Url:(NSString *)url serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError{
    // 如果参数为空，实例化一个对象，否则有问题
       if (!request) {
           request = [[RSDBaseRequest alloc]init];
       }
    if (self.manager.reachabilityManager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        [self failedHandle:requestError errorMessage:NotConnectNetwork];
    } else {
        NSDictionary *param = @{@"data":[request toJSONString]};
        [ODNetWorkTool postByUrl:url Parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
            if (responseObject) {
                id obj = [NSJSONSerialization JSONObjectWithData:responseObject
                                                         options:kNilOptions
                                                           error:nil];
                 succHandler(obj);
            }
        } Failure:^(NSString *errorMessage) {
            [self failedHandle:requestError errorMessage:errorMessage];
        } Manager:self.manager];
    }
}

//#MARK: 通用请求方法 更新版
- (void)doNewServerRequestWithModel:(id)request ResponseName:(NSString *)res Url:(NSString *)url requestType:(HttpRequestType)type serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError
{
    // 如果参数为空，实例化一个对象，否则有问题
    if (!request) {
        request = [[RSDBaseRequest alloc]init];
    }
    if (self.manager.reachabilityManager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        [self failedHandle:requestError errorMessage:NotConnectNetwork];
    } else {
        switch (type) {
            case HttpRequestTypeGet:
            {
                [ODNetWorkTool getByUrl:url Parameters:@{@"data":[request toJSONString]} success:^(NSURLSessionDataTask *task, id responseObject) {
                    id any=[[NSClassFromString(res)  alloc] initWithData:responseObject error:nil];
                    [self handleServerSuccessResult:succHandler failedResult:failedHandler res:any];
                } Failure:^(NSString *errorMessage) {
                    [self failedHandle:requestError errorMessage:errorMessage];
                } Manager:self.manager];
            }
                break;
            case HttpRequestTypePost:
            {
                NSDictionary *param = @{@"data":[request toJSONString]};
                
                [ODNetWorkTool postByUrl:url Parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
                    
                    id any;
                    if (responseObject) {
                        id obj = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                 options:kNilOptions
                                                                   error:nil];
                        if (obj) {
                            any = [NSClassFromString(res)  yy_modelWithJSON:obj];
                        }
                    }
                    [self handleServerSuccessResult:succHandler failedResult:failedHandler res:any];
                } Failure:^(NSString *errorMessage) {
                    [self failedHandle:requestError errorMessage:errorMessage];
                } Manager:self.manager];
            }
                break;
            case HttpRequestTypePut:
            {
                [ODNetWorkTool putByUrl:url Parameters:@{@"data":[request toJSONString]} success:^(NSURLSessionDataTask *task, id responseObject) {
                    id any=[[NSClassFromString(res)  alloc] initWithData:responseObject error:nil];
                    [self handleServerSuccessResult:succHandler failedResult:failedHandler res:any];
                } Failure:^(NSString *errorMessage) {
                    [self failedHandle:requestError errorMessage:errorMessage];
                } Manager:self.manager];
            }
                break;
            case HttpRequestTypeDelete:
            {
                [ODNetWorkTool deleteByUrl:url Parameters:@{@"data":[request toJSONString]} success:^(NSURLSessionDataTask *task, id responseObject) {
                    id any=[[NSClassFromString(res)  alloc] initWithData:responseObject error:nil];
                    [self handleServerSuccessResult:succHandler failedResult:failedHandler res:any];
                } Failure:^(NSString *errorMessage) {
                    [self failedHandle:requestError errorMessage:errorMessage];
                } Manager:self.manager];
            }
                break;
            default:
                break;
        }
    }
}


//#MARK: 上传单张图片
- (void)uploadSingleImageWithURLString:(NSString *)URLString 
                       parametersModel:(id)request
                    responseModelClass:(NSString *)modelClass
                    imageParameterName:(NSString *)name
                         imageFileData:(NSData *)fileData
                         imageFileName:(NSString *)fileName
            serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler
                   failedResultHandler:(ServerResultFailedHandler)failedHandler
                   requestErrorHandler:(RequestFailedBlock)requestError{
    if (!request) {
        request = [[RSDBaseRequest alloc]init];
    }
    [ODNetWorkTool multiPartWithURL:URLString fileData:fileData imageParameterName:name imageFileName:fileName params:@{@"data":[request toJSONString]} success:^(NSURLSessionDataTask *task, id responseObject) {
        id any=[[NSClassFromString(modelClass)  alloc] initWithData:responseObject error:nil];
        [self handleServerSuccessResult:succHandler failedResult:failedHandler res:any];
    } Failure:^(NSString *errorMessage) {
        [self failedHandle:requestError errorMessage:errorMessage];
    } Manager:self.manager];
}

/** 
 *  上传图片(多张)
 *
 *  @param urlString   路径
 *  @param photos      图片数组
 *  @param request     参数
 *  @param success     成功回调
 *  @param failure     失败回调
 *  @param error       失败回调
 */

- (void)uploadImageWithPath:(NSString *)urlString 
                     photos:(NSArray *)photos
                paramsModel:(id)request
         responseModelClass:(NSString *)modelClass
         imageParameterName:(NSString *)name
              imageFileName:(NSArray *)fileName
                    success:(ServerResultSuccessHandler)success
                    failure:(ServerResultFailedHandler)failure
                      error:(RequestFailedBlock)error {
    
    if (!request) {
        request = [[RSDBaseRequest alloc]init];
    }
    
    [ODNetWorkTool uploadImageWithPath:urlString photos:photos params:@{@"data":[request toJSONString]} Name:name imageFileName:fileName success:^(NSURLSessionDataTask *task, id responseObject) {
        id any=[[NSClassFromString(modelClass)  alloc] initWithData:responseObject error:nil];
        [self handleServerSuccessResult:success failedResult:failure res:any];
    } Failure:^(NSString *errorMessage) {
        [self failedHandle:error errorMessage:errorMessage];
    } Manager:self.manager];
}

//#MARK: 请求成功
- (void)handleServerSuccessResult:(ServerResultSuccessHandler)succHandler failedResult:(ServerResultFailedHandler)failedHandler res:(RSDBaseResponse *)responseModel
{
//    [ODAlertViewFactory hideAllHud];
    /*
     status = 100000 数据请求成功
     status = 100047 强制更新
     */
    if (responseModel == nil) {
        if ([NSString isBlankString:[[NSUserDefaults standardUserDefaults] objectForKey:APPID]]) {
//            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
        }
        return;
    }
//    if (responseModel.status == SUCCESS_OPERATION || responseModel.status == 100047) {
//        if (succHandler) {
//            succHandler(responseModel);
//        }
    if (responseModel.code) {
        //如果账号在别处登录,挤出当前账号;
        if (responseModel.code==202) {
            [self logoutToHomePage];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [BICDeviceManager AlertShowTip:LAN(@"你的账号已在别处登录")];
                
            });
        }
            if (succHandler) {
                succHandler(responseModel);
            }
    }else{
        if (responseModel.code == 600001) {
//            [[ChatDemoHelper shareHelper] logoutLogin];
        }else{
            if (failedHandler) {
                failedHandler(responseModel);
            }
            NSString *messageStr = @"";
            if ([NSString isBlankString:responseModel.msg]) {
                messageStr = OPERATION_ERROR;
            }else{
                messageStr = responseModel.msg;
            }
            if (messageStr.length){
                
                [BICDeviceManager AlertShowTip:messageStr];
//                [ODAlertViewFactory showToastWithMessage:messageStr];
            }
        }
    }
}
-(void)logoutToHomePage
{
    //清空缓存
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:APPID];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:BICMOBILE];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:BICNickName];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:BICCOINMONEY_];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:BICBindGoogleAuth];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:BICInternationalCode];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    BaseTabBarController *nmTabBarVC = [[BaseTabBarController alloc] init];
    nmTabBarVC.delegate = nmTabBarVC;
    ((AppDelegate*)[UIApplication sharedApplication].delegate).mainController = nmTabBarVC;
    [nmTabBarVC setSelectedIndex:0];
    
    ((AppDelegate*)[UIApplication sharedApplication].delegate).window.rootViewController = nmTabBarVC;
    [((AppDelegate*)[UIApplication sharedApplication].delegate).window makeKeyAndVisible];
    //            nmTabBarVC.delegate = (AppDelegate*)[UIApplication sharedApplication].delegate ;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KUpdate_Token object:nil];
    
    kPOSTNSNotificationCenter(NSNotificationCenterProfileHeader, nil);
    kPOSTNSNotificationCenter(NSNotificationCenterLoginOut, nil);

}
//#MARK: 请求失败
- (void)failedHandle:(RequestFailedBlock)requestFailed errorMessage:(NSString *)errorMessage
{
//    [ODAlertViewFactory hideAllHud];
    if (requestFailed) {
        requestFailed(errorMessage);
    }
    if ([NSString isBlankString:errorMessage]) {
        errorMessage = OPERATION_ERROR;
    }
    if (errorMessage.length){
//        if (![errorMessage isEqualToString:HttpStatusServerBlock]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [BICDeviceManager AlertShowTip:errorMessage];
        });
//        }
    }
}


/**
 取消网络请求
 */
- (void)cancelRequest
{
    if ([self.manager.tasks count] > 0) {
        [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    }
}

@end

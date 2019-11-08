//
//  RSDBaseService.h
//  Agent
//
//  Created by wangliang on 2017/8/24.
//  Copyright © 2017年 七扇门. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ODNetWorkTool.h"
#import "Header.h"
@class RSDBaseRequest;
@class RSDBaseResponse;


typedef NS_ENUM(NSUInteger, HttpRequestType) {
    HttpRequestTypeGet=1,
    HttpRequestTypePost,
    HttpRequestTypePut,
    HttpRequestTypeDelete,
    HttpRequestTypeUploadSingleImage
};

typedef void(^HandlerResponseBlock)(id response);
typedef void(^RequestFailedBlock)(id error);

typedef void(^ServerResultSuccessHandler)(id response);
typedef void(^ServerResultFailedHandler)(id response);

@interface RSDBaseService : NSObject

///
@property (nonatomic,strong) AFHTTPSessionManager *manager;
///
@property (nonatomic,assign) AFNetworkReachabilityStatus networkStatus;
///通用请求封装
-(void)doServerRequestWithModel:(id)request ResponseName:(NSString *)res Url:(NSString *)url requestType:(HttpRequestType)type serverSuccessResultHandler:(ServerResultSuccessHandler )succHandler failedResultHandler:(ServerResultFailedHandler) failedHandler requestErrorHandler:(RequestFailedBlock)requestError;

//#MARK: 通用请求方法 更新版
- (void)doNewServerRequestWithModel:(id)request ResponseName:(NSString *)res Url:(NSString *)url requestType:(HttpRequestType)type serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;

///  单个图片上传
- (void)uploadSingleImageWithURLString:(NSString *)URLString parametersModel:(id)request responseModelClass:(NSString *)modelClass imageParameterName:(NSString *)name imageFileData:(NSData *)fileData imageFileName:(NSString *)fileName  serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;

- (void)doCommonServerRequestWithModel:(id)request  Url:(NSString *)url serverSuccessResultHandler:(ServerResultSuccessHandler)succHandler failedResultHandler:(ServerResultFailedHandler)failedHandler requestErrorHandler:(RequestFailedBlock)requestError;
#pragma mark -- 多图上传 --

- (void)uploadImageWithPath:(NSString *)urlString
                     photos:(NSArray *)photos
                paramsModel:(id)request
         responseModelClass:(NSString *)modelClass
         imageParameterName:(NSString *)name
              imageFileName:(NSArray *)fileName
                    success:(ServerResultSuccessHandler)success
                    failure:(ServerResultFailedHandler)failure
                      error:(RequestFailedBlock)error;


/**
 取消网络请求
 */
- (void)cancelRequest;
@end

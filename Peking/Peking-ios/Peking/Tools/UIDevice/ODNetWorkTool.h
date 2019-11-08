//
//  ODNetWorkTool.h
//  OneDoor
//
//  Created by coderGL on 16/7/16.
//  Copyright © 2016年 Yujing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#define HttpStatusVaildFailed       LAN(@"验证失败！")
#define HttpStatusRequestFailed     LAN(@"请求失败！")
#define HttpStatusServerBlock       LAN(@"服务器异常！")
#define HttpStatusConncetionTimeOut LAN(@"网络超时，请重试")
#define HttpStatusPathNotFound      LAN(@"找不到地址！")
#define NotConnectNetwork           LAN(@"当前网络不可用，请检查网络")
#define SUCCESS_OPERATION           200
#define OPERATION_SUCCESS           LAN(@"操作成功")
#define OPERATION_ERROR             LAN(@"请求异常,请重新尝试")
#define kLoadingMesssage            LAN(@"加载中...")
#define kSetAdvertPublishFail       LAN(@"配置信息请求失败返回重试")
#define HttpStatusConncetionCancle  LAN(@"取消网络请求")


@interface ODNetWorkTool : NSObject

+(AFHTTPSessionManager *)instanceAFHTTPRequestOperationManager;

/**
 *  封装get方法
 *
 *  @param url        请求地址
 *  @param parameters 请求参数
 *  @param success    请求成功回调Block
 *  @param failure    请求失败回调Block
 *  @param manger     AF_manager
 */
+(void)getByUrl:(NSString *)url Parameters:(id)parameters  success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
        Failure:(void (^)(NSString * errorMessage))failure Manager:(AFHTTPSessionManager *)manger;

/**
 *  封装post方法
 *
 *  @param url        请求地址
 *  @param parameters 请求参数
 *  @param success    请求成功回调Block
 *  @param failure    请求失败回调Block
 *  @param manger     AF_manager
 */
+(void)postByUrl:(NSString *)url Parameters:(id)parameters  success:(void (^)(NSURLSessionDataTask * task,id responseObject))success
         Failure:(void (^)(NSString * errorMessage))failure Manager:(AFHTTPSessionManager *)manger;

/**
 *  封装put方法
 *
 *  @param url        请求地址
 *  @param parameters 请求参数
 *  @param success    请求成功回调Block
 *  @param failure    请求失败回调Block
 *  @param manger     AF_manager
 */
+(void)putByUrl:(NSString *)url Parameters:(id)parameters  success:(void (^)(NSURLSessionDataTask * task,id responseObject))success
        Failure:(void (^)(NSString * errorMessage))failure Manager:(AFHTTPSessionManager *)manger;

/**
 *  封装delete方法
 *
 *  @param url        请求地址
 *  @param parameters 请求参数
 *  @param success    请求成功回调Block
 *  @param failure    请求失败回调Block
 *  @param manger     AF_manager
 */
+(void)deleteByUrl:(NSString *)url Parameters:(id)parameters  success:(void (^)(NSURLSessionDataTask * task,id responseObject))success
           Failure:(void (^)(NSString * errorMessage))failure Manager:(AFHTTPSessionManager *)manger;

/**
 *  标准上传文件URL方法
 *
 *  @param url     接口地址
 *  @param params  信息参数
 *  @param fileDic 文件URL字典
 *  @param success e
 *  @param failure e
 *  @param mange e
 */
+(void)multiPartWithURL:(NSString *)url infoParams:(NSDictionary *)params fileUrlParams:(NSDictionary *)fileDic success:(void (^)(NSURLSessionDataTask * task,id responseObject))success
                Failure:(void (^)(NSString * errorMessage))failure Manager:(AFHTTPSessionManager *)mange;

/**
 *  单张上传图片(单文件)
 *  @param url      请求地址
 *  @param fileData 上传文件data
 *  @param name     上传图片请求的图fileName名
 *  @param fileName 上传到服务器的图片文件名
 *  @param params   请求参数
 *  @param success  请求成功回调Block
 *  @param failure  请求失败回调Block
 *  @param mange    AF_manager
 */
+(void)multiPartWithURL:(NSString *)url fileData:(NSData *)fileData imageParameterName:(NSString *)name imageFileName:(NSString *)fileName params:(NSDictionary *)params success:(void (^)(NSURLSessionDataTask * task,id responseObject))success Failure:(void (^)(NSString * errorMessage))failure Manager:(AFHTTPSessionManager *)mange;



+(void)multiPartWithURL:(NSString *)url formDataArray:(NSMutableArray *)formDataArray Name:(NSString *)name params:(NSDictionary *)params success:(void (^)(NSURLSessionDataTask * task,id responseObject))success
                Failure:(void (^)(NSString * errorMessage))failure Manager:(AFHTTPSessionManager *)mange;

/** 
 *  上传图片(多张) 
 * 
 *  @param path    请求路径 
 *  @param photos  图片数组 
 *  @param params  参数 
 *  @param success 成功回调 
 *  @param failure 失败回调 
 *  @param mange   AF_manager
 */ 
+ (void)uploadImageWithPath:(NSString *)path
                     photos:(NSArray *)photos
                     params:(NSDictionary *)params
                       Name:(NSString *)name
              imageFileName:(NSArray *)fileName
                    success:(void (^)(NSURLSessionDataTask * task,id responseObject))success
                    Failure:(void (^)(NSString * errorMessage))failure
                    Manager:(AFHTTPSessionManager *)mange;

@end

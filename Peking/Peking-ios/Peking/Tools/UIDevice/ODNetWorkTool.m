//
//  ODNetWorkTool.m
//  OneDoor
//
//  Created by coderGL on 16/7/16.
//  Copyright © 2016年 Yujing. All rights reserved.
//

#import "ODNetWorkTool.h"
#import "BICImageManager.h"
@implementation ODNetWorkTool

+ (AFHTTPSessionManager *)instanceAFHTTPRequestOperationManager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
//    //默认证书
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;

    //证书设置
    manager.securityPolicy = securityPolicy;
    manager.securityPolicy.validatesDomainName = NO;
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString *finalyToken = [[NSString alloc]initWithFormat:@"Bearer %@",[[NSUserDefaults standardUserDefaults] objectForKey:APPID]];
    [manager.requestSerializer setValue:finalyToken forHTTPHeaderField:@"Authorization"];
    
    NSString *finalyToken1 = [[NSString alloc]initWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:APPID]];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:APPID]) {
        [manager.requestSerializer setValue:finalyToken1 forHTTPHeaderField:@"X-Requested-Token"];
    }
    

    return manager;
}

+ (void)getByUrl:(NSString *)url Parameters:(id)parameters success:(void (^)(NSURLSessionDataTask * task, id responseObject))success Failure:(void (^)(NSString *))failure Manager:(AFHTTPSessionManager *)manger
{
    [manger GET:url parameters:parameters progress:nil success:success failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self checkHttpResponseStatusWithHttpCode:[self getErrorStatusCode:task error:error] Failure:failure];
    }];
}

+ (void)postByUrl:(NSString *)url Parameters:(id)parameters success:(void (^)(NSURLSessionDataTask * task, id responseObject))success Failure:(void (^)(NSString *))failure Manager:(AFHTTPSessionManager *)manger
{
    [manger POST:url parameters:parameters progress:nil success:success failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSData *errorData = [error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"]; 
        if (errorData) {
            id errorMessage = [NSJSONSerialization JSONObjectWithData:errorData
                                                     options:kNilOptions
                                                       error:nil];
            NSLog(@"%@",errorMessage);
        }
        
        [self checkHttpResponseStatusWithHttpCode:[self getErrorStatusCode:task error:error] Failure:failure];
        
    }];
}

+ (void)putByUrl:(NSString *)url Parameters:(id)parameters success:(void (^)(NSURLSessionDataTask * task, id responseObject))success Failure:(void (^)(NSString *))failure Manager:(AFHTTPSessionManager *)manger
{
    [manger PUT:url parameters:parameters success:success failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self checkHttpResponseStatusWithHttpCode:[self getErrorStatusCode:task error:error] Failure:failure];
    }];
}

+ (void)deleteByUrl:(NSString *)url Parameters:(id)parameters success:(void (^)(NSURLSessionDataTask * task, id responseObject))success Failure:(void (^)(NSString *))failure Manager:(AFHTTPSessionManager *)manger
{
    [manger DELETE:url parameters:parameters success:success failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self checkHttpResponseStatusWithHttpCode:[self getErrorStatusCode:task error:error] Failure:failure];
    }];
}

+ (void)multiPartWithURL:(NSString *)url infoParams:(NSDictionary *)params fileUrlParams:(NSDictionary *)fileDic success:(void (^)(NSURLSessionDataTask * task, id responseObject))success Failure:(void (^)(NSString *))failure Manager:(AFHTTPSessionManager *)mange
{
    [mange POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSString * fileKey in fileDic.allKeys) {
            id fileList = [fileDic valueForKey:fileKey];
            if ([fileList isKindOfClass:[NSArray class]]) {
                for (NSString *fileUrl in fileList) {
                    NSString *mimeType = @"image/jpeg";
                    NSString *lastName = @"jpg";
                    if ([fileUrl hasSuffix:@"png"]) {
                        mimeType = @"image/png";
                        lastName = @"png";
                    } else if ([fileUrl hasSuffix:@"mp3"]) {
                        mimeType = @"audio/mpeg";
                        lastName = @"mp3";
                    }
                    [formData appendPartWithFileURL:[NSURL URLWithString:fileUrl] name:fileKey fileName:[NSString stringWithFormat:@".%@",lastName] mimeType:mimeType error:nil];
                }
            }
        }
    } progress:nil success:success failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self checkHttpResponseStatusWithHttpCode:[self getErrorStatusCode:task error:error] Failure:failure];
    }];
}


// 单张上传图片
+(void)multiPartWithURL:(NSString *)url fileData:(NSData *)fileData imageParameterName:(NSString *)name imageFileName:(NSString *)fileName params:(NSDictionary *)params success:(void (^)(NSURLSessionDataTask * task,id responseObject))success Failure:(void (^)(NSString * errorMessage))failure Manager:(AFHTTPSessionManager *)mange
{
    [mange POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSString *mimeType = @"image/jpeg";
        if ([fileName hasSuffix:@"png"]) {
            mimeType = @"image/png";
        }
        if (fileData) {
            [formData appendPartWithFileData:fileData name:name fileName:fileName mimeType:mimeType];
        }
    } progress:nil success:success failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self checkHttpResponseStatusWithHttpCode:[self getErrorStatusCode:task error:error] Failure:failure];
    }];
}



+(void)multiPartWithURL:(NSString *)url formDataArray:(NSMutableArray *)formDataArray Name:(NSString *)name params:(NSDictionary *)params success:(void (^)(NSURLSessionDataTask * task,id responseObject))success
                Failure:(void (^)(NSString * errorMessage))failure Manager:(AFHTTPSessionManager *)mange
{
    [mange POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i=0; i<formDataArray.count; i++) {
            NSString *str = [formDataArray objectAtIndex:i];
            if ([str isKindOfClass:[NSNumber class]]) {
                str = [NSString stringWithFormat:@"%@", str];
            }
            [formData appendPartWithFormData:[str dataUsingEncoding:NSUTF8StringEncoding] name:name];

        }
        
    } progress:nil success:success failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self checkHttpResponseStatusWithHttpCode:[self getErrorStatusCode:task error:error] Failure:failure];
    }];
}

+ (void)uploadImageWithPath:(NSString *)path 
                     photos:(NSArray *)photos 
                     params:(NSDictionary *)params
                       Name:(NSString *)name
              imageFileName:(NSArray *)fileName
                    success:(void (^)(NSURLSessionDataTask * task,id responseObject))success
                    Failure:(void (^)(NSString * errorMessage))failure 
                    Manager:(AFHTTPSessionManager *)mange {
    
    [mange POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

        for (int i = 0; i < photos.count; i ++) {
            
            NSString *str_file = fileName[i];
            if ([str_file containsString:@"gif"]||[str_file containsString:@"GIF"]) {
                NSData *image = photos[i];  
                [formData appendPartWithFileData:image name:[NSString stringWithFormat:@"files%d",i+1] fileName:[NSString stringWithFormat:@"%@",fileName[i]]  mimeType:@"image/gif"];
            }else{
                UIImage *image = photos[i];
                //使用自定义压缩
//              NSData *imageData = UIImageJPEGRepresentation(image, 0.28);
                NSData *imageData = [BICImageManager zipNSDataWithImage:image];
                [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"files%d",i+1] fileName:[NSString stringWithFormat:@"%@",fileName[i]]  mimeType:@"image/jpeg"];
            }
            
        }  
        
    } progress:nil success:success failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self checkHttpResponseStatusWithHttpCode:[self getErrorStatusCode:task error:error] Failure:failure];
    }];
    
}

+(void)checkHttpResponseStatusWithHttpCode:(NSInteger)code Failure:(void (^)(NSString * errorMessage))failure{
    if (code == 401) {
        //        [[NSNotificationCenter defaultCenter] postNotificationName:K_NOTI_AccessTokenInvalid object:nil];
    }else if(code==400){
        failure(HttpStatusVaildFailed);
    }else if(code==404){
        failure(HttpStatusPathNotFound);
    }else if(code>=400&&code<500){
        failure(HttpStatusRequestFailed);
    }else if(code>=500&&code<=600){
        failure(HttpStatusServerBlock);
    }else if (code==600001) {//token过期 600001
//        [[ChatDemoHelper shareHelper] logoutLogin];
    }else{
        failure(HttpStatusConncetionTimeOut);
    }
}

+(NSInteger)getErrorStatusCode:(NSURLSessionTask *)task error:(NSError *) error
{
    
    NSData *errorData = [error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"]; 
    NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task.response;
    
//    if (!errorData && !urlResponse.statusCode) {
//        return 9999000;
//    }else{
        return urlResponse.statusCode;
//    }
}

@end

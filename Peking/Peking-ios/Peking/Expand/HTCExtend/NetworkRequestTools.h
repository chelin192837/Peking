//
//  NetworkRequestTools.h
//  网络请求工具类的封装
//
//  Created by 王亮 on 16/4/12.
//  Copyright © 2016年 wangLiang. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef void(^CompleteBlock)(id object);

typedef enum : NSUInteger {
    GET,
    POST
} WDLRequestType;

@interface NetworkRequestTools : AFHTTPSessionManager

/**
 *  整个App中就用NetWorkTools单例来发送网络请求
 *
 *  @return 单例
 */
+ (instancetype)sharedNetworkRequestTools;

// 请求方法
- (void)requestDataWithType:(WDLRequestType)requestType URLString:(NSString *)URLString parameters:(id)parameters successBlock:(CompleteBlock)successBlock failureBlock:(CompleteBlock)failureBlock;

@end


//
//  RSDBaseRequest.m
//  Agent
//
//  Created by wangliang on 2017/8/24.
//  Copyright © 2017年 七扇门. All rights reserved.
//

#import "RSDBaseRequest.h"

@implementation RSDBaseRequest

- (instancetype)init
{
    if (self=[super init]) {
        NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        self.version = appVersion;
        self.app_version = appVersion;
    }
    return self;
}

@end

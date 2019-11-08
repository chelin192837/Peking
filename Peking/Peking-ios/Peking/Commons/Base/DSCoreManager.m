//
//  DSCoreManager.m
//  DecorationServices
//
//  Created by 七扇门 on 2017/6/30.
//  Copyright © 2017年 SevenDoors. All rights reserved.
//

#import "DSCoreManager.h"

static DSCoreManager *_sharedInstance = nil;

@implementation DSCoreManager

+ (DSCoreManager*)sharedInstance {
    if (_sharedInstance != nil) {
        return _sharedInstance;
    }
    @synchronized(self) {
        if (_sharedInstance == nil) {
            _sharedInstance = [[self alloc] init];
        }
    }
    return _sharedInstance;
}

- (id)init {
    self = [super init];
    if (self != nil) {
        
        _reachability = [Reachability reachabilityForInternetConnection];
        
        Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
        _reachability = reach;
        //开启网络状况监听
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(netStatusChange:) name:kReachabilityChangedNotification object:nil];
        ///开启监听，会启动一个run loop
        [_reachability startNotifier];
        
    }
    return self;
}

- (void)netStatusChange:(NSNotification *)note{
    
    Reachability *currentReach = [note object];
    NSParameterAssert([currentReach isKindOfClass:[Reachability class]]);
    //判断网络状态
    switch (self.reachability.currentReachabilityStatus) {
        case NotReachable:
            NSLog(@"网络不通");
            self.connectEnable = NO;
            break;
        case ReachableViaWiFi:
            NSLog(@"wifi上网");
            self.connectEnable = YES;
            break;
        case ReachableViaWWAN:
            NSLog(@"手机上网");
            self.connectEnable = YES;
            break;
        default:
            break;
    }
    
}

@end

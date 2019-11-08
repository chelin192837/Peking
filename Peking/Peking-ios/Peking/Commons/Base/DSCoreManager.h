//
//  DSCoreManager.h
//  DecorationServices
//
//  Created by 七扇门 on 2017/6/30.
//  Copyright © 2017年 SevenDoors. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"


#define DSManager (DSCoreManager.sharedInstance)

@interface DSCoreManager : NSObject

@property(nonatomic,readonly,strong) Reachability   *reachability;                //网路服务

@property (nonatomic, assign) BOOL connectEnable;

+ (DSCoreManager*)sharedInstance;


@end

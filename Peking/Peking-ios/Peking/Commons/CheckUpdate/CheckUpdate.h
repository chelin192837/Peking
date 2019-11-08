//
//  CheckUpdate.h
//  Yipuhui
//
//  Created by liuweiwei on 16/3/2.
//  Copyright © 2016年 huazhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CheckUpdate : NSObject
//app信息在appstore
@property(nonatomic,strong)NSDictionary*releaseInfoDic;
+(CheckUpdate*)share;
-(void)checkIsNeedUpdate;
-(void)requestVersion;
//-(void)leftRequestVersion;
-(void)exitApplication;
@end

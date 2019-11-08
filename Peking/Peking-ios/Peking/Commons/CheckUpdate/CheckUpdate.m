 //
//  CheckUpdate.m
//  Yipuhui
//
//  Created by 侯英格 on 16/3/2.
//  Copyright © 2016年 . All rights reserved.
//

#import "CheckUpdate.h"
#import "AFNetworking.h"
#import "BICAppStoreResponse.h"
#import "BICUpdateView.h"
#import "BICUpdateViewController.h"
@interface CheckUpdate()<UIAlertViewDelegate>
@end

@implementation CheckUpdate
static CheckUpdate*check=nil;
+(CheckUpdate*)share{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!check) {
            check=[[CheckUpdate alloc] init];
        }
    });
    return check;
}

-(void)checkIsNeedUpdate{
    //获取版本号
    NSDictionary *bundleDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [bundleDic objectForKey:@"CFBundleShortVersionString"];
    [[BICMainService sharedInstance] analyticalAppStoreVersionData:[[BICBaseRequest alloc] init] serverSuccessResultHandler:^(id response) {
        NSArray *infoArray =[response objectForKey:@"results"];
        if ([infoArray count]==1) {
            self.releaseInfoDic=[infoArray objectAtIndex:0];
            //版本
            NSString*appStoreVersion = [self.releaseInfoDic objectForKey:@"version"];
            if (appStoreVersion && [self compareVersionNumberWithAppStoreVersion:appStoreVersion andAppVersion:appVersion])
            {
                [self requestVersion];
            }
        }
    } failedResultHandler:^(id response) {
        
    } requestErrorHandler:^(id error) {
        
    }];
}

-(void)requestVersion{
    BICVersionRequest *req=[[BICVersionRequest alloc] init];
    req.device=@"ios";
    [[BICMainService sharedInstance] analyticalNewVersionData:req serverSuccessResultHandler:^(id response) {
        BICAppStoreResponse *res=(BICAppStoreResponse *)response;
        NSString *version=res.data.version;
        NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
        NSString *currentVersion = infoDic[@"CFBundleShortVersionString"];
        NSComparisonResult comparResult = [version compare:currentVersion options:NSNumericSearch];
        if (comparResult == NSOrderedAscending ||comparResult == NSOrderedSame) {
            //不需要更新
            return;
        }else{
            BICUpdateView *view=[[BICUpdateView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
            view.response=res;
            [[UIApplication sharedApplication].keyWindow addSubview:view];
        }
    } failedResultHandler:^(id response) {
        
    } requestErrorHandler:^(id error) {
        NSLog(@"%@",error);
    }];
}


-(void)exitApplication {
    [UIView animateWithDuration:1.0f animations:^{
        [[UIApplication sharedApplication].delegate window].alpha = 0;
    } completion:^(BOOL finished) {
        exit(0);
    }];
}
-(BOOL)compareVersionNumberWithAppStoreVersion:(NSString*)appStoreVersion andAppVersion:(NSString*)appVersion{
    NSArray*appStoreArray=[appStoreVersion componentsSeparatedByString:@"."];
    NSArray*appArray=[appVersion componentsSeparatedByString:@"."];
    if (appStoreArray.count==3&&appArray.count==3) {
        for (int i=0; i<3; i++) {
            if ([appArray[i] integerValue]==[appStoreArray[i] integerValue]) {
                if (i==2) {
                    return NO;
                }
                else{
                    continue;
                }
                
            }
            if ([appArray[i] integerValue]<[appStoreArray[i] integerValue]) {
                return YES;
            }
            else{
                return NO;
            }
        }
    }
    else{
        return NO;
    }
    return NO;
}

@end

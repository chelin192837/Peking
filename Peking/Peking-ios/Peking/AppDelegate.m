//
//  AppDelegate.m
//  Biconome
//
//  Created by 车林 on 2019/8/3.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "AppDelegate.h"
#import "YYFPSLabel.h"

#import "BICDataToUserDefault.h"
@import Firebase;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [FIRApp configure];
    
    BICDataToUserDefault * userDefult = [[BICDataToUserDefault alloc] init];
    
    [userDefult setupData];
    
    //开启IQKeyBoard
    // 开始第三方键盘
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = YES;
    // 点击屏幕隐藏键盘
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    BaseTabBarController *nmTabBarVC = [[BaseTabBarController alloc] init];
    [nmTabBarVC setSelectedIndex:0];
    nmTabBarVC.selSelect = 0 ;
    self.mainController = nmTabBarVC;
    self.window.rootViewController = nmTabBarVC;
    [self.window makeKeyAndVisible];
//    [self testFPSLabel];
    // Override point for customization after application launch.
    return YES;
}

- (void)testFPSLabel {
    UILabel * fpsLabel = [YYFPSLabel new];
    fpsLabel.frame = CGRectMake(200, 200, 50, 30);
    [fpsLabel sizeToFit];
    [[UIApplication sharedApplication].keyWindow  addSubview:fpsLabel];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [[NSNotificationCenter defaultCenter] postNotificationName:AppdelegateEnterForeground object:nil];
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

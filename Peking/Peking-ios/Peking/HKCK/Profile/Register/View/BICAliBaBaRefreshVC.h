//
//  BICAliBaBaRefreshVC.h
//  Biconome
//
//  Created by 车林 on 2019/9/19.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JSObjcDelegate
// 声明testWebView对象调用的JS方法。
-(void)getSlideData:(NSString*)callData;

@end

@interface BICAliBaBaRefreshVC : UIViewController

@property (nonatomic, strong) JSContext *context;

@end

NS_ASSUME_NONNULL_END

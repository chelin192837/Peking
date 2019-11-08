//
//  WKWebViewController.h
//  JS_OC_URL
//
//  Created by Harvey on 16/8/4.
//  Copyright © 2016年 Haley. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SuccessBlock)(void);
@interface WKWebViewController : BaseViewController

@property(nonatomic,copy)SuccessBlock successBlock;
@property(nonatomic,assign)Boolean isWhiteNav;
@end

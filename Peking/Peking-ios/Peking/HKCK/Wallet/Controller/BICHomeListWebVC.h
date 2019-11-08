//
//  RSDHomeListWebVC.h
//  Agent
//
//  Created by wangliang on 2018/3/15.
//  Copyright © 2018年 七扇门. All rights reserved.
//

#import "BaseViewController.h"
typedef NS_ENUM(NSInteger,BICPush_Nav_Type)
{
    BICPush_Nav_Type_Normal=99,
    BICPush_Nav_Type_Other
};
typedef void(^SuccessBlock)(void);
@interface BICHomeListWebVC : BaseViewController

@property (nonatomic,strong) NSString *listWebStr;
@property (nonatomic,strong) NSString *naviStr;//为空默认 楼盘列表
@property (nonatomic,assign) BICPush_Nav_Type type;

@property (nonatomic,copy) SuccessBlock successBlock;



@end

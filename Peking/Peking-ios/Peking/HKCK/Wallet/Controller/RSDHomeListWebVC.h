//
//  RSDHomeListWebVC.h
//  Agent
//
//  Created by wangliang on 2018/3/15.
//  Copyright © 2018年 七扇门. All rights reserved.
//

#import "BaseViewController.h"

@interface RSDHomeListWebVC : BaseViewController

@property (nonatomic,strong) NSString *listWebStr;
@property (nonatomic,strong) NSString *naviStr;//为空默认 楼盘列表

//导航栏目的显示
@property (nonatomic,assign) BOOL navigationShow;


@end

//
//  HTSDButton.h
//  TableViewDelect
//
//  Created by qsm on 2018/7/25.
//  Copyright © 2018年 yujing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HTSDButtonBlock)(void);

@interface HTSDButton : UIButton

+(instancetype)exit:(HTSDButtonBlock)block WithImage:(NSString*)imageName ;

-(instancetype)initWithBlock:(HTSDButtonBlock)block WithImage:(NSString *)imageName ;

-(void)remove;

@end

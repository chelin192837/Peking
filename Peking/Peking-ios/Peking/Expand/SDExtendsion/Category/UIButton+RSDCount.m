//
//  UIButton+RSDCount.m
//  Agent
//
//  Created by qsm on 2018/9/10.
//  Copyright © 2018年 七扇门. All rights reserved.
//

#import "UIButton+RSDCount.h"

@implementation UIButton (RSDCount)

+ (void)load {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        Class selfClass = [self class];
        
        SEL oriSEL = @selector(sendAction:to:forEvent:);
        Method oriMethod = class_getInstanceMethod(selfClass, oriSEL);
        
        SEL cusSEL = @selector(mySendAction:to:forEvent:);
        Method cusMethod = class_getInstanceMethod(selfClass, cusSEL);
        
        BOOL addSucc = class_addMethod(selfClass, oriSEL, method_getImplementation(cusMethod), method_getTypeEncoding(cusMethod));
        
        if (addSucc) {
            class_replaceMethod(selfClass, cusSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
        }else {
            method_exchangeImplementations(oriMethod, cusMethod);
        }
        
        SEL oriUse = @selector(setUserInteractionEnabled:);
        Method oriUseMethod = class_getInstanceMethod(selfClass, oriUse);
        
        SEL cusUse = @selector(setMyUserInteractionEnabled:);
        Method cusUseMethod = class_getInstanceMethod(selfClass, cusUse);
        
        BOOL adduseSucc = class_addMethod(selfClass, oriUse, method_getImplementation(cusUseMethod), method_getTypeEncoding(cusUseMethod));
        
        if (adduseSucc) {
            class_replaceMethod(selfClass, cusUse, method_getImplementation(oriUseMethod), method_getTypeEncoding(oriUseMethod));
        }else
        {
            method_exchangeImplementations(oriUseMethod, cusUseMethod);
        }
    });
    
}

- (void)mySendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    NSNumber* userInterfaceBool = objc_getAssociatedObject(self, USRINTREFACE);
    
    if (userInterfaceBool.integerValue != UseInterfaceType_NO) {
        [self mySendAction:action to:target forEvent:event];
    }else
    {
        RSDLog(@"执行方法禁用函数");
    }
    
}


-(void)setMyUserInteractionEnabled:(BOOL)userInteractionEnabled
{
    NSUInteger __userInterface = userInteractionEnabled ? UseInterfaceType_YES : UseInterfaceType_NO ;
    
    objc_setAssociatedObject(self, USRINTREFACE, @(__userInterface), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self setMyUserInteractionEnabled:YES];
    
}


@end




























//
//  NSObject+Address.m
//  网易彩票2014MJ版
//
//  Created by muxi on 14-9-23.
//  Copyright (c) 2014年 沐汐. All rights reserved.
//

#import "NSObject+Extend.h"
#import <objc/message.h>


@implementation NSObject (Extend)


#pragma mark  返回任意对象的字符串式的内存地址
-(NSString *)address{
    return [NSString stringWithFormat:@"%p",self];
}

#pragma mark  调用方法
-(void)callSelectorWithSelString:(NSString *)selString paramObj:(id)paramObj{
    
    //转换为sel
    SEL sel=NSSelectorFromString(selString);
    
    if(![self respondsToSelector:sel]) return;
    
    //调用
//    objc_msgSend(self, sel);
    
}

+(void)__Null
{
   RSDLog(@"执行空函数");
}

+(void)__kill:(NSObject*)object
{
    RSDLog(@"杀死移除对象%@",object);
    
    object = nil ;
}

/**
 *  模型转模型
 */
+ (instancetype)ZXY_ModelToModel:(id)model
{
    id object = [[self alloc] init];
    
    unsigned int count = 0 ;
    
    Ivar * ivarList = class_copyIvarList([self class], &count);
    
    unsigned int modelCount = 0 ;
    
    Ivar * modelIvarList = class_copyIvarList([model class], &modelCount);
    
    for (int i = 0; i < count; i++) {
        
        Ivar ivar = ivarList[i];
        
        NSString * proName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        
        for (int j = 0 ; j < modelCount; j++) {
            
            Ivar modelIvar = modelIvarList[j];
            
            NSString * modelName = [NSString stringWithUTF8String:ivar_getName(modelIvar)];
            
            if ([proName isEqualToString:modelName]) {
                
                NSObject *value = [model valueForKey:modelName];
                
                NSString * key = [proName substringFromIndex:1];
                
                [object setValue:value forKey:key];
                
            }
        }
    }
    
    return object ;
}


@end





































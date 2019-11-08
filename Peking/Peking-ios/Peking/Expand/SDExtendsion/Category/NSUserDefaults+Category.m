//
//  NSUserDefaults+Category.m
//  Agent
//
//  Created by 七扇门 on 2019/4/11.
//  Copyright © 2019年 七扇门. All rights reserved.
//

#import "NSUserDefaults+Category.h"

@implementation NSUserDefaults (Category)

+ (void)setObject:(id)obj forKey:(NSString *)key {
    
    if (obj && key) {
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        [def setObject:obj forKey:key];
        [def synchronize];
    }
}

+ (id)getObjForKey:(NSString *)key {
    
    if (key) {
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        return [def objectForKey:key];
    }
    return nil;
}

+ (void)removeObjForKey:(NSString *)key {
    
    if (key) {
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        [def removeObjectForKey:key];
        [def synchronize];
    }
}

@end

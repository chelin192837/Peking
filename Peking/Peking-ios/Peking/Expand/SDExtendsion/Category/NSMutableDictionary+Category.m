//
//  NSMutableDictionary+Category.m
//  Agent
//
//  Created by 七扇门 on 2019/4/11.
//  Copyright © 2019年 七扇门. All rights reserved.
//

#import "NSMutableDictionary+Category.h"

@implementation NSMutableDictionary (Category)

- (void)safeObject:(id)obj forKey:(NSString *)key {
    
    if (obj && ![obj isKindOfClass:[NSNull class]] && (obj != nil)) {
        [self setObject:obj forKey:key];
    }
}

@end

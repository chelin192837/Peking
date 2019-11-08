//
//  NSMutableDictionary+Category.h
//  Agent
//
//  Created by 七扇门 on 2019/4/11.
//  Copyright © 2019年 七扇门. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableDictionary (Category)

- (void)safeObject:(id)obj forKey:(NSString *)key ;

@end

NS_ASSUME_NONNULL_END

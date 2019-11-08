//
//  NSDate+Pretty.h
//  Agent
//
//  Created by qsm on 2018/5/19.
//  Copyright © 2018年 七扇门. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Pretty)
- (NSString *)prettyDateWithReference:(NSDate *)reference ;
- (NSString *)prettyDateWithReferenceOfTwo:(NSDate *)reference;
@end

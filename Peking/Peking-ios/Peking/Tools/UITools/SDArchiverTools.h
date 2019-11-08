//
//  SDArchiverTools.h
//  Agent
//
//  Created by 七扇门 on 2017/12/11.
//  Copyright © 2017年 七扇门. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDArchiverTools : NSObject

//归档的工具方法

+ (void)archiverObject:(id)object ByKey:(NSString *)key;

+ (id)unarchiverObjectByKey:(NSString *)key;

//删除文件
+ (void)deleteFileWithFileName:(NSString *)fileName filePath:(NSString *)filePath;

@end

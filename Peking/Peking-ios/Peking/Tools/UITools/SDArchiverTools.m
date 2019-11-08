//
//  SDArchiverTools.m
//  Agent
//
//  Created by 七扇门 on 2017/12/11.
//  Copyright © 2017年 七扇门. All rights reserved.
//

#import "SDArchiverTools.h"

@implementation SDArchiverTools

//归档

+ (void)archiverObject:(id)object ByKey:(NSString *)key

{
    
    NSString *filePath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES).firstObject;
    
    NSString *fileName=[filePath stringByAppendingPathComponent:key];
    
    //开始归档
    [NSKeyedArchiver archiveRootObject:object toFile:fileName];
}

//反归档

+ (id)unarchiverObjectByKey:(NSString *)key

{
    NSString *filePath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES).firstObject;
    
    NSString *fileName=[filePath stringByAppendingPathComponent:key];

    //接收反归档得到的对象
    
    id object = [NSKeyedUnarchiver unarchiveObjectWithFile:fileName];
    
    return object;
    
}

 + (void)deleteFileWithFileName:(NSString *)fileName filePath:(NSString *)filePath {
     
    //创建文件管理对象
    NSFileManager *fileManager=[NSFileManager defaultManager];
    //获取文件目录
    if (!filePath) {
        //如果文件目录设置有空,默认删除Cache目录下的文件
        filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    }
    //拼接文件名
    NSString *uniquePath=[filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",fileName]];
    //文件是否存在
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:uniquePath];
    //进行逻辑判断
    if (!blHave) {
        NSLog(@"文件不存在");
        return ;
    }else {
        //文件是否被删除
        BOOL blDele= [fileManager removeItemAtPath:uniquePath error:nil];
        //进行逻辑判断
        if (blDele) {
            NSLog(@"删除成功");
        }else {
            
            NSLog(@"删除失败");
        }
    }
}


@end

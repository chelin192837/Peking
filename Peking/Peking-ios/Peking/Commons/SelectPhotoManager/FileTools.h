//
//  FileTools.h
//  AICity
//
//  Created by wei.z on 2019/7/31.
//  Copyright © 2019 wei.z. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FileTools : NSObject
+(void)removeFileSuffixList:(NSArray<NSString*>*)suffixList filePath:(NSString*)path deep:(BOOL)deep;
+(NSDictionary*)getFileInfo:(NSString*)path;
+(CGFloat)getFileSize:(NSString*)path;
@end

NS_ASSUME_NONNULL_END

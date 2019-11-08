//
//  NSString+lw.h
//  AICity
//
//  Created by wei.z on 2019/7/29.
//  Copyright © 2019 wei.z. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LW)
// 用于生成文件在caches目录中的路径
- (instancetype)cacheDir;
// 用于生成文件在document目录中的路径
- (instancetype)docDir;
// 用于生成文件在tmp目录中的路径
- (instancetype)tmpDir;
@end

NS_ASSUME_NONNULL_END

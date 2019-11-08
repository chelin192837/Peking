//
//  NSData+YYURL.m
//  YYKitDemo
//
//  Created by qsm on 2019/2/20.
//  Copyright © 2019年 ibireme. All rights reserved.
//

#import "NSData+YYURL.h"

@implementation NSData (YYURL)

+ (void)load {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{

        SEL oriUse = @selector(dataWithContentsOfURL:);
        Method oriUseMethod = class_getClassMethod(self, oriUse);
       
        SEL cusUse = @selector(myDataWithContentsOfURL:);
        Method cusUseMethod = class_getClassMethod(self, cusUse);
        
        method_exchangeImplementations(oriUseMethod, cusUseMethod);

    });
    
}

+(nullable instancetype)myDataWithContentsOfURL:(NSURL *)url
{
   UIImage * image = [UIImage imageNamed:@"activityPloceHolder"];
   NSData *imageData = UIImageJPEGRepresentation(image,1.0f);//第二个参数为压缩倍数
    if ([self myDataWithContentsOfURL:url]) {
        return [self myDataWithContentsOfURL:url];
    }else{
        return imageData;
    }
    return nil;
}

@end

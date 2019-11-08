//
//  UIImageView+BSExtension.m
//  
//
//  Created by 七扇门 on 16/8/31.
//  Copyright © 2016年 luotao. All rights reserved.
//

#import "UIImageView+BSExtension.h"
#import "UIImageView+WebCache.h"
#import "UIImage+BSExtension.h"

@implementation UIImageView (BSExtension)


- (void)setCircleHeader:(NSString *)url
{
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *placeholder = [[UIImage imageNamed:@"iconplaceimage"] circleImage];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? [image circleImage] : placeholder;
    }];
    
}


@end

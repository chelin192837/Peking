//
//  CustomGifHeader.h
//  CustomGifRefresh
//
//  Created by WXQ on 2018/8/20.
//  Copyright © 2018年 JingBei. All rights reserved.
//

#import "MJRefreshGifHeader.h"

@interface CustomGifHeader : MJRefreshGifHeader
- (NSArray *)getRefreshingImageArrayWithStartIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex;
- (NSArray *)getImageArrayWithStartIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex;
@end

//
//  BICTopListPageResponse.h
//  Biconome
//
//  Created by 车林 on 2019/8/21.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class ListMarketResponse,getTopListResponse;
@protocol ListMarketResponse <NSObject>

@end


@interface BICTopListPageResponse : BICBaseResponse

@property(nonatomic,strong)ListMarketResponse * data;

@end

@interface ListMarketResponse : BaseModel

@property(nonatomic,strong) NSArray <getTopListResponse>* rows;

@end


NS_ASSUME_NONNULL_END

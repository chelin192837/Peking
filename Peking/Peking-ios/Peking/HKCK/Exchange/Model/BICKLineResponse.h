//
//  BICMarketGetResponse.h
//  Biconome
//
//  Created by 车林 on 2019/8/28.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class kLineResponse,BICKLineResponse;

@protocol BICKLineResponse <NSObject>

@end

@protocol kLineResponse <NSObject>

@end

@interface BICKLineResponse : BICBaseResponse

@property(nonatomic,strong)NSArray<kLineResponse> *data;

@end

@interface kLineResponse : BaseModel

@property(nonatomic,strong)NSString * open;
@property(nonatomic,strong)NSString * close;
@property(nonatomic,strong)NSString * openTime;
@property(nonatomic,strong)NSString * closeTime;
@property(nonatomic,strong)NSString * lowest;
@property(nonatomic,strong)NSString * highest;
@property(nonatomic,strong)NSString * total;
@property(nonatomic,strong)NSString * date;
@property(nonatomic,strong)NSString * timestamp;


@end

NS_ASSUME_NONNULL_END

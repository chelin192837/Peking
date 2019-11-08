//
//  BICMarketGetResponse.h
//  Biconome
//
//  Created by 车林 on 2019/8/28.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class GetHistoryListResponse,BICGetHistoryListResponse;

@protocol BICGetHistoryListResponse <NSObject>

@end

@protocol GetHistoryListResponse <NSObject>

@end

@interface BICGetHistoryListResponse : BICBaseResponse

@property(nonatomic,strong)NSArray<GetHistoryListResponse> *data;

@end

@interface GetHistoryListResponse : BaseModel

@property(nonatomic,strong)NSString * makerPrice;
@property(nonatomic,strong)NSString * tradingNum;
@property(nonatomic,strong)NSString * coinName;
@property(nonatomic,strong)NSString * unitName;
@property(nonatomic,strong)NSString * createTime;
@property(nonatomic,strong)NSString * tradingType;


@end

NS_ASSUME_NONNULL_END

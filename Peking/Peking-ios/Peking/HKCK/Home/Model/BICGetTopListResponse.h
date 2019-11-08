//
//  BICGetTopListResponse.h
//  Biconome
//
//  Created by 车林 on 2019/8/14.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class BICGetTopListResponse,getTopListResponse;

@protocol BICGetTopListResponse <NSObject>

@end

@protocol getTopListResponse <NSObject>


@end

@interface BICGetTopListResponse : BICBaseResponse

@property (nonatomic,strong) NSArray<getTopListResponse> * data;

@end

@interface getTopListResponse : BaseModel

@property(nonatomic,strong)NSString *currencyPair;
@property(nonatomic,strong)NSString *amount;
@property(nonatomic,strong)NSString *timestamp;
@property(nonatomic,strong)NSString* percent;
@property(nonatomic,strong)NSString *usdAmount;
@property(nonatomic,strong)NSString *cnyAmount;
@property(nonatomic,strong)NSString *hkdAmount;
@property(nonatomic,strong)NSString *eurAmount;
@property(nonatomic,strong)NSString *lowest;
@property(nonatomic,strong)NSString *highest;
@property(nonatomic,strong)NSString *open;
@property(nonatomic,strong)NSString *total;
@property(nonatomic,strong)NSString *logoaddr;
@property(nonatomic,strong)NSString *isCollection;

@end

NS_ASSUME_NONNULL_END

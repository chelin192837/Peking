//
//  BICMarketGetResponse.h
//  Biconome
//
//  Created by 车林 on 2019/8/28.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class GetGasConfigResponse,BICGetGasConfigResponse;

@protocol BICGetGasConfigResponse <NSObject>

@end

@protocol GetGasConfigResponse <NSObject>

@end

@interface BICGetGasConfigResponse : BICBaseResponse

@property(nonatomic,strong)GetGasConfigResponse *data;

@end

@interface GetGasConfigResponse : BaseModel

@property(nonatomic,strong)NSString * gasPrice;
@property(nonatomic,strong)NSString * gasTokenType;
@property(nonatomic,strong)NSString * gasTokenSymbol;
@property(nonatomic,strong)NSString * gasTokenName;
@property(nonatomic,strong)NSString * minWdAmount;

@end

NS_ASSUME_NONNULL_END

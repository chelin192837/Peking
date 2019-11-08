//
//  BICCoinAndUnitResponse.h
//  Biconome
//
//  Created by 车林 on 2019/8/28.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BICBaseResponse.h"
#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class BUYSALE_ORDERS,CoinAndUnitResponse,BICCoinAndUnitResponse;

@protocol BICCoinAndUnitResponse <NSObject>

@end

@protocol CoinAndUnitResponse <NSObject>

@end


@protocol BUYSALE_ORDERS <NSObject>

@end

@interface BICCoinAndUnitResponse : BICBaseResponse

@property(nonatomic,strong)CoinAndUnitResponse * data;

@end

@interface CoinAndUnitResponse : BaseModel

@property(nonatomic,strong) NSArray <BUYSALE_ORDERS>* BUY_ORDERS;
@property(nonatomic,strong) NSArray <BUYSALE_ORDERS>* SELL_ORDERS;


@end

@interface BUYSALE_ORDERS : BaseModel

@property(nonatomic,strong)NSString * unitPrice;
@property(nonatomic,strong)NSString * totalNum;
@property(nonatomic,strong)NSString * totalLastNum;
@property(nonatomic,strong)NSString * unitName;
@property(nonatomic,strong)NSString * coinName;
@property(nonatomic,strong)NSString * tradingType;

@property(nonatomic,strong)NSString * totalNumStr;
@property(nonatomic,strong)NSString * totalLastNumStr;

@property(nonatomic,assign)double percent;

@end


NS_ASSUME_NONNULL_END

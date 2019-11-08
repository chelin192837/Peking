//
//  BICSystemImageResponse.h
//  Biconome
//
//  Created by 车林 on 2019/8/10.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BICBaseResponse.h"
#import "BaseModel.h"
NS_ASSUME_NONNULL_BEGIN

@class SystemDataResponse,RowsResponse,BICSystemImageResponse;

@protocol BICSystemImageResponse <NSObject>

@end

@protocol SystemDataResponse <NSObject>


@end

@protocol RowsResponse <NSObject>

@end

@interface BICSystemImageResponse : BICBaseResponse

@property(nonatomic,strong)SystemDataResponse * data;

@end

@interface SystemDataResponse : BaseModel

@property(nonatomic,strong) NSArray <RowsResponse>* rows;

@end

@interface RowsResponse : BaseModel

@property(nonatomic,strong)NSString * fileUrl;

@property(nonatomic,strong)NSString * jumpUrl;

@property(nonatomic,strong)NSString * title;

@end


NS_ASSUME_NONNULL_END

//
//  BICGetTopListResponse.h
//  Biconome
//
//  Created by 车林 on 2019/8/14.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class BICAppStoreResponse,getdataResponse;

@protocol BICAppStoreResponse <NSObject>

@end

@protocol getdataResponse <NSObject>


@end

@interface BICAppStoreResponse : BICBaseResponse

@property (nonatomic,strong) getdataResponse * data;

@end

@interface getdataResponse : BaseModel

@property(nonatomic,copy)NSString *version;
@property(nonatomic,copy)NSString *appUrl;
@property(nonatomic,copy)NSString *remark;
@property(nonatomic,copy)NSString *compel;
@property(nonatomic,copy)NSString *device;
@end

NS_ASSUME_NONNULL_END

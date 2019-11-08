//
//  BICAuthInfoResponse.h
//  Biconome
//
//  Created by 车林 on 2019/8/12.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BICBaseResponse.h"
#import "BaseModel.h"
NS_ASSUME_NONNULL_BEGIN

@class Relation,BICRelationResponse;

@protocol BICRelationResponse <NSObject>

@end

@protocol Relation <NSObject>

@end

@interface BICRelationResponse : BICBaseResponse

@property(nonatomic,strong)Relation* data;

@end

@interface Relation : BaseModel
@property(nonatomic,copy)NSString* commission;
@property(nonatomic,copy)NSString* directPerson;
@property(nonatomic,copy)NSString* indirectPerson;


@end



NS_ASSUME_NONNULL_END

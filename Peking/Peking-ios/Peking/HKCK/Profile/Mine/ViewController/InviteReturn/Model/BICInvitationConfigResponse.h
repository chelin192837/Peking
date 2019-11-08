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

@class InvitationConfig,BICInvitationConfigResponse;

@protocol BICInvitationConfigResponse <NSObject>

@end

@protocol InvitationConfig <NSObject>

@end

@interface BICInvitationConfigResponse : BICBaseResponse

@property(nonatomic,strong)InvitationConfig* data;

@end

@interface InvitationConfig : BaseModel
@property(nonatomic,copy)NSString* startTime;
@property(nonatomic,copy)NSString* endTime;
@property(nonatomic,copy)NSString* returnDays;
@property(nonatomic,copy)NSString* maxQuota;
@property(nonatomic,copy)NSString* directPercent;
@property(nonatomic,copy)NSString* indirectPercent;
@property(nonatomic,copy)NSString* hours;

@end



NS_ASSUME_NONNULL_END

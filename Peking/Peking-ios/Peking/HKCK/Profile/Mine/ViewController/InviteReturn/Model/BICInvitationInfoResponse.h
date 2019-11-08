//
//  BICListUserResponse.h
//  Biconome
//
//  Created by 车林 on 2019/8/24.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BICBaseResponse.h"
#import "BaseModel.h"
NS_ASSUME_NONNULL_BEGIN

@class InvitationInfo,InvitationInfoResponse,BICInvitationInfoResponse;

@protocol BICInvitationInfoResponse <NSObject>

@end

@protocol InvitationInfoResponse <NSObject>


@end

@protocol InvitationInfo <NSObject>

@end

@interface BICInvitationInfoResponse : BICBaseResponse

@property(nonatomic,strong)InvitationInfoResponse * data;

@end

@interface InvitationInfoResponse : BaseModel

@property(nonatomic,strong) NSArray <InvitationInfo>* rows;

@end

@interface InvitationInfo : BaseModel

@property(nonatomic,assign)int index;


@property(nonatomic,strong)NSString * tel;
@property(nonatomic,strong)NSString * mail;
@property(nonatomic,strong)NSString * createTime;
@property(nonatomic,strong)NSString * relation;

@property(nonatomic,assign)BOOL isEffective;

@property(nonatomic,strong)NSString * pidTel;
@property(nonatomic,strong)NSString * pidMail;
@property(nonatomic,strong)NSString * commission;

@property(nonatomic,strong)NSString * amount;



@end



NS_ASSUME_NONNULL_END


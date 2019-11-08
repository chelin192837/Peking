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

@class AuthInfo,BICAuthInfoResponse;

@protocol BICAuthInfoResponse <NSObject>

@end

@protocol AuthInfo <NSObject>

@end

@interface BICAuthInfoResponse : BICBaseResponse

@property(nonatomic,strong)AuthInfo* data;

@end

@interface AuthInfo : BaseModel
@property(nonatomic,copy)NSString* name;
@property(nonatomic,copy)NSString* middleName;
@property(nonatomic,copy)NSString* familyName;
@property(nonatomic,copy)NSString* birthday;
@property(nonatomic,copy)NSString* gender;
@property(nonatomic,copy)NSString* age;
@property(nonatomic,copy)NSString* address;
@property(nonatomic,copy)NSString* country;
@property(nonatomic,copy)NSString* city;
@property(nonatomic,copy)NSString* postcode;
//证件类型，1身份证，2护照，3驾照
@property(nonatomic,copy)NSString* cardType;
@property(nonatomic,copy)NSString* issueCountry;
@property(nonatomic,copy)NSString* idNumber;
@property(nonatomic,copy)NSString* cardBeginTimeStr;
@property(nonatomic,copy)NSString* cardLastTimeStr;
@property(nonatomic,copy)NSString* cardBeginTime;
@property(nonatomic,copy)NSString* cardLastTime;
@property(nonatomic,copy)NSString* fileUrl1;
@property(nonatomic,copy)NSString* fileUrl2;
@property(nonatomic,copy)NSString* fileUrl3;
//审核状态:等待审核(W)、同意(Y)、驳回(N)
@property(nonatomic,copy)NSString* status;
@property(nonatomic,copy)NSString* remark;
@end



NS_ASSUME_NONNULL_END

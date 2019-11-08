//
//  BICBindGoogleRequest.h
//  Biconome
//
//  Created by 车林 on 2019/9/4.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICAuthInfoRequest : BICBaseRequest
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
@property(nonatomic,copy)NSArray* files;
@end

NS_ASSUME_NONNULL_END

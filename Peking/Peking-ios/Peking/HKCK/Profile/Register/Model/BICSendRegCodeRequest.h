//
//  BICSendRegCodeRequest.h
//  Biconome
//
//  Created by 车林 on 2019/8/12.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICSendRegCodeRequest : BICBaseRequest

@property(nonatomic,strong)NSString *tel;

@property(nonatomic,strong)NSString *internationalCode;

@property(nonatomic,strong)NSString *type;

@end

NS_ASSUME_NONNULL_END

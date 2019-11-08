//
//  BICBaseResponse.h
//  Biconome
//
//  Created by 车林 on 2019/8/10.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BICBaseResponse : JSONModel
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSString  *msg;

@end

NS_ASSUME_NONNULL_END

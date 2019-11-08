//
//  BICInviteReturnModel.h
//  Biconome
//
//  Created by 车林 on 2019/10/8.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICInviteReturnModel : NSObject
@property(nonatomic,strong)NSString* titlePrecent;
@property(nonatomic,strong)NSString* returnPrice;
@property(nonatomic,strong)NSString* directInviter;
@property(nonatomic,strong)NSString* indirectInviter;
@property(nonatomic,strong)NSString* inviterLink;
@property(nonatomic,strong)NSString* inviterCode;

@end

NS_ASSUME_NONNULL_END

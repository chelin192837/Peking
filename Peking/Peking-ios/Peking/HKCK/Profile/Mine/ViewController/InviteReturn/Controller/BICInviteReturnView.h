//
//  BICInviteReturnVC.h
//  Biconome
//
//  Created by 车林 on 2019/10/5.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BICInviteReturnModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BICInviteReturnView : UIView

-(instancetype)initWithNib;

@property(nonatomic,strong) BICInviteReturnModel * inviteReturnModel;

@end

NS_ASSUME_NONNULL_END

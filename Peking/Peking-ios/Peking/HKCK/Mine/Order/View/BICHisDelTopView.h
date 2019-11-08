//
//  BICHisDelTopView.h
//  Biconome
//
//  Created by 车林 on 2019/8/29.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BICListUserResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface BICHisDelTopView : UIView

-(instancetype)initWithNib;

@property(nonatomic,strong)ListUserRowsResponse *response;

@end

NS_ASSUME_NONNULL_END

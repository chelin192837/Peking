//
//  BICMineHeadView.h
//  Biconome
//
//  Created by 车林 on 2019/8/31.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICMineHeadView : UIView

-(instancetype)initWithNib;
@property (nonatomic, copy) void (^presentItemOperationBlock)(void);
@end

NS_ASSUME_NONNULL_END

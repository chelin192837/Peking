//
//  BICEXCNavigation.h
//  Biconome
//
//  Created by 车林 on 2019/8/24.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^TitleBlock) (void);
typedef void(^RightBlock) (void);

@interface BICEXCNavigation : UIView

@property(nonatomic,copy)TitleBlock titleBlock;

@property(nonatomic,copy)RightBlock rightBlock;

-(instancetype)initWithNibTitleBlock:(TitleBlock)titleBlock RightBlock:(RightBlock)rightBlock;

@end

NS_ASSUME_NONNULL_END

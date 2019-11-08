//
//  BICEXCLeftLine.h
//  Biconome
//
//  Created by 车林 on 2019/8/26.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BICEXCHorLine.h"

NS_ASSUME_NONNULL_BEGIN

@interface BICEXCLeftLine : UIView
-(instancetype)initWithNibWith:(HorLineType)type;

@property(nonatomic,assign)HorLineType type;

@property(nonatomic,strong)BUYSALE_ORDERS* model;

-(void)setupUI:(HorLineType)type;

@end

NS_ASSUME_NONNULL_END

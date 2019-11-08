//
//  BICEXCRightLine.h
//  Biconome
//
//  Created by 车林 on 2019/8/24.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BICEXCHorLine.h"
#import "BICCoinAndUnitResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface BICEXCRightLine : UIView
-(instancetype)initWithNibWith:(HorLineType)type;

@property(nonatomic,assign)HorLineType type;

@property(nonatomic,strong)BUYSALE_ORDERS* model;
-(void)setModelRever:(BUYSALE_ORDERS *)model;
-(void)setupUIRever:(HorLineType)type;
-(void)setupUI:(HorLineType)type;


@end

NS_ASSUME_NONNULL_END

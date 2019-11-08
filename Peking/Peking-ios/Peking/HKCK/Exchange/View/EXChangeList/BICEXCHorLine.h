//
//  BICEXCHorLine.h
//  Biconome
//
//  Created by 车林 on 2019/8/24.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BICCoinAndUnitResponse.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,HorLineType)
{
    HorLineType_red=99,
    HorLineType_Green
};
@interface BICEXCHorLine : UIView

@property(nonatomic,assign)HorLineType type;

@property(nonatomic,strong)NSArray* arr;

@property(nonatomic,strong)NSArray* arrLeft;

@property(nonatomic,strong)NSArray* arrMidArr;
@property(nonatomic,assign)BOOL isRever;
-(instancetype)initWithFrame:(CGRect)frame With:(HorLineType)type;

-(instancetype)initWithLeftFrame:(CGRect)frame With:(HorLineType)type;

-(instancetype)initWithMiddenFrame:(CGRect)frame With:(HorLineType)type;

@end

NS_ASSUME_NONNULL_END

//
//  BICEXCLeftLine.h
//  Biconome
//
//  Created by 车林 on 2019/8/26.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BICEXCHorLine.h"
#import "BICGetHistoryListResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface BICEXCMiddenLine : UIView
-(instancetype)initWithNibWith:(HorLineType)type;

@property(nonatomic,assign)HorLineType type;

@property(nonatomic,strong)GetHistoryListResponse* model;

-(void)setupUI:(HorLineType)type;

@end

NS_ASSUME_NONNULL_END

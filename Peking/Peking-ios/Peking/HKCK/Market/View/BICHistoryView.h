//
//  BICHistoryView.h
//  Biconome
//
//  Created by 车林 on 2019/8/21.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ClearBlock)(void);

@interface BICHistoryView : UIView

-(instancetype)initWithFrame:(CGRect)frame;

@property(nonatomic,copy)ClearBlock clearBlock;

@property(nonatomic,strong)NSArray* historyDataArray;


@end

NS_ASSUME_NONNULL_END

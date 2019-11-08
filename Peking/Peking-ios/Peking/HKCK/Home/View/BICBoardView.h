//
//  BICBoardView.h
//  Biconome
//
//  Created by 车林 on 2019/8/19.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICBoardView : UIView

-(instancetype)initWithFrame:(CGRect)frame;
-(void)setupUI:(NSArray*)titleArray;
@end

NS_ASSUME_NONNULL_END

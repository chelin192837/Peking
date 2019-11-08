//
//  RSDZXYNavition.h
//  Agent
//
//  Created by qsm on 2018/9/29.
//  Copyright © 2018年 七扇门. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ODBaseViewController.h"
#import "BICMarketGetResponse.h"

typedef void(^TapBlock)(NSString*str,NSInteger index);

typedef void(^BackTo)(void);

typedef void(^TapLeftBlock)(void);

@interface RSDZXYNavition : UIView

@property (nonatomic,copy) TapBlock tapBlock ;

@property (nonatomic,copy) TapLeftBlock tapLeftBlock ;

@property (nonatomic,copy) BackTo backTo ;

@property (nonatomic, strong) BICMarketGetResponse * marketGetResponse;

-(instancetype)initWithTitle:(NSString*)title
                 RightHidden:(BOOL)index
                    TapBlock:(TapBlock)tapBlock
                TapLeftBlock:(TapLeftBlock)tapLeftBlock
                      BackTo:(BackTo)backTo
                  ValueArray:(NSArray*)array
                      Hidden:(BOOL)hidden;

@end

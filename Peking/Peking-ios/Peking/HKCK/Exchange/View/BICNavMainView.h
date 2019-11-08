//
//  BICNavMainView.h
//  Biconome
//
//  Created by 车林 on 2019/8/24.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BICMainCurrencyResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface BICNavMainView : UIView

+(instancetype)sharedInstance;

-(void)show:(BICMainCurrencyResponse *)resopnseM SuperView:(UIViewController*)viewController;
-(void)show:(BICMainCurrencyResponse *)resopnseM;


@end

NS_ASSUME_NONNULL_END

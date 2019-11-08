//
//  ODZXYDropView.h
//  OneDoor
//
//  Created by 车林 on 2019/6/12.
//  Copyright © 2019年 Yujing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BtnBlock)(UIButton* button);

@interface ODZXYDropView : UIView

+(instancetype)shareInstacne;

-(void)setValueArray:(NSArray*)array
           SuperView:(UIView*)superView
              Button:(UIButton*)button
            BtnBlock:(BtnBlock)btnBlock;

@end

NS_ASSUME_NONNULL_END

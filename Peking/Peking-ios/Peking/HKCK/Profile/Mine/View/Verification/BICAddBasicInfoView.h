//
//  BICBasicInfoView.h
//  Biconome
//
//  Created by a on 2019/10/5.
//  Copyright © 2019 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BICTextFileView.h"
#import "BICAuthInfoResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface BICAddBasicInfoView : UIView
@property (nonatomic, copy) void (^dataSelectItemOperationBlock)(void);
@property (strong, nonatomic)  BICTextFileView *birthtextField;
@property (strong, nonatomic)  UIButton *subButton;
@property(nonatomic,strong)BICAuthInfoResponse *response;
@end

NS_ASSUME_NONNULL_END

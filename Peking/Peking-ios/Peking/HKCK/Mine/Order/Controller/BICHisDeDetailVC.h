//
//  BICHisDeDetailVC.h
//  Biconome
//
//  Created by 车林 on 2019/8/29.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICHisDeDetailVC : BaseViewController
@property(nonatomic,strong)NSString * orderId;
@property(nonatomic,strong)ListUserRowsResponse * model;
@end

NS_ASSUME_NONNULL_END

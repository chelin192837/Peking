//
//  BICWallSaveCell.h
//  Biconome
//
//  Created by 车林 on 2019/8/31.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BICGetWalletsResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface BICWallSaveCell : UITableViewCell
+(instancetype)exitWithTableView:(UITableView*)tableView;
@property(nonatomic,strong)GetWalletsResponse * response;

@property(nonatomic,strong)UIViewController * viewController;

@end

NS_ASSUME_NONNULL_END

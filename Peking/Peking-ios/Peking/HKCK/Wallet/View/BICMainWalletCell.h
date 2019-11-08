//
//  BICMainWalletCell.h
//  Biconome
//
//  Created by 车林 on 2019/8/30.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BICGetWalletsResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface BICMainWalletCell : UITableViewCell

+(instancetype)exitWithTableView:(UITableView*)tableView;

@property(nonatomic,strong)GetWalletsResponse * response;

@property (weak, nonatomic) IBOutlet UILabel *balanceLab;

@end

NS_ASSUME_NONNULL_END

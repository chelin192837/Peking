//
//  BICGoogleAuthQRCell.h
//  Biconome
//
//  Created by 车林 on 2019/9/4.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BICBindGoogleResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface BICGoogleAuthQRCell : UITableViewCell
+(instancetype)exitWithTableView:(UITableView*)tableView;
@property(nonatomic,strong)BICBindGoogleResponse * response;

@end

NS_ASSUME_NONNULL_END

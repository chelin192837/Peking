//
//  BICReturnHisCell.h
//  Biconome
//
//  Created by 车林 on 2019/10/6.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BICInvitationInfoResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface BICReturnHisCell : UITableViewCell
+(instancetype)exitWithTableView:(UITableView*)tableView;

@property(nonatomic,strong)InvitationInfo * model;

@end

NS_ASSUME_NONNULL_END

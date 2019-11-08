//
//  BICAboutUsCell.h
//  Biconome
//
//  Created by 车林 on 2019/9/3.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICAboutUsCell : UITableViewCell
+(instancetype)exitWithTableView:(UITableView*)tableView;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@end

NS_ASSUME_NONNULL_END

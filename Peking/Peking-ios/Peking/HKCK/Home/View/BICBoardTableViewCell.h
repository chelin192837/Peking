//
//  BICBoardTableViewCell.h
//  Biconome
//
//  Created by 车林 on 2019/8/10.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICBoardTableViewCell : UITableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

+(instancetype)exitWithTableView:(UITableView*)tableView;

@property (nonatomic,strong) NSArray* titleArray;

@end

NS_ASSUME_NONNULL_END

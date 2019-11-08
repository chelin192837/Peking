//
//  BICPhotoViewCell.h
//  Biconome
//
//  Created by a on 2019/10/6.
//  Copyright © 2019 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICPhotoButtonCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UILabel *subButton;
@end

NS_ASSUME_NONNULL_END

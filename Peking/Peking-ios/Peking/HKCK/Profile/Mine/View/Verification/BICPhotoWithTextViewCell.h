//
//  BICPhotoViewCell.h
//  Biconome
//
//  Created by a on 2019/10/6.
//  Copyright © 2019 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICPhotoWithTextViewCell : UITableViewCell
@property (nonatomic, copy) void (^delClickItemOperationBlock)(void);
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIImageView *bgImgView;
@property(nonatomic,strong)UIImageView *cameraImgView;
@property(nonatomic,strong)UILabel *desLabel;
@property(nonatomic,strong)UIImageView *delImgView;
@end

NS_ASSUME_NONNULL_END

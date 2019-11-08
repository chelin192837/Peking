//
//  BICItemCell.h
//  Biconome
//
//  Created by 车林 on 2019/8/10.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BICGetTopListResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface BICItemCell : UICollectionViewCell

@property(nonatomic,strong)getTopListResponse * model;

@end

NS_ASSUME_NONNULL_END

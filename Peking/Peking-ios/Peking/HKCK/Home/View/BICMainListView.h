//
//  BTCListView.h
//  Biconome
//
//  Created by 车林 on 2019/8/10.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICMainListView : UIView

-(instancetype)init;

-(void)setUIHomeList:(BICGetTopListResponse*)response;

-(void)updateTopList:(NSInteger)count;

@property (nonatomic,strong) NSMutableArray * dealVCArray ;
@end

@interface BICTitleCell : UICollectionViewCell

@property (nonatomic,strong) UILabel *titleLabel;


@end
NS_ASSUME_NONNULL_END

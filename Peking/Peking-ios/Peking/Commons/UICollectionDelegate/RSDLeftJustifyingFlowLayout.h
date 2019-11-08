//
//  RSDLeftJustifyingFlowLayout.h
//  Agent
//
//  Created by wangliang on 2017/9/4.
//  Copyright © 2017年 七扇门. All rights reserved.
//

#import <UIKit/UIKit.h>
UIKIT_EXTERN NSString *const UICollectionElementKindSectionHeader;
UIKIT_EXTERN NSString *const UICollectionElementKindSectionFooter;

@class RSDLeftJustifyingFlowLayout;
@protocol RSDLeftJustifyingFlowLayoutDelegate <NSObject>
@required
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(RSDLeftJustifyingFlowLayout*)collectionViewLayout widthAtIndexPath:(NSIndexPath *)indexPath;

@optional
//section header
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(RSDLeftJustifyingFlowLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
//section footer
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(RSDLeftJustifyingFlowLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;
@end

@interface RSDLeftJustifyingFlowLayout : UICollectionViewFlowLayout
@property (nonatomic, weak) id<RSDLeftJustifyingFlowLayoutDelegate> delegate;
@property (nonatomic, assign) CGPoint endPoint;
@property(nonatomic, assign) CGFloat lineSpacing;  //line space
@property(nonatomic, assign) CGFloat itemSpacing; //item space
@property(nonatomic, assign) CGFloat itemHeight;  //item height

@end

//
//  BICTopSelectHead.h
//  Biconome
//
//  Created by 车林 on 2019/8/23.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^BuyBlock) (void);
typedef void(^SaleBlock) (void);

@interface BICTopSelectHead : UIView

@property(nonatomic,copy)BuyBlock buyBlock;

@property(nonatomic,copy)SaleBlock saleBlock;

-(instancetype)initWithNibBuyBlock:(BuyBlock)buyBlock SaleBlock:(SaleBlock)saleBlock;

-(void)changeTo:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END

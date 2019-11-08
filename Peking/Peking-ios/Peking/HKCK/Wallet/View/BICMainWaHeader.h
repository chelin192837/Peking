//
//  BICMainWaHeader.h
//  Biconome
//
//  Created by 车林 on 2019/8/30.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LeftBlock) (void);
typedef void(^RightBlock) (void);

@interface BICMainWaHeader : UIView

-(instancetype)initWithNib:(LeftBlock)leftBlock RightBlock:(RightBlock)right;

@property(nonatomic,strong)NSArray*arrValue;

@property (weak, nonatomic) IBOutlet UILabel *BTCLab;

@property (weak, nonatomic) IBOutlet UILabel *USDTLab;

-(void)updateTopUI;

@end

NS_ASSUME_NONNULL_END

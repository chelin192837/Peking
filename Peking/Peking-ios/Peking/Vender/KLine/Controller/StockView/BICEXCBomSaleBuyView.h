//
//  BICEXCBomSaleBuyView.h
//  Biconome
//
//  Created by 车林 on 2019/8/26.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICEXCBomSaleBuyView : UIView

-(instancetype)initWithNib;

@property(nonatomic,strong)getTopListResponse * model;

@end

NS_ASSUME_NONNULL_END

//
//  BICEXCChangeDoneView.h
//  Biconome
//
//  Created by 车林 on 2019/8/26.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BICGetHistoryListResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface BICEXCChangeDoneView : UIView
-(instancetype)initWithNib;
@property(nonatomic,strong) BICGetHistoryListResponse * responseM;

@end

NS_ASSUME_NONNULL_END

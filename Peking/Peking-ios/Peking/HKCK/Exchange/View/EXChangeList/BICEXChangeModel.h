//
//  BICEXChangeModel.h
//  Biconome
//
//  Created by 车林 on 2019/8/24.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICEXChangeModel : NSObject

@property(nonatomic,assign)double open;
@property(nonatomic,assign)double close;
@property(nonatomic,assign)long  openTime;
@property(nonatomic,assign)long closeTime;
@property(nonatomic,assign)double lowest;
@property(nonatomic,assign)double highest;
@property(nonatomic,assign)double total;
@property(nonatomic,assign)NSString* date;
@property(nonatomic,assign)long timestamp;

@end

NS_ASSUME_NONNULL_END

//
//  BICSearchNavigation.h
//  Agent
//
//  Created by qsm on 2018/12/6.
//  Copyright © 2018年 七扇门. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SEARCHNAVTYPE) {
    SRARCH_NAV_GREEN = 99,  /**绿色*/
    SRARCH_NAV_WHITE , /***<白色*/
};

typedef void(^SearchBlock)(NSString * str);

typedef void(^CancelBlock)();

typedef void(^BeginBlock)();

@interface BICSearchNavigation : UIView


@property (nonatomic,strong) UISearchBar * searchBar ;

-(instancetype)initWithFrame:(CGRect)frame WithName:(NSString*)str WithSearchResult:(SearchBlock)searchBlock WithCancel:(CancelBlock)cancelBlock WithType:(SEARCHNAVTYPE)type;

-(instancetype)initWithFrame:(CGRect)frame
                    WithName:(NSString*)str
             WithBeginSearch:(BeginBlock)beginBlock
            WithSearchResult:(SearchBlock)searchBlock
                  WithCancel:(CancelBlock)cancelBlock
                    WithType:(SEARCHNAVTYPE)type;

-(instancetype)initWithFrame:(CGRect)frame
                    WithName:(NSString*)str
             WithBeginSearch:(BeginBlock)beginBlock
            WithSearchResult:(SearchBlock)searchBlock
                  WithCancel:(CancelBlock)cancelBlock
                    WithType:(SEARCHNAVTYPE)type
                    WithSuperView:(UIViewController*)superView;

-(instancetype)initNoHisWithFrame:(CGRect)frame
                         WithName:(NSString*)str
                  WithBeginSearch:(BeginBlock)beginBlock
                 WithSearchResult:(SearchBlock)searchBlock
                       WithCancel:(CancelBlock)cancelBlock
                         WithType:(SEARCHNAVTYPE)type
                    WithSuperView:(UIViewController*)superView;
@end

NS_ASSUME_NONNULL_END

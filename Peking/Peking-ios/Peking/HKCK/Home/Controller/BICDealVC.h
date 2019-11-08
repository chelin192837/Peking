//
//  BICDealVC.h
//  Biconome
//
//  Created by 车林 on 2019/8/10.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,BaseViewType)
{
    BaseViewType_Main=99,//首页
    BaseViewType_Market,

};
@interface BICDealVC : BaseViewController

@property(nonatomic,assign)BaseViewType type;

@property(nonatomic,strong)NSString* currency;

@property(nonatomic,strong)NSMutableArray * dataArray;

@property(nonatomic,strong)UITableView *tableView;

@end

NS_ASSUME_NONNULL_END

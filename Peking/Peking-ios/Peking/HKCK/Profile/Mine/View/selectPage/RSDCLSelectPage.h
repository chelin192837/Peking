//
//  RSDCLSelectPage.h
//  Agent
//
//  Created by jj on 2018/1/19.
//  Copyright © 2018年 七扇门. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TypeBlock)(NSString * str,NSIndexPath* indexPath);

typedef NS_ENUM(NSInteger,SelectPage_Type)
{
    SelectPage_Type_Language=99,
    SelectPage_Type_Rate,
    SelectPage_Type_Sex,
    SelectPage_Type_CardType
};

@interface RSDCLSelectPage : BaseViewController

@property (nonatomic,strong) NSArray * dateItemArray;

@property (nonatomic,strong) NSString * titleStr;

@property (nonatomic, copy) TypeBlock typeBlock;

@property (nonatomic, assign)SelectPage_Type selectPageType;


@property (assign, nonatomic) NSIndexPath *selIndex;//单选，当前选中的行
@property (assign, nonatomic) NSInteger editSelIndex;//当前选中的行  编辑时使用


@end

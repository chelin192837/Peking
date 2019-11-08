//
//  AKBaseAlertDialog.h
//  AKBaseAlertDialog
//
//  Created by AK on 16/1/21.
//  Copyright (c) 2015年 www.btjf.com. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum AKButtonType
{
    AKButton_OK,        // 确认性质等按钮
    AKButton_CANCEL,   // 取消性质按钮
    AKButton_OTHER    //其它
    
}AKButtonType;

typedef enum AlertColorStyle
{
    AlertColorStyle_System,  //系统蓝色
    AlertColorStyle_AKRed   //备胎红
}AlertColorStyle;


@class AKAlertDialogItem;
typedef void(^AKAlertDialogHandler)(AKAlertDialogItem *item);
typedef void(^CancleBtnClick)(void);



@interface AKBaseAlertDialog : UIView
{
    UIView *_coverView;
    UIView *_alertView;
    UILabel *_labelTitle;
    UILabel *_labelmessage;
    
    UIScrollView *_buttonScrollView;
    UIScrollView *_contentScrollView;
    
    NSMutableArray *_items;
    NSString *_title;
    NSString *_message;
    NSArray *_messages;

}
//按钮宽度,如果赋值,菜单按钮宽之和,超过alert宽,菜单会滚动
@property(assign,nonatomic)CGFloat buttonWidth;
//将要显示在alert上的自定义view
@property(strong,nonatomic)UIView *contentView;
@property(nonatomic,assign) AlertColorStyle colorStyle; //设置颜色风格
@property(nonatomic,strong) UILabel *labelmessage;
@property (nonatomic, strong) UILabel *labelTitle;
@property(nonatomic,strong) UIImageView *topImageView;
@property(nonatomic,assign) BOOL isTapShadowDismiss; //点阴影消失？
@property(nonatomic,assign) BOOL isToastStyle; //Toast风格？

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message;
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message TopImageName:(NSString *)imageName;
- (instancetype)initWithTitle:(NSString *)title messages:(NSArray<NSString *> *)messages;
- (NSInteger)addButtonWithTitle:(NSString *)title;
- (void)addButton:(AKButtonType)type withTitle:(NSString *)title handler:(AKAlertDialogHandler)handler;
- (void)addTopImage:(NSString *)imageName;
- (void)show;
- (void)dismiss;
@property (nonatomic, copy) CancleBtnClick cancleBtnClick;

@end


@interface AKAlertDialogItem : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic) AKButtonType type;
@property (nonatomic) NSUInteger tag;
@property (nonatomic, copy) AKAlertDialogHandler action;

@end

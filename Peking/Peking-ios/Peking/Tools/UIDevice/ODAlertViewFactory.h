//
//  ODAlertViewFactory.h
//  OneDoor
//
//  Created by coderGL on 16/7/17.
//  Copyright © 2016年 Yujing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKBaseAlertDialog.h"
#import "MBProgressHUD.h"
@class ODVIdeoAgentPersonalInfoModel;

typedef void(^BtnActionHandler)(UIButton *btn);
@interface ODAlertViewFactory : NSObject
#pragma mark - 弹出层AS1
+(AKBaseAlertDialog *)createAS1_Message:(NSString *)message confirmButtonTitle:(NSString *)confirmTitle confirmAction:(AKAlertDialogHandler)confirmAction cancelButtonTitle:(NSString *)cancelTitle cancelAction:(AKAlertDialogHandler)cancelAction;

#pragma mark - 弹出层AS2
+(AKBaseAlertDialog *)createAS2_Title:(NSString *)title message:(NSString *)message confirmButtonTitle:(NSString *)confirmTitle confirmAction:(AKAlertDialogHandler)confirmAction cancelButtonTitle:(NSString *)cancelTitle cancelAction:(AKAlertDialogHandler)cancelAction;

#pragma mark - 弹出层AS3
+(AKBaseAlertDialog *)createAS3_Messages:(NSArray *)messages title:(NSString *)title confirmButtonTitle:(NSString *)confirmTitle confirmAction:(AKAlertDialogHandler)confirmAction;

#pragma mark - 弹出层AS4
+(AKBaseAlertDialog *)createAS4_CloseTip:(NSString *)tip;

#pragma mark - 订单提交成功弹窗
+ (AKBaseAlertDialog *)createAS5_OrderSuccess_Title:(NSString *)title iconImageName:(NSString *)iconImage levelImage:(NSString *)levelImage name:(NSString *)name messAction:(void(^)(void))messAction phoneAction:(void(^)(void))phoneAction dismissAction:(void(^)(void))dismissAction;

#pragma mark - 主播信息弹窗
+(AKBaseAlertDialog *)createAS6_AnchorInfoWithModel:(ODVIdeoAgentPersonalInfoModel *)model andReportHandler:(BtnActionHandler)reportHandler focusHandler:(BtnActionHandler)focusHandler privateHandler:(BtnActionHandler)privateHandler replyHandler:(BtnActionHandler)replyHandler homeHandler:(BtnActionHandler)homeHandler iconHandler:(BtnActionHandler)iconHandler telHandler:(BtnActionHandler)telHandler;
#pragma mark - 确定按钮为黄色 取消按钮为黑色弹框
+ (AKBaseAlertDialog *)createAS7_Message:(NSString *)message confirmButtonTitle:(NSString *)confirmTitle confirmAction:(AKAlertDialogHandler)confirmAction cancelButtonTitle:(NSString *)cancelTitle cancelAction:(AKAlertDialogHandler)cancelAction;
#pragma mark - 自定义弹窗  根据参数不同生成弹窗不同
+(AKBaseAlertDialog *)createBaseDialog_TopImage:(NSString *)imageName Title:(NSString *)title message:(NSString *)message confirmButtonTitle:(NSString *)confirmTitle confirmBtnType:(AKButtonType)confirmType confirmAction:(AKAlertDialogHandler)confirmAction cancelButtonTitle:(NSString *)cancelTitle cancelBtnType:(AKButtonType)cancelType cancelAction:(AKAlertDialogHandler)cancelAction;
#pragma mark - 显示加载数据loadingview
+(MBProgressHUD *)showLoadingViewWithMessage:(NSString *)message;
+(void)hideLoadingHud:(MBProgressHUD *)hud;
+ (void)hideAllHud;
+(void)showToastWithMessage:(NSString *)message;

+(void)showDemo;
+ (MBProgressHUD *)showLoadingViewWithView:(UIView *)view;
+ (void)hideAllHud:(UIView *)view;
@end

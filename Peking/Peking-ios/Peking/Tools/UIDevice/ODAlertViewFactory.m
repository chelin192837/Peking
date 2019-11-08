//
//  ODAlertViewFactory.m
//  OneDoor
//
//  Created by coderGL on 16/7/17.
//  Copyright © 2016年 Yujing. All rights reserved.
//

#import "ODAlertViewFactory.h"
#import "UIImage+GIF.h"

@interface ODAlertViewFactory ()

@property (nonatomic, strong) MBProgressHUD *progressHUD;

@end

@implementation ODAlertViewFactory

static id sharedInstance = nil;
+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (AKBaseAlertDialog *)createAS1_Message:(NSString *)message confirmButtonTitle:(NSString *)confirmTitle confirmAction:(AKAlertDialogHandler)confirmAction cancelButtonTitle:(NSString *)cancelTitle cancelAction:(AKAlertDialogHandler)cancelAction
{
    AKBaseAlertDialog *dialog = [self createMessage:message confirmButtonTitle:confirmTitle confirmBtnType:AKButton_CANCEL confirmAction:confirmAction cancelButtonTitle:cancelTitle cancelBtnType:AKButton_OK cancelAction:cancelAction];
    dialog.labelmessage.font = [UIFont boldSystemFontOfSize:17];
    return dialog;
}

+ (AKBaseAlertDialog *)createAS2_Title:(NSString *)title message:(NSString *)message confirmButtonTitle:(NSString *)confirmTitle confirmAction:(AKAlertDialogHandler)confirmAction cancelButtonTitle:(NSString *)cancelTitle cancelAction:(AKAlertDialogHandler)cancelAction
{
    AKBaseAlertDialog *dialog = [self createBaseDialog_TopImage:nil Title:title message:message confirmButtonTitle:confirmTitle confirmBtnType:AKButton_OK confirmAction:confirmAction cancelButtonTitle:cancelTitle cancelBtnType:AKButton_OK cancelAction:cancelAction];
    dialog.labelTitle.font = [UIFont systemFontOfSize:17];
    return dialog;
}

+ (AKBaseAlertDialog *)createAS3_Messages:(NSArray *)messages title:(NSString *)title confirmButtonTitle:(NSString *)confirmTitle confirmAction:(AKAlertDialogHandler)confirmAction
{
    return [self createMessagesStyleWithTitle:title messages:messages withConfirmTitle:confirmTitle confirmAction:confirmAction];
}


+ (AKBaseAlertDialog *)createAS7_Message:(NSString *)message confirmButtonTitle:(NSString *)confirmTitle confirmAction:(AKAlertDialogHandler)confirmAction cancelButtonTitle:(NSString *)cancelTitle cancelAction:(AKAlertDialogHandler)cancelAction
{
    AKBaseAlertDialog *dialog = [self createMessage:message confirmButtonTitle:confirmTitle confirmBtnType:AKButton_OK confirmAction:confirmAction cancelButtonTitle:cancelTitle cancelBtnType:AKButton_CANCEL cancelAction:cancelAction];
    dialog.labelmessage.font = [UIFont boldSystemFontOfSize:17];
    return dialog;
}


+(AKBaseAlertDialog *)createBaseDialog_TopImage:(NSString *)imageName Title:(NSString *)title message:(NSString *)message confirmButtonTitle:(NSString *)confirmTitle confirmBtnType:(AKButtonType)confirmType confirmAction:(AKAlertDialogHandler)confirmAction cancelButtonTitle:(NSString *)cancelTitle cancelBtnType:(AKButtonType)cancelType cancelAction:(AKAlertDialogHandler)cancelAction{
    
    AKBaseAlertDialog *dialog;
    
    if ([NSString isBlankString:imageName]) {
        dialog = [[AKBaseAlertDialog alloc] initWithTitle:title message:message];
    }else{
        dialog = [[AKBaseAlertDialog alloc] initWithTitle:title message:message TopImageName:imageName];
    }
    
    if (![NSString isBlankString:cancelTitle]) {
        [dialog addButton:cancelType withTitle:cancelTitle handler:cancelAction];
    }
    if (![NSString isBlankString:confirmTitle]) {
        [dialog addButton:confirmType withTitle:confirmTitle handler:confirmAction];
    }
    
    return dialog;
}

+(AKBaseAlertDialog *)createMessage:(NSString *)message confirmButtonTitle:(NSString *)confirmTitle confirmBtnType:(AKButtonType)confirmType confirmAction:(AKAlertDialogHandler)confirmAction cancelButtonTitle:(NSString *)cancelTitle cancelBtnType:(AKButtonType)cancelType cancelAction:(AKAlertDialogHandler)cancelAction
{
    AKBaseAlertDialog *dialog;
    dialog = [[AKBaseAlertDialog alloc] initWithTitle:nil message:message];
    
    if (![NSString isBlankString:confirmTitle]) {
        [dialog addButton:confirmType withTitle:confirmTitle handler:confirmAction];
    }
    if (![NSString isBlankString:cancelTitle]) {
        [dialog addButton:cancelType withTitle:cancelTitle handler:cancelAction];
    }
    return dialog;
}

+(AKBaseAlertDialog *)createMessagesStyleWithTitle:(NSString *)title messages:(NSArray *)messages withConfirmTitle:(NSString *)confirmTitle confirmAction:(AKAlertDialogHandler)confirmAction
{
    AKBaseAlertDialog *dialog;
    if ([NSString isBlankString:title]) {
        title = @"提示";
    }
    dialog = [[AKBaseAlertDialog alloc] initWithTitle:title messages:messages];
    
    if (![NSString isBlankString:confirmTitle]) {
        [dialog addButton:AKButton_OK withTitle:confirmTitle handler:confirmAction];
    }
    
    return dialog;
}





#pragma mark - loading
+ (MBProgressHUD *)showLoadingViewWithMessage:(NSString *)message
{
    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:[self topView] animated:YES];
    [[self topView] addSubview:progressHUD];
    [[self topView] bringSubviewToFront:progressHUD];
    progressHUD.color = [UIColor clearColor];
    progressHUD.mode = MBProgressHUDModeCustomView;
    progressHUD.labelText = nil;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
//    imageView.image =[UIImage sd_animatedGIFNamed:@"hubLoadingGif"];
//    imageView.image =[UIImage sd_animatedGIFNamed:@"Loading24-1"];
    CustomGifHeader* custom=[[CustomGifHeader alloc] init];
    imageView.animationImages= [custom getImageArrayWithStartIndex:1 endIndex:60];
    imageView.animationDuration=5;
    imageView.animationRepeatCount=0;
    imageView.image=[UIImage imageNamed:@"00000"];
    [imageView startAnimating];
    progressHUD.customView = imageView;
    return progressHUD;
}
 
+ (MBProgressHUD *)showLoadingViewWithView:(UIView *)view
{
    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [view addSubview:progressHUD];
    [view bringSubviewToFront:progressHUD];
    progressHUD.color = [UIColor clearColor];
    progressHUD.mode = MBProgressHUDModeCustomView;
    progressHUD.labelText = nil;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
//    imageView.image =[UIImage sd_animatedGIFNamed:@"hubLoadingGif"];
//    imageView.image =[UIImage sd_animatedGIFNamed:@"Loading24-1"];
    CustomGifHeader* custom=[[CustomGifHeader alloc] init];
    imageView.animationImages= [custom getImageArrayWithStartIndex:1 endIndex:60];
    imageView.animationDuration=5;
    imageView.animationRepeatCount=0;
    imageView.image=[UIImage imageNamed:@"00000"];
    [imageView startAnimating];
    progressHUD.customView = imageView;
    return progressHUD;
}
+ (void)hideAllHud:(UIView *)view{
    NSArray *huds = [MBProgressHUD allHUDsForView:view];
    for (MBProgressHUD *hud in huds) {
        if (hud.mode != MBProgressHUDModeText) {
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES];
        }
    }
}
+ (void)hideAllHud
{
    NSArray *huds = [MBProgressHUD allHUDsForView:[self topView]];
    for (MBProgressHUD *hud in huds) {
        if (hud.mode != MBProgressHUDModeText) {
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES];
        }
    }
}

+(void)hideLoadingHud:(MBProgressHUD *)hud
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [hud hide:YES];
    });
}

+ (void)showSuccessWithMessage:(NSString *)message
{
    ODAlertViewFactory *factory = [self sharedInstance];
    
    factory.progressHUD = [MBProgressHUD showHUDAddedTo:[self topView] animated:YES];
    factory.progressHUD.labelText = message;
    factory.progressHUD.minSize = CGSizeMake(150, 150);
    factory.progressHUD.labelFont = [UIFont systemFontOfSize:17];
    [factory.progressHUD hide:YES afterDelay:2];
}

+ (void)showToastWithMessage:(NSString *)message
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[self topView] animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    
    hud.margin = 10.f;
    hud.yOffset = 180;
    hud.yOffset += (-200);
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}

+(UIView*)topView{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    return  window;
}

+ (void)showDemo
{
    
//    AKBaseAlertDialog *dialog = [self createMessagesStyleWithTitle:@"提示多个label" messages:@[@"1了q",@"2地方a",@"3aff",@"4fd"] withConfirmTitle:@"抢客户" confirmAction:^(AKAlertDialogItem *item) {
//        AKBaseAlertDialog *dialog = [self createAS4_CloseTip:@"您已支付成功"];
//        [dialog show];
//        AKBaseAlertDialog *dialog = [self createAS5OrderSuccess_Title:@"您的订单已提交至经纪人，请耐心等待。" tipMessage:@"经纪人联系方式：400-412412479" messAction:^{
//            NSLog(@"mess");
//            ODAnchorInfoModel *model = [[ODAnchorInfoModel alloc] init];
//            model.name = @"彤彤彤彤";
//            model.sex = 1;
//            model.id = @(1234567);
//            model.location = @"北京 朝阳";
//            model.money = @"2356万";
//            model.phoneNum = @"12345678901";
//            model.certification = @(1);
//            model.level = @(6);
//            
//            AKBaseAlertDialog *dialog = [self createAS6_AnchorInfoWithModel:model andReportHandler:^(UIButton *btn) {
//                NSLog(@"举报");
//
//            } focusHandler:^(UIButton *btn) {
//                NSLog(@"关注");
//
//            } privateHandler:^(UIButton *btn) {
//                NSLog(@"私信");
//
//            } replyHandler:^(UIButton *btn) {
//                NSLog(@"回复");
//
//            } homeHandler:^(UIButton *btn) {
//                NSLog(@"主页");
//
//            } iconHandler:^(UIButton *btn) {
//                NSLog(@"头像");
//            }];
//            [dialog show];
//        } phoneAction:^{
//            NSLog(@"phone");
//        }];
//        [dialog show];
//        [ODAlertViewFactory showSuccessWithMessage:@"成功"];
////        [ODAlertViewFactory showLoadingViewWithMessage:@"loading....."];
////    }];
//    AKBaseAlertDialog *dialog = [ODAlertViewFactory createAS2_Title:@"提示" message:@"哈哈哈" confirmButtonTitle:@"确认" confirmAction:^(AKAlertDialogItem *item) {
//        AKBaseAlertDialog *dialog = [ODAlertViewFactory createAS1_Message:@"您是否怎么就放了大世界" confirmButtonTitle:@"确认" confirmAction:^(AKAlertDialogItem *item) {
//            
//        } cancelButtonTitle:@"取消" cancelAction:^(AKAlertDialogItem *item) {
//            
//        }];
//        [dialog show];
//    } cancelButtonTitle:@"取消" cancelAction:^(AKAlertDialogItem *item) {
//        
//    }];
//    [dialog show];
}

@end

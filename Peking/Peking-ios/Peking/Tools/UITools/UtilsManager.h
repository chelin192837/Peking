//
//  UtilsManager.h
//  Agent
//
//  Created by 七扇门 on 2017/9/18.
//  Copyright © 2017年 七扇门. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UILabel+ChangeLineSpaceAndWordSpace.h"

#define Kscale [UIScreen mainScreen].bounds.size.width / 375.0
@interface UtilsManager : UITableViewCell

@property(nonatomic, weak) id viewControl;

#pragma mark +++ UILabel +++

- (void)laytouViewWithindexPath:(NSIndexPath *)indexPath;
/**
 *  自定义文本框
 *
 *  @param frame      文本框坐标 
 *  @param tag        文本框标签 
 *  @param text       文本内容
 *  @param font       文本大小
 *  @param color      文本颜色
 *  @param superView  文本框所属容器
 *  @param alignment  文本的在文本框的显示位置
 */
+ (UILabel *)setLabelWithFrame:(CGRect)frame 
                      labeltag:(NSInteger)tag 
                     labeltext:(NSString *)text 
                      textFont:(float)font 
                     textColor:(UIColor *)color 
                     superView:(UIView *)superView
                 textAlignment:(NSTextAlignment)alignment;



/**
 *  自定义文本框
 *
 *  @param lineBreakMode 字符截断类型
 *  @param color         文本颜色
 */
+ (UILabel *)setLabelWithFrame:(CGRect)frame 
                      labeltag:(NSInteger)tag 
                     labeltext:(NSString *)text 
                     textColor:(UIColor *)color
                      textFont:(float)font 
                     superView:(UIView *)superView
                 lineBreakMode:(NSLineBreakMode)lineBreakMode
                 textAlignment:(NSTextAlignment)alignment;


#pragma mark +++ UIButton +++

/**
 *  自定义按钮
 *
 *  @param frame      坐标 
 *  @param tag        标签 
 *  @param target     响应主体
 *  @param action     响应事件
 *  @param superView  所属容器
 */

+ (UIButton *)setButtonWithFrame:(CGRect)frame 
                          btnTag:(NSInteger)tag 
                       btnTarget:(id)target 
                          action:(SEL)action 
                       superView:(UIView *)superView; 

/**
 *  自定义按钮
 *
 *  @param normalImage      正常状态下背景图 
 *  @param hightlightImage  高亮状态下背景图
 */

+ (UIButton *)setButtonWithFrame:(CGRect)frame 
                          btnTag:(NSInteger)tag 
                       btnTarget:(id)target 
                          action:(SEL)action 
                normalBgImageStr:(NSString *)normalImage 
             highlightBgImageStr:(NSString *)hightlightImage
                       superView:(UIView *)superView; 

/**
 *  自定义按钮
 *
 *  @param title      按钮文本内容
 *  @param font       文本大小
 *  @param color      文本颜色
 */

+ (UIButton *)setButtonWithFrame:(CGRect)frame 
                          btnTag:(NSInteger)tag 
                        btnTitle:(NSString *)title 
                       titleFont:(float)font 
                      titleColor:(UIColor *)color
                       btnTarget:(id)target 
                          action:(SEL)action 
                       superView:(UIView *)superView; 


#pragma mark +++ UIImageView +++


/**
 *  加载网络图片
 *
 *  @param frame                 坐标
 *  @param tag                   标签
 *  @param imageUrl              加载图片url
 *  @param placeholderImageStr   占位图url
 *  @param superView             所属容器
 
 */

+ (UIImageView *)setImageWithFrame:(CGRect)frame 
                          imageUrl:(NSString *)imageUrl 
               placeholderImageStr:(NSString *)placeholderStr
                          imageTag:(NSInteger)tag 
                         superView:(UIView *)superView;


/**
 *  添加本地图片
 *
 *  @param frame                 坐标
 *  @param imageName             图片名称
 *  @param superView             所属容器
 
 */
+ (UIImageView*)setImageWithFrameView:(CGRect)frame 
                            imageName:(NSString *)imageName
                            SuperView:(UIView *)superView;


/**
 *  添加圆角图片（CAShapeLayer and UIBezierPath）
 *
 *  @param frame                 坐标
 *  @param superView             所属容器
 
 */

+ (UIImageView *)setCircularImageWithFrame:(CGRect)frame 
                                 superView:(UIView *)superView;


/**
 *  读取网络数据图片
 *
 *  @param url                   加载图片url
 *  @param placeholderStr        占位图
 *  @param imageView             所属容器
 
 */
+ (void)setServiceImageWithUrl:(NSString *)url 
           placeholderImagestr:(NSString *)placeholderStr 
                  ownImageView:(UIImageView *)imageView;

#pragma mark +++ UITextFiled +++

/**
 *  添加TextField
 *
 *  @param frame         坐标
 *  @param tag           标签
 *  @param font          文字大小
 *  @param text          提示文字    
 *  @param superView     所属容器
 
 */
+ (UITextField *)setTextFieldWithFrame:(CGRect)frame 
                       placeholderText:(NSString *)text 
                                  font:(float)font
                                   tag:(NSInteger)tag 
                             superView:(UIView *)superView;


/**
 *  添加线图
 *
 *  @param frame         坐标
 *  @param superView     所属容器
 
 */

+ (UIView *)setLineViewWithFram:(CGRect)frame
                      superView:(UIView *)superView;

/**
 获取当前控制器

 @return 控制器
 */
+ (UIViewController *)getCurrentVC;

+ (float)heightForString:(NSString *)text
                    font:(float)font
                andWidth:(float)width;

+ (float)weidthForString:(NSString *)text
                    font:(float)font
               andHeight:(float)height;

+ (void)setLabelSpace:(UILabel *)label 
            withValue:(NSString *)str 
             withFont:(UIFont *)font 
            withSpece:(CGFloat)lineSpacing;

+ (CGFloat)getSpaceLabelHeight:(NSString *)str 
                      withFont:(UIFont *)font 
                     withWidth:(CGFloat)width 
                     withSpece:(CGFloat)lineSpacing;

/**
 传入时间戳，返回今天、昨天、星期几。。。。。
 注：时间戳需要10位及以上，包括10位，否则返回“未知时间”
 */
+ (NSString *)achieveDayFormatByTimeString:(NSString *)timeString;


/**
通过URL获取网络图片的原始大小

 @param imageUrl 图片地址
 @return 图片
 */
+ (UIImage *)getSizeFromImageUrl:(NSString *)imageUrl;


+ (CGSize)getImageSizeWithURL:(id)URL;


/**
 @param object  判断是否为空
 @return Bool
 */
+ (BOOL)isNull:(id)object;

+ (BOOL) isEmpty:(NSString *) str;


/**
 @param width  图片宽
 @param width  图片高
 @return 百分比 截取到小数点后两位
 */
+ (CGFloat)getPercentWithImageWidth:(NSString *)width imageHeigth:(NSString *)height;
+ (NSDate *)stringToDate:(NSString *)strdate;
+ (NSString *)dateToString:(NSDate *)date;
+ (UIViewController *)topViewController;
+(NSDate *)getLocalDate:(NSDate *)inputDate;
+ (NSString *)getNowDateFromatAnDate:(NSDate *)anyDate;
+(NSString *)getLocalDateFormateUTCDate:(NSString *)utcStr;
+(NSString *)getUTCDateFormateLocalDate:(NSString *)utcStr;
@end

//
//  UtilsManager.m
//  Agent
//
//  Created by 七扇门 on 2017/9/18.
//  Copyright © 2017年 七扇门. All rights reserved.
//

#import "UtilsManager.h"

@implementation UtilsManager

- (void)laytouViewWithindexPath:(NSIndexPath *)indexPath {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}
+ (UILabel *)setLabelWithFrame:(CGRect)frame 
                      labeltag:(NSInteger)tag 
                     labeltext:(NSString *)text 
                      textFont:(float)font 
                     textColor:(UIColor *)color 
                     superView:(UIView *)superView
                 textAlignment:(NSTextAlignment)alignment {
    
    if (![superView viewWithTag:tag]) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(frame.origin.x *Kscale, frame.origin.y *Kscale, 
                                                                  frame.size.width *Kscale, frame.size.height *Kscale)];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTag:tag];
        [label setText:text];
        [label setTextColor:color];
        [label setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:font]];
        label.textAlignment = alignment;
        [superView addSubview:label];
    }
    else {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(frame.origin.x *Kscale, frame.origin.y *Kscale, 
                                                                  frame.size.width *Kscale, frame.size.height *Kscale)];
        [label setText:text];
        [label setTextColor:color];
        [label setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:font]];
        label.textAlignment = alignment;
        
    }
    
    return (UILabel *)[superView viewWithTag:tag];
}


+ (UILabel *)setLabelWithFrame:(CGRect)frame 
                      labeltag:(NSInteger)tag 
                     labeltext:(NSString *)text 
                     textColor:(UIColor *)color
                      textFont:(float)font 
                     superView:(UIView *)superView
                 lineBreakMode:(NSLineBreakMode)lineBreakMode
                 textAlignment:(NSTextAlignment)alignment {
    UILabel *label = [self setLabelWithFrame:frame 
                                    labeltag:tag 
                                   labeltext:text 
                                    textFont:font 
                                   textColor:color
                                   superView:superView 
                               textAlignment:alignment];
    
    label.lineBreakMode = lineBreakMode;
    
    return label;
}



+ (UIButton *)setButtonWithFrame:(CGRect)frame 
                          btnTag:(NSInteger)tag 
                       btnTarget:(id)target 
                          action:(SEL)action
                       superView:(UIView *)superView {
    if (![superView viewWithTag:tag]) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(frame.origin.x *Kscale, frame.origin.y *Kscale,
                                                                  frame.size.width *Kscale, frame.size.height *Kscale)];
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        [btn setTag:tag];
        [btn setExclusiveTouch:YES];
        [superView addSubview:btn];
    }
    else {
        
        UIButton *btn = (UIButton *)[superView viewWithTag:tag];
        [btn setFrame:frame];
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    return (UIButton *)[superView viewWithTag:tag];
}

+ (UIButton *)setButtonWithFrame:(CGRect)frame 
                          btnTag:(NSInteger)tag 
                       btnTarget:(id)target 
                          action:(SEL)action 
                normalBgImageStr:(NSString *)normalImage 
             highlightBgImageStr:(NSString *)hightlightImage
                       superView:(UIView *)superView {
    
    UIButton *btn = [self setButtonWithFrame:frame btnTag:tag btnTarget:target action:action superView:superView];
    [btn setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:hightlightImage] forState:UIControlStateHighlighted];
    
    return btn;
}

+ (UIButton *)setButtonWithFrame:(CGRect)frame 
                          btnTag:(NSInteger)tag 
                        btnTitle:(NSString *)title 
                       titleFont:(float)font 
                      titleColor:(UIColor *)color
                       btnTarget:(id)target 
                          action:(SEL)action 
                       superView:(UIView *)superView {
    
    UIButton *btn = [self setButtonWithFrame:frame btnTag:tag btnTarget:target action:action superView:superView];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:font]];
    [btn setTitleColor:color forState:UIControlStateNormal];
    
    return btn;
}

+ (UIImageView *)setCircularImageWithFrame:(CGRect)frame 
                                 superView:(UIView *)superView {
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.origin.x *Kscale, frame.origin.y *Kscale,
                                                                          frame.size.width *Kscale, frame.size.height *Kscale)];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:imageView.bounds.size];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = imageView.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    imageView.layer.mask = maskLayer;

    [superView addSubview:imageView];
    
    return imageView;
}

+ (void)setServiceImageWithUrl:(NSString *)url 
           placeholderImagestr:(NSString *)placeholderStr 
                  ownImageView:(UIImageView *)imageView {

    [imageView sd_setImageWithURL:[NSURL URLWithString:url] 
                 placeholderImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:placeholderStr ofType:@"png"]]];
}

+ (UIImageView *)setImageWithFrame:(CGRect)frame 
                          imageUrl:(NSString *)imageUrl 
               placeholderImageStr:(NSString *)placeholderStr
                          imageTag:(NSInteger)tag 
                         superView:(UIView *)superView {
    
    if (![superView viewWithTag:tag]) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.origin.x *Kscale, frame.origin.y *Kscale, 
                                                                              frame.size.width *Kscale, frame.size.height *Kscale)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]
                     placeholderImage:[UIImage imageNamed:placeholderStr]];
        imageView.backgroundColor = [UIColor whiteColor];
        [imageView setTag:tag];
        imageView.layer.masksToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [superView addSubview:imageView];
        
    }
    else {
        UIImageView *imageView = (UIImageView*)[superView viewWithTag:tag];
        [imageView setFrame:CGRectMake(frame.origin.x *Kscale, frame.origin.y *Kscale, 
                                       frame.size.width *Kscale, frame.size.height *Kscale)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]
        placeholderImage:[UIImage imageNamed:placeholderStr]];
    }
    
    return (UIImageView *)[superView viewWithTag:tag];
}


+ (UIImageView*)setImageWithFrameView:(CGRect)frame 
                            imageName:(NSString *)imageName
                            SuperView:(UIView *)superView {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x *Kscale, frame.origin.y *Kscale, 
                                                                           frame.size.width *Kscale, frame.size.height *Kscale)];
    [imageView setImage:[UIImage imageNamed:imageName]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [superView addSubview:imageView];
    
    return imageView;
}


+ (UITextField *)setTextFieldWithFrame:(CGRect)frame 
                       placeholderText:(NSString*)text 
                                  font:(float)font
                                   tag:(NSInteger)tag 
                             superView:(UIView *)superView {
    
    if (![superView viewWithTag:tag]) {
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(frame.origin.x *Kscale, frame.origin.y *Kscale, 
                                                                              frame.size.width *Kscale, frame.size.height *Kscale)];
        textField.placeholder = text;
        textField.tag = tag;
        [textField setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:font]];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.returnKeyType = UIReturnKeyDone;
        textField.contentVerticalAlignment = NSTextAlignmentLeft;
        textField.leftViewMode = UITextFieldViewModeAlways;
        
        [superView addSubview:textField];
    }
    
    return (UITextField *)[superView viewWithTag:tag];
}


+ (UIView *)setLineViewWithFram:(CGRect)frame
                      superView:(UIView *)superView {
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(frame.origin.x *Kscale, frame.origin.y *Kscale, 
                                                               frame.size.width *Kscale, frame.size.height *Kscale)];
    
    lineView.backgroundColor = hexColor(E6E6E6);
    
    [superView addSubview:lineView];
    
    return lineView;
}

+ (UIViewController *)getCurrentVC {
    
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    if (!window) {
        return nil;
    }
    UIView *tempView;
    for (UIView *subview in window.subviews) {
        if ([[subview.classForCoder description] isEqualToString:@"UILayoutContainerView"]) {
            tempView = subview;
            break;
        }
    }
    if (!tempView) {
        tempView = [window.subviews lastObject];
    }
    
    id nextResponder = [tempView nextResponder];
    while (![nextResponder isKindOfClass:[UIViewController class]] || [nextResponder isKindOfClass:[UINavigationController class]] || [nextResponder isKindOfClass:[UITabBarController class]]) {
        tempView =  [tempView.subviews firstObject];
        
        if (!tempView) {
            return nil;
        }
        nextResponder = [tempView nextResponder];
    }
    return  (UIViewController *)nextResponder;
}

+ (UIViewController *)topViewController {
    UIViewController *topVC;
    topVC = [self getTopViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    
    while (topVC.presentedViewController) {
        
        topVC = [self getTopViewController:topVC.presentedViewController];
        
    }
    return topVC;
    
}

+ (UIViewController *)getTopViewController:(UIViewController *)vc {
    
    if (![vc isKindOfClass:[UIViewController class]]) {return nil;}
    if ([vc isKindOfClass:[UINavigationController class]]) {
        
        return [self getTopViewController:[(UINavigationController *)vc topViewController]];
        
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self getTopViewController:[(UITabBarController *)vc selectedViewController]];
        
    } else {
        return vc;
        
    }
    
}


/**
 自定义高度

 @param text    文本内容
 @param font    文本大小
 @param width   文本宽度
 @return        自定义高度
 */
+ (float)heightForString:(NSString *)text
                    font:(float)font
                andWidth:(float)width
{
    CGRect rect =
    [text boundingRectWithSize:CGSizeMake(width , MAXFLOAT)
                       options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                    attributes:@{
                                 NSFontAttributeName : [UIFont fontWithName:@"PingFangSC-Regular" size:font]
                                 }
                       context:nil];
    return rect.size.height;
}


/**
 自定义宽度

 @param text    文本内容
 @param font    文本大小
 @param height  文本高度
 @return        自定义宽度
 */

+ (float)weidthForString:(NSString *)text
                    font:(float)font
               andHeight:(float)height
{
    CGRect rect =
    [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                       options:NSStringDrawingUsesLineFragmentOrigin
                    attributes:@{
                                 NSFontAttributeName : [UIFont fontWithName:@"PingFangSC-Regular" size:font]
                                 }
                       context:nil];
    return rect.size.width;
    
}


/**
 给UILabel设置行间距和字间距

 @param label           控件
 @param str             显示内容
 @param font            文本字体大小
 @param lineSpacing     行间距
 */
+ (void)setLabelSpace:(UILabel *)label 
            withValue:(NSString *)str 
             withFont:(UIFont *)font 
            withSpece:(CGFloat)lineSpacing {
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = lineSpacing; //设置行间距
    paraStyle.hyphenationFactor = 0.5;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    if (str == nil) {
        str = @"";
    }
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
}


/**
 计算UILabel的高度(带有行间距的情况)

 @param str 显示内容
 @param font 文本字体大小
 @param width 控件宽度
 @param lineSpacing 文本行间距
 @return Label高度
 */
+ (CGFloat)getSpaceLabelHeight:(NSString *)str 
                      withFont:(UIFont *)font 
                     withWidth:(CGFloat)width 
                     withSpece:(CGFloat)lineSpacing {
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = lineSpacing;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    [str stringByReplacingOccurrencesOfString:@" " withString:@"k"];
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, kScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}


//判断时间是否是今天 昨天 星期几 几月几日
+ (NSString *)achieveDayFormatByTimeString:(NSString *)timeString;
{
    if (!timeString || timeString.length < 10) {
        return @"时间未知";
    }
    //将时间戳转为NSDate类
    NSTimeInterval time = [[timeString substringToIndex:10] doubleValue];
    NSDate *inputDate=[NSDate dateWithTimeIntervalSince1970:time];
    //
    NSString *lastTime = [self compareDate:inputDate];
    return lastTime;
}

+ (NSString *)dateToString:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    dateFormatter.timeZone=[NSTimeZone timeZoneWithAbbreviation:@"GMT+0900"];
    NSString *strDate = [dateFormatter stringFromDate:date];
//    [dateFormatter release];
    return strDate;
}

+ (NSDate *)stringToDate:(NSString *)strdate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    dateFormatter.timeZone=[NSTimeZone timeZoneWithAbbreviation:@"GMT+0900"];
    NSDate *retdate = [dateFormatter dateFromString:strdate];
//    [dateFormatter release];
    return retdate;
}
+ (NSString *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区

    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0900"];//或GMT

    //
    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区
    //设置转换后的目标日期时区

    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];

    //得到源日期与世界标准时间的偏移量

    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];

    //目标日期与本地时区的偏移量

    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];

    //得到时间偏移量的差值

    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;

    //转为现在时间

    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];

    NSString * dateStr = [UtilsManager dateToString:destinationDateNow];
    return dateStr;

}
+(NSString *)getLocalDateFormateUTCDate:(NSString *)utcStr {
    if(!utcStr || [utcStr isEqualToString:@""]){
        return @"";
    }
     NSDateFormatter *format = [[NSDateFormatter alloc] init];
     format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
     format.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
     NSDate *utcDate = [format dateFromString:utcStr];
     format.timeZone = [NSTimeZone localTimeZone];
     NSString *dateString = [format stringFromDate:utcDate];
     return dateString;
 }

+(NSString *)getUTCDateFormateLocalDate:(NSString *)utcStr {
   if(!utcStr || [utcStr isEqualToString:@""]){
       return @"";
   }
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    format.timeZone = [NSTimeZone localTimeZone];
    NSDate *utcDate = [format dateFromString:utcStr];
    format.timeZone =[NSTimeZone timeZoneWithName:@"UTC"];
    NSString *dateString = [format stringFromDate:utcDate];
    return dateString;
}

+(NSDate *)getLocalDate:(NSDate *)inputDate{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger goalInterval = [zone secondsFromGMTForDate: inputDate];
    NSDate *date = [inputDate  dateByAddingTimeInterval: goalInterval];
    return date;
}
+ (NSString *)compareDate:(NSDate *)inputDate{
    
    //修正8小时的差时
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger goalInterval = [zone secondsFromGMTForDate: inputDate];
    NSDate *date = [inputDate  dateByAddingTimeInterval: goalInterval];
    
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    NSInteger localInterval = [zone secondsFromGMTForDate: currentDate];
    NSDate *localeDate = [currentDate  dateByAddingTimeInterval: localInterval];
    
    //今天／昨天／前天
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    
    NSDate *today = localeDate;
    NSDate *yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    NSDate *beforeOfYesterday = [yesterday dateByAddingTimeInterval: -secondsPerDay];
    
    NSString *todayString = [[today description] substringToIndex:10];
    NSString *yesterdayString = [[yesterday description] substringToIndex:10];
    NSString *beforeOfYesterdayString = [[beforeOfYesterday description] substringToIndex:10];
    
    //今年
    NSString *toYears = [[today description] substringToIndex:4];
    
    //目标时间拆分为 年／月
    NSString *dateString = [[date description] substringToIndex:10];
    NSString *dateYears = [[date description] substringToIndex:4];
    
    NSString *dateContent;
    if ([dateYears isEqualToString:toYears]) {//同一年
        //今 昨 前天的时间
        NSString *time = [[date description] substringWithRange:(NSRange){11,5}];
        //其他时间
        NSString *time2 = [[date description] substringWithRange:(NSRange){5,11}];
        if ([dateString isEqualToString:todayString]){
            //今天
            dateContent = [NSString stringWithFormat:@"%@",time];
            return dateContent;
        } else if ([dateString isEqualToString:yesterdayString]){
            //昨天
            dateContent = [NSString stringWithFormat:@"昨天"];
            return dateContent;
        }else if ([dateString isEqualToString:beforeOfYesterdayString]){
            //前天
            dateContent = [NSString stringWithFormat:@"前天"];
            return dateContent;
        }else{
            if ([self compareDateFromeWorkTimeToNow:time2]) {
                //一周之内，显示星期几
                return [[self class]weekdayStringFromDate:inputDate];
                
            }else{
                //一周之外，显示“月-日 时：分” ，如：05-23 06:22
                return time2;
            }
        }
    }else{
        //不同年，显示具体日期：如，2008-11-11
        return dateString;
    }
}
//比较在一周之内还是之外
+ (BOOL)compareDateFromeWorkTimeToNow:(NSString *)timeStr
{
    //获得当前时间并转为字符串 2017-07-16 07:54:36 +0000(NSDate类)
    NSDate *currentDate = [NSDate date];
    NSDateFormatter*df = [[NSDateFormatter alloc]init];//实例化时间格式类
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//格式化
    NSString *timeString = [df stringFromDate:currentDate];
    timeString = [timeString substringFromIndex:5];
    
    int today = [timeString substringWithRange:(NSRange){3,2}].intValue;
    int workTime = [timeStr substringWithRange:(NSRange){3,2}].intValue;
    if ([[timeStr substringToIndex:2] isEqualToString:[timeString substringToIndex:2]]) {
        if (today - workTime <= 6) {
            return YES;
        }else{
            return NO;
        }
    }else{
        return NO;
    }
}
//返回星期几
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return [weekdays objectAtIndex:theComponents.weekday];
}

+ (UIImage *)getSizeFromImageUrl:(NSString *)imageUrl {

    if ([imageUrl containsString:@"https"]) {
        NSString *str = [imageUrl substringFromIndex:5];
        imageUrl = [@"http" stringByAppendingString:str];
    }
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
    UIImage *image = [UIImage imageWithData:data];
    NSLog(@"w = %f,h = %f",image.size.width,image.size.height);
    
    return image;
}

/**
 *  根据图片url获取图片尺寸
 */
+ (CGSize)getImageSizeWithURL:(id)URL {
    NSURL * url = nil;
    if ([URL isKindOfClass:[NSURL class]]) {
        url = URL;
    }
    if ([URL isKindOfClass:[NSString class]]) {
        url = [NSURL URLWithString:URL];
    }
    if (!URL) {
        return CGSizeZero;
    }
    CGImageSourceRef imageSourceRef =     CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    CGFloat width = 0, height = 0;
    if (imageSourceRef) {
        CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0, NULL);
        if (imageProperties != NULL) {
            CFNumberRef widthNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelWidth);
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat64Type, &width);
            }
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat64Type, &height);
            }
            CFRelease(imageProperties);
        }
        CFRelease(imageSourceRef);
    }
    return CGSizeMake(width, height);
}



+ (BOOL)isNull:(id)object {
    
    // 判断是否为空串
    
    if ([object isEqual:[NSNull null]]) {
        
        return YES;
        
    }
    
    else if ([object isKindOfClass:[NSNull class]])
        
    {
        
        return YES;
        
    }
    
    else if (object==nil){
        
        return YES;
        
    }
    
    return NO;
    
}

//判断内容是否全部为空格 yes 全部为空格 no 不是

+ (BOOL) isEmpty:(NSString *) str {
    
    if(!str) {
        
        return true;
        
    }else {
        
        
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and next line characters (U+000A–U+000D,U+0085).
        
        
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        
        
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        
        if([trimedString length] == 0) {
            
            return true;
            
            
        }else {
            
            
            return false;
            
            
        }
        
    }
    
    
}

+ (CGFloat)getPercentWithImageWidth:(NSString *)width imageHeigth:(NSString *)height {
    
    double img_width = width.doubleValue;
    double img_height = height.doubleValue;
    // 宽高比  
    CGFloat tem_rat = img_width*100/img_height;  
    CGFloat ratio = tem_rat/100;  
    
    NSString *strValue=[NSString stringWithFormat:@"%0.2f", ratio];
    ratio = strValue.floatValue;
    
    return ratio;
}

@end

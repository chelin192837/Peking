//
//  XWCountryCodeController.h
//  XWCountryCodeDemo
//
//  Created by 邱学伟 on 16/4/19.
//  Copyright © 2016年 邱学伟. All rights reserved.
//  国家代码选择界面

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,XWCountry_type)
{
    XWCountry_type_Nav =99,
    XWCountry_type_Other
};
typedef NS_ENUM(NSInteger,XWCountry_Back_Type)
{
    XWCountry_Back_Type_Register =99,
    XWCountry_Back_Type_Varidate
};
typedef void(^returnCountryCodeBlock) (NSString *countryName, NSString *code);

@protocol XWCountryCodeControllerDelegate <NSObject>

@optional

/**
 Delegate 回调所选国家代码

 @param countryName 所选国家
 @param code 所选国家代码
 */
-(void)returnCountryName:(NSString *)countryName code:(NSString *)code;

@end


@interface XWCountryCodeController : BaseViewController

@property (nonatomic, weak) id<XWCountryCodeControllerDelegate> deleagete;

@property (nonatomic, copy) returnCountryCodeBlock returnCountryCodeBlock;

@property (nonatomic, assign) XWCountry_type type;

@property (nonatomic, assign) XWCountry_Back_Type backType;

@property (nonatomic, assign) Boolean isWhiteNavBg;

@end

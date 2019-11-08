//
//  UITextView+Placeholder.m
//  Agent
//
//  Created by qsm on 2018/5/19.
//  Copyright © 2018年 七扇门. All rights reserved.
//

#import "UITextView+Placeholder.h"

@implementation UITextView (Placeholder)

-(void)setPlaceHolder:(NSString*)placeHolderStr placeHoldColor:(UIColor*)color
{
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = placeHolderStr;
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = color;
    placeHolderLabel.font = self.font;
    [placeHolderLabel sizeToFit];
    [self addSubview:placeHolderLabel];

    
    /*
     [self setValue:(nullable id) forKey:(nonnull NSString *)]
     ps: KVC键值编码，对UITextView的私有属性进行修改
     */
    [self setValue:placeHolderLabel forKey:@"_placeholderLabel"];
}
-(void)setPlaceHolderMarginLeft:(NSString*)placeHolderStr placeHoldColor:(UIColor*)color
{
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = placeHolderStr;
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = color;
    placeHolderLabel.font = self.font;
    [placeHolderLabel sizeToFit];
    [self addSubview:placeHolderLabel];
    [placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(14);
        make.top.equalTo(self);
    }];
    /*
     [self setValue:(nullable id) forKey:(nonnull NSString *)]
     ps: KVC键值编码，对UITextView的私有属性进行修改
     */
    [self setValue:placeHolderLabel forKey:@"_placeholderLabel"];

}
@end

//
//  UITextField+Placeholder.m
//  Agent
//
//  Created by qsm on 2018/6/17.
//  Copyright © 2018年 七扇门. All rights reserved.
//

#import "UITextField+Placeholder.h"

@implementation UITextField (Placeholder)
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
-(void)setPlaceHolder:(NSString*)placeHolderStr placeHoldColor:(UIColor*)color off_X:(CGFloat)off_x{
   
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    
    placeHolderLabel.text = [NSString stringWithFormat:@"   %@",placeHolderStr];
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = color;
    placeHolderLabel.font = self.font;
    [self setValue:[NSNumber numberWithFloat:off_x] forKey:@"paddingLeft"];
    placeHolderLabel.x=placeHolderLabel.x + off_x;
    [self addSubview:placeHolderLabel];

    /*
     [self setValue:(nullable id) forKey:(nonnull NSString *)]
     ps: KVC键值编码，对UITextView的私有属性进行修改
     */
    [self setValue:placeHolderLabel forKey:@"_placeholderLabel"];
}
@end

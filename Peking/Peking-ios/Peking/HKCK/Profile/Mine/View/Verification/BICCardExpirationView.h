//
//  UITextFileView.h
//  Biconome
//
//  Created by a on 2019/10/5.
//  Copyright © 2019 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BICCardExpirationView : UIView
@property (strong, nonatomic)  UIView *bgView;
@property (strong, nonatomic)  UITextField *textField;
@property (strong, nonatomic)  UILabel *textLabel;
@property (strong, nonatomic)  UITextField *textField2;
@property (strong, nonatomic)  UIImageView *tipImageView;
@property (nonatomic, copy) void (^dataSelectItemOperationBlock)(int index);
@end

NS_ASSUME_NONNULL_END

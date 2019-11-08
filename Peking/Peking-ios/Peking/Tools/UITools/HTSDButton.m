//
//  HTSDButton.m
//  TableViewDelect
//
//  Created by qsm on 2018/7/25.
//  Copyright © 2018年 yujing. All rights reserved.
//

#import "HTSDButton.h"
@interface HTSDButton()

@property (nonatomic,copy)HTSDButtonBlock htsdBlock ;

@end
@implementation HTSDButton

-(instancetype)initWithFrame:(CGRect)frame WithImage:(NSString *)imageName
{
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI:imageName];
        
    }
    return self ;
}

-(instancetype)initWithBlock:(HTSDButtonBlock)block WithImage:(NSString *)imageName
{
    if (self = [super initWithFrame:CGRectMake(kScreenWidth - 102 - 6, 428*kScaleHeight, 102, 48)]) {
        
        self.htsdBlock = block ;
        
        [self setupUI:imageName];
        
    }
    return self ;
}
-(void)setupUI:(NSString*)imageName
{
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.superview bringSubviewToFront:self];
}

+(instancetype)exit:(HTSDButtonBlock)block WithImage:(NSString *)imageName
{
    HTSDButton * button = [[HTSDButton alloc] initWithFrame:CGRectMake(kScreenWidth - 102 - 6, (428 - kNavBar_Height)*kScaleHeight, 102, 48) WithImage:imageName];
    
    button.htsdBlock = block ;
    
    return button ;
    
}
-(void)buttonClick:(UIButton*)button
{
    if (self.htsdBlock) {
        self.htsdBlock();
    }
}
-(void)remove
{
    [self removeFromSuperview];
}
@end
























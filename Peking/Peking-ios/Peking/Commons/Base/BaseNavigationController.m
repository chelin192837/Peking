//
//  BaseNavigationController.m
//  Agent
//
//  Created by wangliang on 2017/8/24.
//  Copyright © 2017年 七扇门. All rights reserved.
//

#import "BaseNavigationController.h"
#import "AppDelegate.h"
static CGFloat kNavigationBackgroundAlpha = 0.8f;
@interface BaseNavigationController ()<UIGestureRecognizerDelegate>

@property(nonatomic,strong)NSMutableArray * screenSnapImgsArray;
@property(nonatomic,weak)UIImageView *screeenImgView;
@property(nonatomic,weak)UIView *screenCoverView;

@end

@implementation BaseNavigationController

+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    
//        [bar setBackgroundImage:[UIImage imageNamed:@"biaoqianlanBg"] forBarMetrics:UIBarMetricsDefault];
            [bar setBackgroundImage:[UIImage imageFromContextWithColor:kNVABICSYSTEMBGColor] forBarMetrics:UIBarMetricsDefault];
        [bar setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"PingFangSC-Medium" size:18],NSForegroundColorAttributeName:SDColorWhiteFFFFFF}];
    
    [bar setShadowImage:[UIImage imageFromContextWithColor:[UIColor clearColor]]];
    
    // 设置item
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    // UIControlStateNormal
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    
    // UIControlStateDisabled
    NSMutableDictionary *itemDisabledAttrs = [NSMutableDictionary dictionary];
    itemDisabledAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [item setTitleTextAttributes:itemDisabledAttrs forState:UIControlStateDisabled];
    
}

#pragma mark - UINavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器则设置返回按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.adjustsImageWhenHighlighted = NO;
        [button setImage:[UIImage imageNamed:@"fanhuiWhite"] forState:UIControlStateNormal];
       
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 设置这个属性是让按钮内部的所有内容左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.size = CGSizeMake(60, 44);
        // 设置让按钮的内边距，让整体往左边移 5
//        button.contentEdgeInsets = UIEdgeInsetsMake(14, -2, 14, 53);
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 34);
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        // 在内部设置push下一个控制器的时候隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
            
    }
    // 先设置控制器的左上角的返回按钮，再调用push，控制器会创建，自定义其他东西的时候可以覆盖以前的
    // 这句super的push要放在后面，让viewcontroller可以覆盖上面的leftBarButtonItem
    [self makeScreenSnap];
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    [self.screenSnapImgsArray removeLastObject];
    return  [super popViewControllerAnimated:animated];
}

#pragma mark - 私有

- (void)makeScreenSnap{
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size,NO,0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * newScreenSnapImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.screenSnapImgsArray addObject:newScreenSnapImg];
}


#pragma mark - LazyLoading
- (NSMutableArray *)screenSnapImgsArray{
    if (_screenSnapImgsArray == nil) {
        _screenSnapImgsArray = [NSMutableArray array];
    }
    return _screenSnapImgsArray;
}

- (UIImageView *)screeenImgView{
    if (_screeenImgView == nil) {
        UIImageView * imgView = [[UIImageView alloc]init];
        imgView.frame = self.view.bounds;
        [[UIApplication sharedApplication].keyWindow addSubview:imgView];
        [[UIApplication sharedApplication].keyWindow insertSubview:imgView atIndex:0];
        [[UIApplication sharedApplication].keyWindow insertSubview:self.screenCoverView atIndex:1];
        
        _screeenImgView = imgView;
    }
    return _screeenImgView;
}

- (UIView *)screenCoverView{
    if (_screenCoverView == nil) {
        UIView * view = [[UIView alloc]init];
        view.frame = self.view.bounds;
        view.backgroundColor = [UIColor blackColor];
        view.alpha = kNavigationBackgroundAlpha;
        [[UIApplication sharedApplication].keyWindow addSubview:view];
        _screenCoverView = view;
    }
    return _screenCoverView;
    
}
#pragma mark - 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.enabled = NO;
    [self addPanScreenGesture];
}

- (void)addPanScreenGesture{
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    // 如果视图为UITableViewCellContentView（即点击tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    if ([NSStringFromClass([[UtilsManager getCurrentVC] class]) isEqualToString:@"RSDHomeMineTaskPageVC"]) {//添加拖拽按钮 屏蔽手势
        return NO;
    }
    return  YES;
}
- (void)pan:(UIPanGestureRecognizer*)pan{
    
    CGPoint transP = [pan translationInView:self.view];
    
    if (transP.x>0) {
        
        self.view.transform = CGAffineTransformMakeTranslation(transP.x,0);
        
        self.screeenImgView.image = [self.screenSnapImgsArray lastObject];
        
        self.screenCoverView.alpha = 1 - kNavigationBackgroundAlpha *transP.x / (self.view.bounds.size.width/2.0);
//        RSDLog(@"---%lf",1 - kNavigationBackgroundAlpha *transP.x / (self.view.bounds.size.width/2.0));
        if (pan.state == UIGestureRecognizerStateEnded) {
            if (transP.x >= self.view.bounds.size.width/3.0) {
                [UIView animateWithDuration:0.35 animations:^{
                    self.screenCoverView.alpha = 0.0;
                    self.view.transform = CGAffineTransformMakeTranslation(self.view.bounds.size.width,0);
                } completion:^(BOOL finished) {
                    self.view.transform = CGAffineTransformIdentity;
                    [super popViewControllerAnimated:NO];
                    BaseTabBarController *nmTabBarVC = ((AppDelegate*)[UIApplication sharedApplication].delegate).mainController;
                       nmTabBarVC.tabBar.height = kTabBar_Height;
                    [self.screeenImgView removeFromSuperview];
                    [self.screenSnapImgsArray removeLastObject];
                    [self.screenCoverView removeFromSuperview];
                }];
            }else{
                [UIView animateWithDuration:0.35 animations:^{
                    self.screenCoverView.alpha = kNavigationBackgroundAlpha;
                    self.view.transform = CGAffineTransformIdentity;
                } completion:^(BOOL finished) {
                    [self.screeenImgView removeFromSuperview];
                    [self.screenCoverView removeFromSuperview];
                }];
            }
        }
    }
}


#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (self.childViewControllers.count<=1) {
        return NO ;
    }
    return YES;
}


- (void)back
{
    [self popViewControllerAnimated:YES];
}


@end

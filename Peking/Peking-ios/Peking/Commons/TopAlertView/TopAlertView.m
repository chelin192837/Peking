//
//  TopAlertView.m
//  CCTopAlertView
//
//  Created by 崔璨 on 2017/8/22.
//  Copyright © 2017年 cccc. All rights reserved.
//

#import "TopAlertView.h"

#define kAlertViewWidth 191
#define kAlertViewHeight 48

@interface TopAlertView()

@property (nonatomic , assign)NSInteger backCountDown;
@property (nonatomic ,strong)NSTimer *backTimer;

@property (nonatomic , strong)UIImageView *imageV;
@property (nonatomic , strong)UILabel *titleLab;

@property (nonatomic , assign)CGFloat stayTime;

@end

@implementation TopAlertView


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/**

 @param color 背景色
 @param setStayTime 停留时间
 @param imageStr 图片名
 @param titleStr 标题
 @param titleColor 标题字体颜色
 
 */
+ (void)SetUpbackgroundColor:(UIColor *)color andStayTime:(CGFloat)setStayTime andImageName:(NSString *)imageStr andTitleStr:(NSString *)titleStr andTitleColor:(UIColor *)titleColor{
  
    for (UIView *v in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([v isKindOfClass:[TopAlertView class]]) {
            return;
        }
    }
    //计算width
    CGFloat width = 55 + [SDDeviceManager getTextWidth:titleStr FontSize:15.f];
    TopAlertView *alert = [[TopAlertView alloc]initWithFrame:CGRectMake(0,-kAlertViewHeight, width, kAlertViewHeight)];
    [alert setupView:color andStayTime:setStayTime andImageName:imageStr andTitleStr:titleStr  andTitleColor:titleColor];
    [[UIApplication sharedApplication].keyWindow addSubview:alert];

}

- (id)initWithFrame:(CGRect)frame{
  if (self = [super initWithFrame:frame]){
       self.layer.cornerRadius = kBICCornerRadius;
       self.layer.masksToBounds = YES;
       [self setupViews];
       [self startPosition];
       [self setDeclineAnimation];
   }
    return self;
}

- (void)setupViews
{
    self.imageV = [[UIImageView alloc]init];
    [self addSubview: self.imageV];
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.centerY.equalTo(self);
        make.width.height.equalTo(@20);
    }];
    
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.font = [UIFont systemFontOfSize:15.f];
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageV.mas_right).offset(4);
        make.centerY.equalTo(self);
    }];
    
}
- (void)setupView:(UIColor *)color andStayTime:(CGFloat)setStayTime andImageName:(NSString *)imageStr andTitleStr:(NSString *)titleStr andTitleColor:(UIColor *)titleColor
{
    self.stayTime = setStayTime;
    self.backgroundColor = color;
    self.alpha = 1;
    self.imageV.image = [UIImage imageNamed:imageStr];
    self.titleLab.textColor = titleColor;
    self.titleLab.text = titleStr;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touch)];
    [self addGestureRecognizer:singleTap];
}

-(void)touch
{
    [self setGoUpAnimation];
}

//初始位置
- (void)startPosition
{
    self.center = CGPointMake(SCREEN_WIDTH/2, -kAlertViewHeight/2);
}

//最终位置
- (void)endPosition
{
    self.center = CGPointMake(SCREEN_WIDTH/2, kAlertViewHeight/2+64);
}

//下降
- (void)setDeclineAnimation
{
    [UIView animateWithDuration:0.5 animations:^{
        [self endPosition];
    } completion:^(BOOL finished) {
        if (self.stayTime >= 0) {
            [self backTime];
        }
    }];
}

//上升
- (void)setGoUpAnimation
{
     [self.backTimer invalidate];
    [UIView animateWithDuration:0.5 animations:^{
        [self startPosition];
    } completion:^(BOOL finished) {
        [self removeSelf];
    }];
}


- (void)backTime
{
    //设置倒计时总时长
    [self.backTimer invalidate];
    self.backCountDown = self.stayTime;
    self.backTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(viewBackNSTimer) userInfo:nil repeats:YES];
}

//使用NSTimer实现倒计时
- (void)viewBackNSTimer

{
    self.backCountDown -- ;
    if (self.backCountDown == 0  || self.backCountDown < 0) {
        [self.backTimer invalidate];
        [self setGoUpAnimation];
    }
    
}

-(void)removeSelf
{
    [self removeFromSuperview];
}
@end

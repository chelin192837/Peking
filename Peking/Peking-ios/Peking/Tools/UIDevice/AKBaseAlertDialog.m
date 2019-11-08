//
//  AKBaseAlertDialog.m
//  AKBaseAlertDialog
//
//  Created by AK on 16/1/21.
//  Copyright (c) 2015年 www.btjf.com. All rights reserved.
//
#define AlertPadding 22
#define MenuHeight 44

#define AlertHeight 150
#define AlertWidth 270

#define MainViewHeight 150
#define MainViewWidth 270

#import "AKBaseAlertDialog.h"
#import "NSString+Extend.h"
#import "UIView+Extend.h"

@implementation AKAlertDialogItem
@end

@interface AKBaseAlertDialog()<UIGestureRecognizerDelegate>
{
    CGFloat _messagesLabelBottom;
    BOOL _isMessages;
    BOOL _isNoTitle;
}

@property(nonatomic,strong)UITapGestureRecognizer *tapGes;
@property(nonatomic,strong)UIView *mainView;
@property(nonatomic,copy)NSString *topImageName;

@end

@implementation AKBaseAlertDialog
- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message{
    self = [super init];
    if (self) {
        _items = [[NSMutableArray alloc] init];
        _title  = title;
        _message = message;
        _colorStyle = AlertColorStyle_AKRed;
        _isTapShadowDismiss=NO;
        
        [self buildViews];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message TopImageName:(NSString *)imageName{
    self = [super init];
    if (self) {
        _items = [[NSMutableArray alloc] init];
        _title  = title;
        _message = message;
        _colorStyle = AlertColorStyle_AKRed;
        _isTapShadowDismiss=NO;
        _topImageName = imageName;
        
        [self buildViews];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title messages:(NSArray<NSString *> *)messages
{
    self = [super init];
    if (self) {
        _items = [[NSMutableArray alloc] init];
        _title = title;
        _messages = [[NSMutableArray alloc] initWithArray:messages];
        _colorStyle = AlertColorStyle_AKRed;
        _isTapShadowDismiss = NO;
        [self buildMessagesStyleViews];
    }
    return self;
}

- (void)buildMessagesStyleViews
{
    self.frame = [self screenBounds];
    _coverView = [[UIView alloc]initWithFrame:[self topView].bounds];
    _coverView.backgroundColor = [UIColor blackColor];
    _coverView.alpha = 0;
    _coverView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _tapGes=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    _tapGes.delegate=self;
    if (_isTapShadowDismiss) {
        [self addGestureRecognizer:_tapGes];
    }
    [[self topView] addSubview:_coverView];
    
    
    
    _mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainViewWidth, MainViewHeight)];
    _mainView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    _mainView.backgroundColor = [UIColor clearColor];
    [self addSubview:_mainView];
    
    
    
    _alertView = [[UIView alloc]initWithFrame:CGRectMake(0, 30, AlertWidth, AlertHeight)];
    //_alertView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    _alertView.layer.cornerRadius = kLayer_CornerRadius;
    _alertView.layer.masksToBounds = YES;
    _alertView.backgroundColor = [UIColor whiteColor];
    
    [_mainView addSubview:_alertView];
    
    UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dismissBtn.frame = CGRectMake(MainViewWidth-21-8, 37, 21, 21);
    [dismissBtn setBackgroundImage:[UIImage imageNamed:@"dingfang_guanbi"] forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(hideAnimation) forControlEvents:UIControlEventTouchUpInside];
    [_mainView addSubview:dismissBtn];
//    [dismissBtn bringSubviewToFront:_alertView];
    
    //title
    CGFloat labelHeigh = [self heightWithString:_title fontSize:17 width:AlertWidth-2*AlertPadding];
    _labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(AlertPadding, AlertPadding, AlertWidth-2*AlertPadding, labelHeigh)];
    _labelTitle.font = [UIFont boldSystemFontOfSize:20];
    _labelTitle.textColor = [UIColor blackColor];
    _labelTitle.textAlignment = NSTextAlignmentCenter;
    _labelTitle.numberOfLines = 0;
    _labelTitle.text = _title;
    _labelTitle.lineBreakMode = NSLineBreakByCharWrapping;
    [_alertView addSubview:_labelTitle];
    
    CGFloat labelH = 20.f;
    CGFloat labelPadding = 4.f;
    NSString *labelBgColor = @"ebebeb";
    CGFloat width;
    CGFloat labelY = 0;
    CGFloat labelX = 0;
    CGFloat lastLabelW = 0;
    NSInteger lineIndex = 0;
    NSInteger rowIndex = 0;
    for (int i=0; i<_messages.count; i++) {
        CGSize size = [NSString sizeWithString:_messages[i] andMaxSize:CGSizeMake(10000, labelH) andFont:[UIFont systemFontOfSize:14]];
        size.width += 5;
        
        width = AlertPadding + size.width + labelPadding*rowIndex + lastLabelW;
        if (width>(AlertWidth-AlertPadding-10)) {
            lineIndex+=1;
            rowIndex = 0;
            width = AlertPadding + size.width;
            lastLabelW = size.width;
            labelX = AlertPadding + (labelPadding+size.width)*rowIndex;
        }else{
            labelX = width - size.width;
            rowIndex+=1;
            lastLabelW += size.width;
        }
        labelY = _labelTitle.bottom + (labelH+labelPadding)*lineIndex + 7;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, size.width, labelH)];
        label.backgroundColor = [UIColor colorWithHexColorString:labelBgColor];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = _messages[i];
        [_alertView addSubview:label];
    }
    _messagesLabelBottom = labelY+labelH;
    _isMessages = YES;
    
    _contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
    [_alertView addSubview:_contentScrollView];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    [self setColorStyle:AlertColorStyle_AKRed];
    
}

- (void)addDismissBtn
{
    UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dismissBtn.frame = CGRectMake(MainViewWidth-21-8, 37, 21, 21);
    [dismissBtn setBackgroundImage:[UIImage imageNamed:@"dingfang_guanbi"] forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(hideAnimation) forControlEvents:UIControlEventTouchUpInside];
    _isNoTitle = YES;
    [_mainView addSubview:dismissBtn];
}

-(void)buildViews{
    self.frame = [self screenBounds];
    _coverView = [[UIView alloc]initWithFrame:[self topView].bounds];
    _coverView.backgroundColor = [UIColor blackColor];
    _coverView.alpha = 0;
    _coverView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _tapGes=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    _tapGes.delegate=self;
    if (_isTapShadowDismiss) {
        [self addGestureRecognizer:_tapGes];
    }
    [[self topView] addSubview:_coverView];
    
    _mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainViewWidth, MainViewHeight)];
    _mainView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    _mainView.backgroundColor = [UIColor clearColor];
    [self addSubview:_mainView];
    
    _alertView = [[UIView alloc]initWithFrame:CGRectMake(0, 30, AlertWidth, AlertHeight)];
    //_alertView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    _alertView.layer.cornerRadius = kLayer_CornerRadius;
    _alertView.layer.masksToBounds = YES;
    _alertView.backgroundColor = [UIColor whiteColor];
    
    [_mainView addSubview:_alertView];
  
    //title
    CGFloat labelHeigh = [self heightWithString:_title fontSize:17 width:AlertWidth-2*AlertPadding];
    _labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(AlertPadding, AlertPadding, AlertWidth-2*AlertPadding, labelHeigh)];
    _labelTitle.font = [UIFont boldSystemFontOfSize:17];
    _labelTitle.textColor = [UIColor blackColor];
    _labelTitle.textAlignment = NSTextAlignmentCenter;
    _labelTitle.numberOfLines = 0;
    _labelTitle.text = _title;
    _labelTitle.lineBreakMode = NSLineBreakByCharWrapping;
    [_alertView addSubview:_labelTitle];
    
    //message
    CGFloat messageHeigh = [self heightWithString:_message fontSize:14 width:AlertWidth-2*AlertPadding];
    
    if ([NSString isBlankString:_title]) {
        _labelmessage =  [[UILabel alloc]initWithFrame:CGRectMake(AlertPadding, _labelTitle.bottom, AlertWidth-2*AlertPadding, messageHeigh)];
    }else{
        _labelmessage =  [[UILabel alloc]initWithFrame:CGRectMake(AlertPadding, _labelTitle.bottom+AlertPadding/2, AlertWidth-2*AlertPadding, messageHeigh)];
    }
    _labelmessage.font = [UIFont systemFontOfSize:14];
    _labelmessage.textColor = [UIColor blackColor];
    if (messageHeigh>20) {
        _labelmessage.textAlignment = NSTextAlignmentLeft;
    }else{
         _labelmessage.textAlignment = NSTextAlignmentCenter;
    }
    _labelmessage.text = _message;
    _labelmessage.numberOfLines = 0;
    _labelmessage.lineBreakMode = NSLineBreakByCharWrapping;
    _labelmessage.textAlignment = NSTextAlignmentCenter;
    [_alertView addSubview:_labelmessage];
    
    _contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
    [_alertView addSubview:_contentScrollView];
    
    if (![NSString isBlankString:_topImageName]) {
        [self addTopImage:_topImageName];
    }
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    [self setColorStyle:AlertColorStyle_AKRed];
}

-(void)setColorStyle:(AlertColorStyle)colorStyle{
    _colorStyle=colorStyle;
    if (_colorStyle==AlertColorStyle_AKRed) {
        _labelTitle.textColor = [UIColor colorWithHexColorString:@"333333"];
        _labelmessage.textColor = [UIColor colorWithHexColorString:@"333333"];
    }else if (_colorStyle == AlertColorStyle_System) {
        _labelTitle.textColor = [UIColor blackColor];
        _labelmessage.textColor = [UIColor blackColor];
    }
}

-(void)setIsTapShadowDismiss:(BOOL)isTapShadowDismiss{
    if (isTapShadowDismiss!=_isTapShadowDismiss) {
        _isTapShadowDismiss=isTapShadowDismiss;
        if (_isTapShadowDismiss) {
            [self addGestureRecognizer:_tapGes];
        }else{
            [self removeGestureRecognizer:_tapGes];
        }
    }
}

#pragma mark -gestureRecognizer
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isDescendantOfView:_mainView]) {
        return NO;
    }
    return YES;
}

- (void)dealloc
{
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}
-(void)layoutSubviews{
    _buttonScrollView.frame = CGRectMake(0, _alertView.frame.size.height-MenuHeight,_alertView.frame.size.width, MenuHeight);
    _contentScrollView.frame = CGRectMake(0, _labelTitle.frame.origin.y+_labelTitle.frame.size.height, _alertView.frame.size.width, _alertView.frame.size.height-MenuHeight);
    self.contentView.frame = CGRectMake(0,0,self.contentView.frame.size.width, self.contentView.frame.size.height);
    _contentScrollView.contentSize = self.contentView.frame.size;

}
-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [self addButtonItem];
    [_contentScrollView addSubview:self.contentView];
    [self reLayout];
}

-(void)reLayout{

    CGFloat height;
    if (self.contentView) {
        height = _contentView.bottom + AlertPadding + MenuHeight;
    }else{
        height = _labelmessage.bottom + AlertPadding + MenuHeight;
    }
    if (_isMessages) {
        if (_messagesLabelBottom>21) {
            height = _messagesLabelBottom + AlertPadding + MenuHeight;
        }else{
            height = _labelTitle.bottom + AlertPadding + MenuHeight;
        }
    }
    
    if (_isToastStyle) {
        height-=MenuHeight;
        CGSize size = [NSString sizeWithString:_message andMaxSize:CGSizeMake(AlertWidth-2*AlertPadding, 1000) andFont:_labelmessage.font];
        _mainView.width = size.width + 2*AlertPadding;
        _alertView.width = size.width + 2*AlertPadding;
        _labelmessage.width = size.width +3;
    }
    
    _mainView.height = height +30;
    _mainView.center = self.center;
    _alertView.height = height;
    _mainView.y -=15;
    
    [self setNeedsDisplay];
    [self setNeedsLayout];
}
- (CGFloat)heightWithString:(NSString*)string fontSize:(CGFloat)fontSize width:(CGFloat)width
{
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    return  [string boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.height;
}
#pragma mark - add item

-(void)addTopImage:(NSString *)imageName{
    if (!_topImageView) {
        _topImageView=[[UIImageView alloc] initWithFrame:CGRectMake((MainViewWidth-60)/2, 0, 60, 60)];
        _topImageView.image=[UIImage imageNamed:imageName];
        [_mainView addSubview:_topImageView];
        _labelTitle.y+=15;
        _labelmessage.y+=15;
    }
}


- (NSInteger)addButtonWithTitle:(NSString *)title{
    AKAlertDialogItem *item = [[AKAlertDialogItem alloc] init];
    item.title = title;
    item.action =  ^(AKAlertDialogItem *item) {
        NSLog(@"no action");
    };
    item.type = AKButton_OK;
    [_items addObject:item];
    return [_items indexOfObject:title];
}

- (void)addButton:(AKButtonType)type withTitle:(NSString *)title handler:(AKAlertDialogHandler)handler{
    AKAlertDialogItem *item = [[AKAlertDialogItem alloc] init];
    item.title = title;
    item.action = handler;
    item.type = type;
    [_items addObject:item];
    item.tag = [_items indexOfObject:item];
}

- (void)addButtonItem {
    _buttonScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _alertView.frame.size.height- MenuHeight,AlertWidth, MenuHeight)];
    _buttonScrollView.bounces = NO;
    _buttonScrollView.showsHorizontalScrollIndicator = NO;
    _buttonScrollView.showsVerticalScrollIndicator =  NO;
    CGFloat  width;
    if(self.buttonWidth){
        width = self.buttonWidth;
        _buttonScrollView.contentSize = CGSizeMake(width*[_items count], MenuHeight);
    }else
    {
       width = _alertView.frame.size.width/[_items count];
    }
    WEAK_SELF
    [_items enumerateObjectsUsingBlock:^(AKAlertDialogItem *item, NSUInteger idx, BOOL *stop) {
        
        UIButton *button;
        
        //color style
        if (weakSelf.colorStyle==AlertColorStyle_AKRed) {
            button = [UIButton buttonWithType:UIButtonTypeCustom];
            if (item.type == AKButton_OK) {
                [button setTitleColor:SDColorOfGreen00AF36 forState:UIControlStateNormal];
            }else{
                [button setTitleColor:[UIColor colorWithHexColorString:@"333333"] forState:UIControlStateNormal];
            }
        }else{
            button = [UIButton buttonWithType:UIButtonTypeSystem];
        }
        
//        button.translatesAutoresizingMaskIntoConstraints = NO;
        button.frame = CGRectMake(idx*width, 1, width, MenuHeight);
        //seperator
        button.backgroundColor = [UIColor whiteColor];
        button.layer.shadowColor = [[UIColor grayColor] CGColor];
        button.layer.shadowRadius = 0.5;
        button.layer.shadowOpacity = 1;
        button.layer.shadowOffset = CGSizeZero;
        button.layer.masksToBounds = NO;
        button.tag = 90000+ idx;

        // title
        [button setTitle:item.title forState:UIControlStateNormal];
        [button setTitle:item.title forState:UIControlStateSelected];
//        button.titleLabel.font = [UIFont boldSystemFontOfSize:button.titleLabel.font.pointSize];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        // action
        [button addTarget:self
                    action:@selector(buttonTouched:)
          forControlEvents:UIControlEventTouchUpInside];

        [_buttonScrollView addSubview:button];
    }];
    [_alertView addSubview:_buttonScrollView];
    
}

- (void)buttonTouched:(UIButton*)button{
    AKAlertDialogItem *item = _items[button.tag-90000];
    if (item.action) {
        item.action(item);
    }
    [self dismiss];
}
#pragma mark - show and dismiss
-(UIView*)topView{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    return  window;
}
- (void)show {
    __weak typeof(self) wkself = self;
    [UIView animateWithDuration:0.5 animations:^{
        self->_coverView.alpha = 0.5;
    } completion:^(BOOL finished) {
        if (wkself.isToastStyle) {
            if (finished) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [wkself dismiss];
                });
            }
        }
    }];
    
    [[self topView] addSubview:self];
    [self showAnimation];
}

- (void)dismiss {
    [self hideAnimation];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
//    [self removeFromSuperview];
}

- (void)showAnimation {
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [_mainView.layer addAnimation:popAnimation forKey:nil];
}

- (void)hideAnimation{
    __weak typeof(self) wkself = self;
    [UIView animateWithDuration:0.4 animations:^{
        self->_coverView.alpha = 0.0;
        //_alertView.alpha = 0.0;
        self->_mainView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
         [wkself removeFromSuperview];
    }];
}


#pragma mark - Handle device orientation changes
// Handle device orientation changes

- (void)deviceOrientationDidChange: (NSNotification *)notification
{
    //    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    self.frame = [self screenBounds];
    //NSLog(@"self.frame%@",NSStringFromCGRect(self.frame));
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         [self reLayout];
                     }
                     completion:nil
     ];
  
}

//- (void)deviceDidChange:(NSNotification *)notification
//{
//    self.frame = [self screenBounds];
//    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
//        [self reLayoutMessagesFrame];
//    } completion:nil];
//}

- (CGRect)screenBounds
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    // On iOS7, screen width and height doesn't automatically follow orientation
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
        UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
        if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
            CGFloat tmp = screenWidth;
            screenWidth = screenHeight;
            screenHeight = tmp;
        }
    }
    
    return CGRectMake(0, 0, screenWidth, screenHeight);
}
@end

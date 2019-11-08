//
//  XHVerticalScrollview.m
//  VerticalScrollViewPlan
//
//  Created by 牛新怀 on 2017/8/10.
//  Copyright © 2017年 牛新怀. All rights reserved.
//

#import "XHVerticalScrollview.h"
#import "RSDHomeListWebVC.h"
@interface XHVerticalScrollview()<UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView * verticalScroll;
@property (strong, nonatomic) NSMutableArray * mutableArray;

@property (strong, nonatomic)RowsResponse * row;

@end
@implementation XHVerticalScrollview

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect {
    [self addSubview:self.verticalScroll];
    [self setUpTimer];
  
}
-(instancetype)initWithDelegate:(id)delegate
                      DataArray:(NSArray*)dataArray
                        BgColor:(UIColor*)bgColor
                          Frame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = bgColor;
//        self.verticalScroll.frame = frame;
        self.customArray = dataArray;
        self.delegate = delegate;
        
     
    }
    return self;
}

-(void)tap:(UITapGestureRecognizer*)tap
{
    UIView * view = tap.view;
    
    NSInteger index = view.tag-100;
    
    RowsResponse * row = self.mutableArray[index];
    
    RSDHomeListWebVC * webVC = [[RSDHomeListWebVC alloc] init];
    
    webVC.navigationShow = YES;

    webVC.listWebStr = row.jumpUrl;
    
    [self.superview.yq_viewController.navigationController pushViewController:webVC animated:YES];
}

- (void)setUpTimer{
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(changeScrollContentOffSetY) userInfo:nil repeats:YES];
    _myTimer = timer;
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
- (void)invalidateTimer{
    [_myTimer invalidate];
    _myTimer = nil;
}
/*
 @parameter setter

 */

- (void)setCustomArray:(NSArray *)customArray{
    _customArray = customArray;
    if (!_customArray)return;
    self.mutableArray = [NSMutableArray arrayWithArray:_customArray];
    [self initWithDataSourse];
    
}
- (UIScrollView *)verticalScroll{
    if (!_verticalScroll) {
        _verticalScroll = [[UIScrollView alloc]initWithFrame:self.bounds];
        _verticalScroll.showsVerticalScrollIndicator = NO;
        _verticalScroll.scrollEnabled = NO;
        _verticalScroll.bounces = NO;
        _verticalScroll.delegate = self;
        
    }
    return _verticalScroll;
}
- (void)initWithDataSourse{

    for (int i=0; i<_customArray.count; i++) {
        [self.mutableArray addObject:_customArray[i]];
    }
    
    if (_customArray.count>0) {
        [self.mutableArray addObject:_customArray[0]];
    }
    
    for (int i =0; i<self.mutableArray.count; i++) {
        UIView * view = [[UIView alloc]init];
        view.tag = i+100;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [view addGestureRecognizer:tap];
        view.backgroundColor = [UIColor whiteColor];
        view.frame = CGRectMake(0, i*self.verticalScroll.frame.size.height, self.verticalScroll.frame.size.width, self.verticalScroll.frame.size.height);
        view.userInteractionEnabled = YES;
        [self.verticalScroll addSubview:view];

        UILabel * label = [[UILabel alloc]init];
        label.frame = CGRectMake(0, 0, self.verticalScroll.frame.size.width, view.frame.size.height);
        label.textAlignment = NSTextAlignmentCenter;
        RowsResponse * row = self.mutableArray[i];
        label.text = [NSString stringWithFormat:@"%@",row.title];
        label.textColor = kBoardTextColor;
        label.font = [UIFont systemFontOfSize:15.f];
        label.userInteractionEnabled = YES;
        [view addSubview:label];

    }
    
    self.verticalScroll.contentSize = CGSizeMake(0, (self.mutableArray.count)*self.verticalScroll.frame.size.height);

}

// 点击滚动条数据
//- (void)gestureClick:(UITapGestureRecognizer *)gesture{
//    if ([self.delegate respondsToSelector:@selector(didSelectTag:withView:)]) {
//        [self.delegate didSelectTag:gesture.view.tag-Gap withView:self];
//    }
//}

-(void)changeScrollContentOffSetY{
    //启动定时器
    CGPoint point = self.verticalScroll.contentOffset;
    
//    NSInteger index = (NSInteger)(self.verticalScroll.contentOffset.y/self.verticalScroll.height);
//    self.row = self.mutableArray[index];
    
//    NSLog(@"%@",self.row.title);
    
    [self.verticalScroll setContentOffset:CGPointMake(0, point.y+CGRectGetHeight(self.verticalScroll.frame)) animated:YES];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{

    if (scrollView.contentOffset.y==scrollView.contentSize.height-CGRectGetHeight(self.verticalScroll.frame)){
        [scrollView setContentOffset:CGPointMake(0,0)];
    }
    
}
- (NSMutableArray *)mutableArray{
    if (!_mutableArray) {
        _mutableArray = [[NSMutableArray alloc]init];
    }
    return _mutableArray;
}

- (void)dealloc{
    [self invalidateTimer];
}
@end

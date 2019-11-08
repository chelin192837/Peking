//
//  RSDZXYNavition.m
//  Agent
//
//  Created by qsm on 2018/9/29.
//  Copyright © 2018年 七扇门. All rights reserved.
//

#import "RSDZXYNavition.h"
#import "ODZXYDropView.h"

@interface RSDZXYNavition()

@property (nonatomic,strong) NSString * title ;

@property(nonatomic,strong) NSArray* valueArray;

@property(nonatomic,strong) UIButton* rightBtn;

@property(nonatomic,strong) UIButton* rightBtnLeft;

@end

@implementation RSDZXYNavition

-(instancetype)initWithTitle:(NSString*)title
                 RightHidden:(BOOL)index
                    TapBlock:(TapBlock)tapBlock
                TapLeftBlock:(TapLeftBlock)tapLeftBlock
                      BackTo:(BackTo)backTo
                  ValueArray:(NSArray*)array
                      Hidden:(BOOL)hidden
{
    if (self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavBar_Height)]) {
        
        self.title = title;
        
        self.backTo = backTo;
        
        self.tapBlock = tapBlock;
        
        self.tapLeftBlock = tapLeftBlock;
        
        self.valueArray = array ;
        
        self.backgroundColor = kBICWhiteColor;
        
        [self setupUI];
        
    }
    
    return self;
}

-(void)setupUI
{
    
    UIButton* backBtn = [[UIButton alloc] init];
    [backBtn setImage:[UIImage imageNamed:@"fanhuiBlack"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(10);
        make.width.height.equalTo(@40);
        make.left.equalTo(self).offset(7);
    }];

    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = self.title;
    titleLab.textColor = kBICGetHomeTitleColor;
    titleLab.font = [UIFont systemFontOfSize:18.f weight:UIFontWeightHeavy];
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(10);
    }];
    
    UIButton* rightBtn = [[UIButton alloc] init];
    self.rightBtn = rightBtn;

    [rightBtn setImage:[UIImage imageNamed:@"collection"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"collection_highlight"] forState:UIControlStateSelected];
    [rightBtn addTarget:self action:@selector(rightBtnRight:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(10);
        make.width.equalTo(@40);
        make.height.equalTo(@40);
        make.right.equalTo(self).offset(-14);
    }];
    
    UIButton* rightBtnLeft = [[UIButton alloc] init];
    self.rightBtnLeft = rightBtnLeft;
    [rightBtnLeft setImage:[UIImage imageNamed:@"fullscreen"] forState:UIControlStateNormal];
    [rightBtnLeft addTarget:self action:@selector(rightLeft:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBtnLeft];
    [rightBtnLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(10);
        make.width.equalTo(@40);
        make.height.equalTo(@40);
        make.right.equalTo(rightBtn.mas_left).offset(-14);
    }];
//
//    UIButton* rightBtnRight = [[UIButton alloc] init];
//    [rightBtnRight setImage:[UIImage imageNamed:@"collection"] forState:UIControlStateNormal];
//    [rightBtnRight addTarget:self action:@selector(rightBtnRight:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:rightBtnRight];
//    [rightBtnRight mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self).offset(10);
//        make.width.equalTo(@40);
//        make.height.equalTo(@40);
//        make.right.equalTo(rightBtnLeft.mas_left).offset(-4);
//    }];
    
}
-(void)setMarketGetResponse:(BICMarketGetResponse *)marketGetResponse
{
    _marketGetResponse = marketGetResponse;
    if (self.marketGetResponse.data.isCollection) {
//        [self.rightBtn setImage:[UIImage imageNamed:@"collection_highlight"] forState:UIControlStateNormal];
        self.rightBtn.selected=YES;
    }else{
//        [self.rightBtn setImage:[UIImage imageNamed:@"collection"] forState:UIControlStateNormal];
        self.rightBtn.selected=NO;
    }
}
-(void)back:(UIButton*)sender
{
    if (self.backTo) {
        self.backTo();
    }
}

-(void)rightBtnRight:(UIButton*)sender
{
    if (![BICDeviceManager isLogin]) {
        [BICDeviceManager PushToLoginView];
        return;
    }
    if (self.marketGetResponse.data.isCollection) { //取消收藏
        [self analyticalCancelCollectionCurrencyData];
    }else{ //添加收藏
        [self analyticalAddCollectionCurrencyData];
    }
}

-(void)setBtnBgImage
{
    if (self.marketGetResponse.data.isCollection) {
        self.rightBtn.selected=YES;
        //添加收藏
        [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenterBICCancelCollection object:@(YES)];
    }else{
        self.rightBtn.selected=NO;
        //取消收藏
        [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenterBICCancelCollection object:@(NO)];
    }
    
    
    
}
-(void)analyticalAddCollectionCurrencyData
{
    BICKLineRequest * requset = [[BICKLineRequest alloc] init];
    requset.currencyPair = [self.title stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    [[BICMainService sharedInstance] analyticalAddCollectionCurrencyData:requset serverSuccessResultHandler:^(id response) {
        BICBaseResponse * responseM = (BICBaseResponse*)response;
        if (responseM.code==200) {
            self.marketGetResponse.data.isCollection = YES;
            [self setBtnBgImage];
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
    } failedResultHandler:^(id response) {
        
    } requestErrorHandler:^(id error) {
        
    }];
}
-(void)analyticalCancelCollectionCurrencyData
{
    BICKLineRequest * requset = [[BICKLineRequest alloc] init];
    requset.currencyPair = [self.title stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    [[BICMainService sharedInstance] analyticalCancelCollectionCurrencyData:requset serverSuccessResultHandler:^(id response) {
        BICBaseResponse * responseM = (BICBaseResponse*)response;
        if (responseM.code==200) {
            self.marketGetResponse.data.isCollection = NO;
            [self setBtnBgImage];
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
    } failedResultHandler:^(id response) {
        
    } requestErrorHandler:^(id error) {
        
    }];
}

-(void)right:(UIButton*)sender
{
    [[ODZXYDropView shareInstacne] setValueArray:self.valueArray SuperView:self Button:sender BtnBlock:^(UIButton * _Nonnull button) {
        if (button.tag==100) {
            [self.rightBtn setImage:[UIImage imageNamed:@"cny"] forState:UIControlStateNormal];
        }
        if (button.tag==101) {
            [self.rightBtn setImage:[UIImage imageNamed:@"usd"] forState:UIControlStateNormal];
        }
//        [[ODSingleShare shareInstace] setIndexPath:nil RightItem:button.tag-100+1 WithBaseType:self.type];
        if (self.tapBlock) {
            self.tapBlock(self.valueArray[button.tag-100],button.tag-100+1);
        }
    }];
}

-(void)rightLeft:(UIButton*)sender
{
    if (self.tapLeftBlock) {
        self.tapLeftBlock();
    }
}


@end


























































































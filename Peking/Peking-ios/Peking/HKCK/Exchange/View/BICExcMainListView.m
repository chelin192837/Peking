//
//  BTCListView.m
//  Biconome
//
//  Created by 车林 on 2019/8/10.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICExcMainListView.h"
#import "BICItemCell.h"
#import "BICTipMidView.h"
#import "BICDealVC.h"
#import "BICTopSelectHead.h"
#import "BICEXCMainVC.h"
#import "BICExchangeListView.h"
static NSString *kReleaseTitleCollectionCellID = @"kReleaseTitleCollectionCellID";
static NSString *kReleaseContentCollectionCellIDK__ = @"kReleaseContentCollectionCellIDK__";
static NSString *kReleaseContentCollectionCellIDKBtn__ = @"kReleaseContentCollectionCellIDKBtn__";

static NSString *kbtcKindCollectionView = @"kbtcKindCollectionView";
#define TopSelectHeadHeight 60

#define contentColHeight_Change (KScreenHeight-kTabBar_Height-kNavBar_Height-TopSelectHeadHeight)

@interface BICExcMainListView()<UICollectionViewDelegate,UICollectionViewDataSource>

/// 内容 ..
@property (nonatomic,strong) UICollectionView *contentCollectionView;

@property (nonatomic,assign) NSInteger selectedIndex;

@property (nonatomic,assign) BOOL isNotFirstLoad;

@property (nonatomic,strong) NSMutableArray * titleArray ;

@property (nonatomic,strong) NSMutableArray * dealVCArray ;

@property (nonatomic,strong) BICGetTopListResponse * homeResponse ;

@property (nonatomic,strong) BICTipMidView * middenBgView;

@property (nonatomic,strong) BICTopSelectHead * head;

@property (nonatomic,strong) BICExchangeListView *currencyView;
@end

@implementation BICExcMainListView

-(instancetype)init
{
    if (self=[super init]) {
        
        self.backgroundColor = kBICHomeBGColor;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUI) name:NSNotificationCenterUpdateUI object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollToView:) name:NSNotificationCenterScrollToView object:nil];
        

        
    }
    return self;
}

-(void)updateUI
{
    [self.middenBgView updateUI];
}

-(void)setUITitleList
{
    
    [self ConfigVC];
    
    [self setupUI];
    
}

-(void)scrollToView:(NSNotification*)notify
{
    NSNumber *index = notify.object;
    
     [self.contentCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index.integerValue inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    
    [self.head changeTo:index.integerValue];

}

-(void)setupUI
{
    
    BICTopSelectHead * head = [[BICTopSelectHead alloc] initWithNibBuyBlock:^{

        [self.contentCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    } SaleBlock:^{
       
        [self.contentCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];

    }];
    self.head = head;

    [self addSubview:head];
    
    [head mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(@(TopSelectHeadHeight));
    }];
    
    [self addSubview:self.contentCollectionView];
    
    self.selectedIndex = 0;  //默认显示第一个
    
}

-(NSMutableArray*)dealVCArray
{
    if (!_dealVCArray) {
        _dealVCArray = [NSMutableArray array];
    }
    return _dealVCArray;
}

-(void)ConfigVC
{
    for (int i=0; i<2; i++) {
        BICExchangeListView * middenV = [[BICExchangeListView alloc] init];
        if (i==0) {
            middenV.priceType=ChangePriceType_Buy;
        }
        if (i==1) {
            middenV.priceType=ChangePriceType_Sale;
        }
        [self.dealVCArray addObject:middenV];
        
    }
}

- (UICollectionView *)contentCollectionView{
    if (!_contentCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(kScreenWidth, contentColHeight_Change+TopSelectHeadHeight);
        flowLayout.minimumLineSpacing=0.0f ;
        flowLayout.minimumInteritemSpacing = 0.0f ;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _contentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,TopSelectHeadHeight, kScreenWidth,contentColHeight_Change+TopSelectHeadHeight) collectionViewLayout:flowLayout];
        [_contentCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kReleaseContentCollectionCellIDK__];
        _contentCollectionView.delegate = self;
        _contentCollectionView.dataSource = self;
        _contentCollectionView.backgroundColor = kClearBacground;
        _contentCollectionView.showsHorizontalScrollIndicator = NO;
        _contentCollectionView.pagingEnabled = YES;
        _contentCollectionView.bounces = NO;
    }
    return _contentCollectionView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewFlowLayout *tempLayout = (id)collectionViewLayout;
    return tempLayout.itemSize;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 2;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
        NSString *identifier=[NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row];
        
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
        
        UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        for(id subView in cell.contentView.subviews){
            if(subView){
                [subView removeFromSuperview];
            }
        }
        
        cell.backgroundColor = kBICHomeBGColor;
        
        BICExchangeListView *vc = self.dealVCArray[indexPath.item];
        vc.frame=CGRectMake(0, 0, SCREEN_WIDTH,contentColHeight_Change+TopSelectHeadHeight);
        [vc setUITitleList];
 
        [cell addSubview:vc];
        
        return cell;
    
    return nil;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView == self.contentCollectionView) {
        CGFloat width = scrollView.frame.size.width;
        CGFloat offsetX = scrollView.contentOffset.x;
        NSInteger index = offsetX / width;
        
        [self.head changeTo:index];
        
    }
}

@end







//
//  BTCListView.m
//  Biconome
//
//  Created by 车林 on 2019/8/10.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICNavCointListView.h"
#import "BICItemCell.h"
#import "BICTipMidView.h"
#import "BICEXCNavigationVC.h"
#import "UIView+shadowPath.h"
static NSString *kReleaseTitleCollectionCellID = @"kReleaseTitleCollectionCellID";
static NSString *kReleaseContentCollectionCellIDK__ = @"kReleaseContentCollectionCellIDK__";
static NSString *kbtcKindCollectionView = @"kbtcKindCollectionView";
#define contentColHeight (382-CGRectGetMaxY(self.titleCollectionView.frame)-48)

@interface BICNavCointListView()<UICollectionViewDelegate,UICollectionViewDataSource>

//币种类 
@property (nonatomic,strong) UICollectionView *btcKindCollectionView;
/// 涨幅榜 ...
@property (nonatomic,strong) UICollectionView *titleCollectionView;
/// 内容 ..
@property (nonatomic,strong) UICollectionView *contentCollectionView;

@property (nonatomic,assign) NSInteger selectedIndex;

@property (nonatomic,assign) BOOL isNotFirstLoad;

@property (nonatomic,strong) NSMutableArray * titleArray ;

@property (nonatomic,strong) NSMutableArray * dealVCArray ;

@property (nonatomic,strong) BICGetTopListResponse * homeResponse ;

@property (nonatomic,strong) BICTipMidView * middenBgView;


@end

@implementation BICNavCointListView

-(instancetype)init
{
    if (self=[super init]) {
        
        self.backgroundColor = kBICWhiteColor;

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUI) name:NSNotificationCenterUpdateUI object:nil];
        
    }
    return self;
}

-(void)updateUI
{
    [self.middenBgView updateUI];
}

-(void)setUITitleList:(BICMainCurrencyResponse*)response
{
 
    self.titleArray = [NSMutableArray arrayWithArray:response.data];
    
    [self ConfigVC];
    
    [self setupUI];

}

-(void)setupUI
{
    
    [self addSubview:self.titleCollectionView];
    
    self.middenBgView = [[BICTipMidView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleCollectionView.frame), SCREEN_WIDTH, 48)];
    
    self.middenBgView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.middenBgView];
    
    [self addSubview:self.contentCollectionView];
    
    self.selectedIndex = 0;  //默认显示第一个
        
    [self collectionView:self.titleCollectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:0]];
    
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
    for (int i=0; i<self.titleArray.count; i++) {
        BICEXCNavigationVC * vc = [[BICEXCNavigationVC alloc] init];
        vc.currency=self.titleArray[i];
        [self.dealVCArray addObject:vc];
    }
}

- (UICollectionView *)titleCollectionView{
    if (!_titleCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(60, 44);
        flowLayout.minimumLineSpacing=0.0f ;
        flowLayout.minimumInteritemSpacing = 24.0f ;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _titleCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, 44) collectionViewLayout:flowLayout];
        [_titleCollectionView setContentInset:UIEdgeInsetsMake(0, 16, 0, 0)];
        [_titleCollectionView registerClass:[BICKTitleCell class] forCellWithReuseIdentifier:kReleaseTitleCollectionCellID];
        _titleCollectionView.delegate = self;
        _titleCollectionView.dataSource = self;
        _titleCollectionView.backgroundColor = kBICWhiteColor;
        _titleCollectionView.showsHorizontalScrollIndicator = NO;

       [_titleCollectionView viewShadowPathWithColor:[UIColor blackColor] shadowOpacity:0.2 shadowRadius:8 shadowPathType:LeShadowPathBottom shadowPathWidth:7];
    }
    return _titleCollectionView;
}
- (UICollectionView *)contentCollectionView{
    if (!_contentCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(kScreenWidth, contentColHeight);
        flowLayout.minimumLineSpacing=0.0f ;
        flowLayout.minimumInteritemSpacing = 0.0f ;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _contentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.titleCollectionView.frame)+48, kScreenWidth, contentColHeight) collectionViewLayout:flowLayout];
        [_contentCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kReleaseContentCollectionCellIDK__];
        _contentCollectionView.delegate = self;
        _contentCollectionView.dataSource = self;
        _contentCollectionView.backgroundColor = kClearBacground;
        _contentCollectionView.showsHorizontalScrollIndicator = NO;
        _contentCollectionView.pagingEnabled = YES;
    }
    return _contentCollectionView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewFlowLayout *tempLayout = (id)collectionViewLayout;
    return tempLayout.itemSize;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.titleArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == self.titleCollectionView) {
        BICKTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReleaseTitleCollectionCellID forIndexPath:indexPath];
        cell.titleLabel.text = self.titleArray[indexPath.item];
        if (self.selectedIndex == indexPath.row) {
            cell.titleLabel.textColor = kBICSYSTEMBGColor;
            cell.pointView.backgroundColor =kBICSYSTEMBGColor;
            cell.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
            cell.pointView.hidden = NO;
        }else
        {
            cell.titleLabel.textColor = kBICTitleTextColor;
            cell.pointView.backgroundColor =kBICTitleTextColor;
            cell.titleLabel.font = [UIFont systemFontOfSize:16];
            cell.pointView.hidden = YES;
        }
        return cell;
    }
    else if(collectionView == self.contentCollectionView){

        NSString *identifier=[NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row];
        
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    
        UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        for(id subView in cell.contentView.subviews){
            if(subView){
                [subView removeFromSuperview];
            }
        }

        cell.backgroundColor = kBICHomeBGColor;
        
        BICEXCNavigationVC *vc = self.dealVCArray[indexPath.item];
        vc.view.frame = CGRectMake(0, 0, kScreenWidth,contentColHeight);
       
        [cell addSubview:vc.view];

        return cell;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == self.titleCollectionView) {
        
        [self.titleCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:self.isNotFirstLoad];
        
        [self.contentCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:self.isNotFirstLoad];
        
        self.isNotFirstLoad = YES;
        
        self.selectedIndex = indexPath.item;
        
        [self.titleCollectionView reloadData];
        
    }
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView == self.contentCollectionView) {
        CGFloat width = scrollView.frame.size.width;
        CGFloat offsetX = scrollView.contentOffset.x;
        NSInteger index = offsetX / width;
        [self collectionView:self.titleCollectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        
    }
}


@end




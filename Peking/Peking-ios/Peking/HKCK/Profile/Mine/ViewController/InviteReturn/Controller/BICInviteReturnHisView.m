//
//  BTCListView.m
//  Biconome
//
//  Created by 车林 on 2019/8/10.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICInviteReturnHisView.h"
#import "BICItemCell.h"
#import "BICTipMidView.h"
#import "BICInviteVC.h"
#import "BICInviteRecordVC.h"
#import "BICInviteTopVC.h"

static NSString *kReleaseTitleCollectionCellID = @"kReleaseTitleCollectionCellID";
static NSString *kReleaseContentCollectionCellIDK__ = @"kReleaseContentCollectionCellIDK__";
static NSString *kbtcKindCollectionView = @"kbtcKindCollectionView";

#define contentColHeight (KScreenHeight-CGRectGetMaxY(self.titleCollectionView.frame)-kNavBar_Height)

@interface BICInviteReturnHisView()<UICollectionViewDelegate,UICollectionViewDataSource>

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

@implementation BICInviteReturnHisView

-(instancetype)init
{
    if (self=[super init]) {
        
        self.backgroundColor = kBICHomeBGColor;

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUI) name:NSNotificationCenterUpdateUI object:nil];
        
    }
    return self;
}

-(void)updateUI
{
    [self.middenBgView updateUI];
}

-(void)setUITitleList
{

    self.titleArray = [NSMutableArray arrayWithArray:@[LAN(@"返佣记录"),LAN(@"邀请记录"),LAN(@"排行榜")]];
    
    
    [self ConfigVC];
    
    [self setupUI];
}

-(void)setupUI
{
    
    [self addSubview:self.titleCollectionView];

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
        if (i==0) {
            BICInviteVC * vc = [[BICInviteVC alloc] init];
            [self.dealVCArray addObject:vc];
        }else if (i==1)
        {
            BICInviteRecordVC * vc = [[BICInviteRecordVC alloc] init];
            [self.dealVCArray addObject:vc];
        }else if (i==2)
        {
            BICInviteTopVC * vc = [[BICInviteTopVC alloc] init];
            [self.dealVCArray addObject:vc];
        }
    }
}

- (UICollectionView *)titleCollectionView{
    if (!_titleCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH/3, 44);
        flowLayout.minimumLineSpacing=0.0f ;
        flowLayout.minimumInteritemSpacing = 24.0f ;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _titleCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, 44) collectionViewLayout:flowLayout];
//        [_titleCollectionView setContentInset:UIEdgeInsetsMake(0, 16, 0, 0)];
        [_titleCollectionView registerClass:[BICKInviteTitleCell class] forCellWithReuseIdentifier:kReleaseTitleCollectionCellID];
        _titleCollectionView.delegate = self;
        _titleCollectionView.dataSource = self;
        _titleCollectionView.backgroundColor = kBICWhiteColor;
        _titleCollectionView.showsHorizontalScrollIndicator = NO;
    }
    return _titleCollectionView;
}
- (UICollectionView *)contentCollectionView{
    if (!_contentCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(kScreenWidth, SCREEN_HEIGHT-CGRectGetMaxY(self.titleCollectionView.frame));
        flowLayout.minimumLineSpacing=0.0f ;
        flowLayout.minimumInteritemSpacing = 0.0f ;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _contentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.titleCollectionView.frame), kScreenWidth,SCREEN_HEIGHT-CGRectGetMaxY(self.titleCollectionView.frame)) collectionViewLayout:flowLayout];
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
        BICKInviteTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReleaseTitleCollectionCellID forIndexPath:indexPath];
        cell.titleLabel.text = self.titleArray[indexPath.item];
        if (self.selectedIndex == indexPath.row) {
            cell.titleLabel.textColor = kBICSYSTEMBGColor;
            cell.pointView.hidden =NO;
            cell.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
        }else
        {
            cell.titleLabel.textColor = kBICTitleTextColor;
            cell.pointView.hidden =YES;
            cell.titleLabel.font = [UIFont systemFontOfSize:16];
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

        cell.backgroundColor = kBICMainListBGColor;
        
        BICInviteVC *vc = self.dealVCArray[indexPath.item];
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


@implementation BICKInviteTitleCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = kBICTitleTextColor;
    self.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
//        make.left.equalTo(self.contentView);
    }];

    self.pointView = [[UIView alloc] init];
    self.pointView.backgroundColor = kBICTitleTextColor;
    [self addSubview:self.pointView];
    [self.pointView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.titleLabel);
        make.bottom.equalTo(self).offset(-5);
        make.width.height.equalTo(@2);
    }];
    self.pointView.layer.cornerRadius = 1.f;
    self.pointView.layer.masksToBounds = YES;
    
}

@end


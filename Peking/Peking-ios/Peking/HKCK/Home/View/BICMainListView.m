//
//  BTCListView.m
//  Biconome
//
//  Created by 车林 on 2019/8/10.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICMainListView.h"
#import "BICItemCell.h"
#import "BICTipMidView.h"
#import "BICDealVC.h"

static NSString *kReleaseTitleCollectionCellID = @"kReleaseTitleCollectionCellID";
static NSString *kReleaseContentCollectionCellID = @"kReleaseContentCollectionCellID";
static NSString *kbtcKindCollectionView = @"kbtcKindCollectionView";

@interface BICMainListView()<UICollectionViewDelegate,UICollectionViewDataSource>

//币种类
@property (nonatomic,strong) UICollectionView *btcKindCollectionView;
/// 涨幅榜 ...
@property (nonatomic,strong) UICollectionView *titleCollectionView;
/// 内容 ..
@property (nonatomic,strong) UICollectionView *contentCollectionView;

@property (nonatomic,assign) NSInteger selectedIndex;

@property (nonatomic,assign) BOOL isNotFirstLoad;

@property (nonatomic,strong) NSMutableArray * titleArray ;



@property (nonatomic,strong) BICGetTopListResponse * homeResponse ;

@property (nonatomic,assign) NSInteger upsCount ;

@property (nonatomic,strong) BICTipMidView * middenBgView;


@end

@implementation BICMainListView

-(instancetype)init
{
    if (self=[super init]) {
        self.backgroundColor= [UIColor yellowColor];
        [self ConfigVC];
    
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUI) name:NSNotificationCenterUpdateUI object:nil];

        
        [self setupUI];
    }
    return self;
}

-(void)updateUI
{
    [self.titleCollectionView reloadData];
    [self.middenBgView updateUI];
}

-(void)setUIHomeList:(BICGetTopListResponse*)response
{
    self.homeResponse = response;
    [self.btcKindCollectionView reloadData];
}
-(void)updateTopList:(NSInteger)count
{
    self.contentCollectionView.height = count * 76.f;
    self.upsCount = count;
    UICollectionViewFlowLayout *flowLayout=(UICollectionViewFlowLayout*)self.contentCollectionView.collectionViewLayout;
    flowLayout.itemSize=CGSizeMake(KScreenWidth, count * 76.f);
    self.contentCollectionView.collectionViewLayout = flowLayout;
    
    [self.contentCollectionView reloadData];
}

-(void)setupUI
{
    self.backgroundColor = kBICHomeBGColor;
    
    [self addSubview:self.btcKindCollectionView];
    
    [self addSubview:self.titleCollectionView];
    
    UIView * bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = rgb(237, 237, 237);
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.titleCollectionView);
        make.height.mas_equalTo(@1);
    }];

    self.middenBgView = [[BICTipMidView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleCollectionView.frame), SCREEN_WIDTH, 40)];
    [self addSubview:self.middenBgView];
    
    [self addSubview:self.contentCollectionView];
    
    self.selectedIndex = 0;  //默认显示第一个
    
    SDUserDefaultsSET(@"1", BICHomeRefreshSortBy);

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
        BICDealVC * vc = [[BICDealVC alloc] init];
        vc.type=BaseViewType_Main;
        [self.dealVCArray addObject:vc];
    }
}


-(NSMutableArray*)titleArray
{
    _titleArray = [NSMutableArray arrayWithArray:@[LAN(@"涨幅榜"),LAN(@"成交额榜")]];
    
    return _titleArray;
}

- (UICollectionView *)titleCollectionView{
    if (!_titleCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(85, 30);
        flowLayout.minimumLineSpacing=0.0f ;
        flowLayout.minimumInteritemSpacing = 24.0f ;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _titleCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(kBICMargin,CGRectGetMaxY(self.btcKindCollectionView.frame)+8, kScreenWidth-2*kBICMargin, 30) collectionViewLayout:flowLayout];
        [_titleCollectionView registerClass:[BICTitleCell class] forCellWithReuseIdentifier:kReleaseTitleCollectionCellID];
        _titleCollectionView.delegate = self;
        _titleCollectionView.dataSource = self;
        _titleCollectionView.backgroundColor = kBICHomeBGColor;
        _titleCollectionView.showsHorizontalScrollIndicator = NO;
    }
    return _titleCollectionView;
}
- (UICollectionView *)contentCollectionView{
    if (!_contentCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(kScreenWidth, 600-CGRectGetMaxY(self.titleCollectionView.frame)-44);
        flowLayout.minimumLineSpacing=0.0f ;
        flowLayout.minimumInteritemSpacing = 0.0f ;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _contentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.titleCollectionView.frame)+44, kScreenWidth, 600-CGRectGetMaxY(self.titleCollectionView.frame)-44) collectionViewLayout:flowLayout];
        [_contentCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kReleaseContentCollectionCellID];
        _contentCollectionView.delegate = self;
        _contentCollectionView.dataSource = self;
        _contentCollectionView.backgroundColor = kClearBacground;
        _contentCollectionView.showsHorizontalScrollIndicator = NO;
        _contentCollectionView.pagingEnabled = YES;
    }
    return _contentCollectionView;
}

- (UICollectionView *)btcKindCollectionView{
    if (!_btcKindCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(182,130);
        flowLayout.minimumInteritemSpacing = 0.0;//item 之间的行的距离
        flowLayout.minimumLineSpacing = 0.0;//item 之间竖的距离
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _btcKindCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(kBICMargin-6,0, kScreenWidth-2*(kBICMargin-6), flowLayout.itemSize.height) collectionViewLayout:flowLayout];
        [_btcKindCollectionView registerNib:[UINib nibWithNibName:@"BICItemCell" bundle:nil] forCellWithReuseIdentifier:kbtcKindCollectionView];
//        [_btcKindCollectionView registerClass:[BICItemCell class] forCellWithReuseIdentifier:kbtcKindCollectionView];
        _btcKindCollectionView.delegate = self;
        _btcKindCollectionView.dataSource = self;
        _btcKindCollectionView.backgroundColor = [UIColor clearColor];
        _btcKindCollectionView.showsHorizontalScrollIndicator = NO;
//        _btcKindCollectionView.pagingEnabled = YES;
        
    }
    return _btcKindCollectionView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewFlowLayout *tempLayout = (id)collectionViewLayout;
    return tempLayout.itemSize;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   
    if (collectionView==self.btcKindCollectionView) {
        if (self.homeResponse) {
            return self.homeResponse.data.count;
        }
        return 0;
    }else if(collectionView==self.titleCollectionView)
    {
        return 2;
    }
    
    return self.titleArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //涨幅榜 成交额榜
    if (collectionView == self.titleCollectionView) {
        BICTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReleaseTitleCollectionCellID forIndexPath:indexPath];
        cell.titleLabel.text = self.titleArray[indexPath.item];
        if (self.selectedIndex == indexPath.row) {
            cell.titleLabel.textColor = kBICGetHomeZhRColor;
            cell.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
        }else
        {
            cell.titleLabel.textColor = kBICGetHomeCHRColor;
            cell.titleLabel.font = [UIFont systemFontOfSize:18];
        }
        return cell;
    //中间4项cell
    }else if(collectionView == self.btcKindCollectionView){
        BICItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kbtcKindCollectionView forIndexPath:indexPath];
        cell.model = self.homeResponse.data[indexPath.row];
        return cell;
    }
    //底部数据
    else if(collectionView == self.contentCollectionView){
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReleaseContentCollectionCellID forIndexPath:indexPath];
        cell.backgroundColor = kBICHomeBGColor;
        
        BaseViewController *vc = self.dealVCArray[indexPath.item];
        vc.view.frame = CGRectMake(0, 0, kScreenWidth,self.upsCount * 76.f);

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
        
        if (indexPath.row==0) {
            SDUserDefaultsSET(@"1", BICHomeRefreshSortBy);
        }else if (indexPath.row==1)
        {
            SDUserDefaultsSET(@"2", BICHomeRefreshSortBy);
        }
        
        [self.titleCollectionView reloadData];
        
    }
    if (collectionView == self.btcKindCollectionView) {
        
        getTopListResponse *model = self.homeResponse.data[indexPath.row];
        
        NSDictionary * dic = @{@(99):model};//首页
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenterkLinePushIMP object:dic];

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


@implementation BICTitleCell

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
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.textColor = kBICGetHomeCHRColor;
    self.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView);
    }];
}

@end

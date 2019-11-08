//
//  BICHistoryView.m
//  Biconome
//
//  Created by 车林 on 2019/8/21.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICHistoryView.h"
#import "BICHisCollectCell.h"
#import "UIView+Extension.h"
#import "BTStockChartViewController.h"
static NSString *kReleaseContentCollectionCellID__ = @"kReleaseContentCollectionCellID__";

static int kNum = 3;

@interface BICHistoryView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *contentCollectionView;

@property (nonatomic,strong)UILabel*historyTitle;

@property (nonatomic,strong)UIButton*clearBtn;

@end

@implementation BICHistoryView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUI) name:NSNotificationCenterUpdateUI object:nil];

        [self setupUI];
    }
    return self;
}
-(void)setHistoryDataArray:(NSArray *)historyDataArray
{
    //倒置数组.....####...
    NSMutableArray * arr = [NSMutableArray array];
    for (int i=(int)historyDataArray.count; 0<i; i--) {
        [arr addObject:historyDataArray[i-1]];
    }
    
    _historyDataArray = arr.copy;
    
    [self.contentCollectionView reloadData];
    
    if (_historyDataArray.count==0) {
        self.hidden = YES;
    }else{
        self.hidden = NO;
    }
    
}
-(void)updateUI
{
    self.historyTitle.text = LAN(@"历史记录");
    [self.clearBtn setTitle:LAN(@"清空") forState:UIControlStateNormal];
}
-(void)setupUI
{
    
    self.backgroundColor = kBICHistoryCellBGColor;
    
    UIView *topView= [[UIView alloc] init];
    [self addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@60);
    }];
    
    UILabel*historyTitle = [[UILabel alloc] init];
    historyTitle.text = LAN(@"历史记录");
    historyTitle.font=[UIFont systemFontOfSize:15.f weight:UIFontWeightBold];
    historyTitle.textColor = kBICHistoryTitleColor;
    [topView addSubview:historyTitle];
    [historyTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView).offset(24);
        make.top.equalTo(topView).offset(24);
    }];
    
    
    UIButton * clearBtn = [[UIButton alloc]init];
    [clearBtn setTitle:LAN(@"清空") forState:UIControlStateNormal];
    [clearBtn setTitleColor:kBICHistoryTitleColor forState:UIControlStateNormal];
    clearBtn.titleLabel.font =[UIFont systemFontOfSize:15.f weight:UIFontWeightBold];
    [clearBtn addTapBlock:^(UIButton *btn) {
        if (self.clearBlock) {
            self.clearBlock();
        }
    }];
    [topView addSubview:clearBtn];
    [clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topView).offset(-24);
        make.centerY.equalTo(historyTitle);
    }];
    
    [self addSubview:self.contentCollectionView];

}

- (UICollectionView *)contentCollectionView{
    if (!_contentCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake((kScreenWidth-2*24-2*8)/kNum-3,36);
        flowLayout.minimumInteritemSpacing = 12.0;//item 之间的行的距离
        flowLayout.minimumLineSpacing = 8.0;//item 之间竖的距离
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _contentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(24,60, kScreenWidth-2*24,132) collectionViewLayout:flowLayout];
        [_contentCollectionView registerNib:[UINib nibWithNibName:@"BICHisCollectCell" bundle:nil] forCellWithReuseIdentifier:kReleaseContentCollectionCellID__];
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
    
    return self.historyDataArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
        BICHisCollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReleaseContentCollectionCellID__ forIndexPath:indexPath];
    
        cell.backgroundColor = kBICHomeBGColor;
    
         NSString *str = self.historyDataArray[indexPath.row];
    
        cell.titleLabel.text = [str stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    
        return cell;

    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    getTopListResponse * model = [[getTopListResponse alloc] init];
    model.currencyPair = self.historyDataArray[indexPath.row];
    BTStockChartViewController * stockChart = [[BTStockChartViewController alloc] init];
    stockChart.model = model;
    [self.superview.yq_viewController.navigationController pushViewController:stockChart animated:YES];
    
}



@end

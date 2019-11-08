//
//  BICHomeViewController.m
//  Biconome
//
//  Created by 车林 on 2019/8/9.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICHomeViewController.h"
#import "XRCarouselView.h"
#import "BICMainListView.h"
#import "BICBoardTableViewCell.h"
#import "BICMainService.h"
#import "BICSystemImageResponse.h"
#import "BICGetTopListRequest.h"
#import "BICGetTopListResponse.h"
#import "BICLoginVC.h"
#import "BICBoardView.h"
#import "BICMarketViewController.h"
#import "SDArchiverTools.h"
#import "BICMarketGetResponse.h"
#import "BTStockChartViewController.h"
#import "RSDHomeListWebVC.h"
#import "BICDataToUserDefault.h"
#import "BICHomeListWebVC.h"
#import "WKWebViewController.h"
#import "CheckUpdate.h"
#import "BICDealVC.h"
#import "AppDelegate.h"

#define ContentOff_Y 200.f

@interface BICHomeViewController ()<XRCarouselViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) XRCarouselView *cycleScrollView;

@property(nonatomic,strong) UITableView * tableView;

@property (nonatomic, strong) BICMainListView * listView;

@property (nonatomic, strong) BICBoardView * boardView;

@property (nonatomic,assign) NSInteger upsCount;

@property(nonatomic,strong) UIImageView *barImageView;

@property(nonatomic,strong) NSArray *arrMul;

@property (nonatomic,assign) float alpha;


@end

@implementation BICHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = kBICHomeBGColor;

    self.navigationController.navigationBar.translucent = YES;

    [self initNavigationRightButtonWithBackImage:[UIImage imageNamed:@"icon_home_navigation_search"]];
    
    self.upsCount = 8 ;
    
    [self setupDataSystemImage];
    [self setupDataSystemNoticeList];
    [self setupDataGetHomeList];
    [self setupUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupRefresh:) name:BICHomeRefreshBack object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateNoticeList:) name:AppdelegateEnterForeground object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToKline:) name:NSNotificationCenterkLinePushIMP object:nil];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUI) name:NSNotificationCenterUpdateUI object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refushGainer:) name:NSNotificationCenterGAINER object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refushVolumeTop:) name:NSNotificationCenterVOLUMETOP object:nil];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromContextWithColor:[UIColor colorWithHexColorString:@"FFFFFF" alpha:0]] forBarMetrics:UIBarMetricsDefault];
    
    [self initNavigationTitleViewLabelWithTitle:@"Biconomy" titleColor:kNVABICSYSTEMTitleColor IfBelongTabbar:NO];
    

    
    //版本更新检测
    [[CheckUpdate share] requestVersion];
//    NSLog(@"%@",[UtilsManager getLocalDateFormateUTCDate:@"2018-01-15 21:15:00"]);
}
 

-(void)updateUI
{
    [self.tableView.mj_header beginRefreshing];
    
}

-(void)pushToKline:(NSNotification*)notify
{
    NSDictionary * dic = notify.object;
    
    if (dic) {
        if ([[dic allKeys] containsObject:@(99)]) {
            getTopListResponse * model = dic[@(99)];
            BTStockChartViewController * stockChart = [[BTStockChartViewController alloc] init];
            stockChart.model = model;
            [self.navigationController pushViewController:stockChart animated:YES];
        }
    }
    
}


-(void)updateNoticeList:(NSNotification*)notify
{
//    BaseTabBarController *nmTabBarVC = [[BaseTabBarController alloc] init];
//    nmTabBarVC.delegate = nmTabBarVC;
    BaseTabBarController *nmTabBarVC = ((AppDelegate*)[UIApplication sharedApplication].delegate).mainController;
    
    if (!nmTabBarVC.selectedIndex) {
        [self setupDataSystemNoticeList];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:NO];

    self.navigationTitleLabel.textColor = [UIColor colorWithHexColorString:@"33353B" alpha:self.alpha];

}



-(void)setupRefresh:(NSNotification*)notify
{
    [self.tableView.mj_header endRefreshing];
    NSDictionary* dic = notify.object;
    NSInteger count = 0;
    if (dic) {
        count = [dic[@"count"] integerValue];
    }
    self.upsCount = count;
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
    
    [self.listView updateTopList:count];

}


//涨跌幅
-(void)refushGainer:(NSNotification *)notify{
     BICDealVC * vc = [self.listView.dealVCArray objectAtIndex:0];
     vc.dataArray=notify.object;
     if(vc.dataArray.count!=self.upsCount){
        self.upsCount = vc.dataArray.count;
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
        [self.listView updateTopList:vc.dataArray.count];
     }
     [vc.tableView reloadData];
    
}
//成交额
-(void)refushVolumeTop:(NSNotification *)notify{
     BICDealVC * vc = [self.listView.dealVCArray objectAtIndex:1];
     vc.dataArray=notify.object;
     if(vc.dataArray.count!=self.upsCount){
        self.upsCount = vc.dataArray.count;
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
        [self.listView updateTopList:vc.dataArray.count];
     }
     [vc.tableView reloadData];
}


-(void)doRightBtnAction
{
    BICMarketViewController* marketVC= [[BICMarketViewController alloc] init];
    [self.navigationController pushViewController:marketVC animated:YES];
}
-(BICBoardView*)boardView
{
    if (!_boardView) {
        _boardView = [[BICBoardView alloc] initWithFrame:CGRectMake(16, kCarouselViewHeight+40-(20+48),KScreenWidth-2*kBICMargin,48)];
        
           NSArray *tempArray = [SDArchiverTools unarchiverObjectByKey:kHomePageNoticeList];
        if (tempArray.count>0) {
            [_boardView setupUI:tempArray];
        }
    }
    return _boardView;
}

-(void)setupDataSystemImage
{
    BICBaseRequest * request = [[BICBaseRequest alloc] init];

    [[BICMainService sharedInstance] analyticalSystemImageListData:request serverSuccessResultHandler:^(id response) {
        
        BICSystemImageResponse * responseM = (BICSystemImageResponse *)response;
        NSMutableArray * arrMul = [NSMutableArray array];
        

        for (RowsResponse* row in responseM.data.rows) {
                    [arrMul addObject:row];
                }
        
        self.arrMul = arrMul.copy;
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [SDArchiverTools archiverObject:arrMul.copy ByKey:kHomePageSystemImage];
        });
 
        NSMutableArray * tempArr  = [[NSMutableArray alloc] init];
        for (RowsResponse* row in arrMul) {
                    [tempArr addObject:[NSString stringWithFormat:@"%@"URL8801"/%@",kBaseUrl,row.fileUrl]];
                }
        self.cycleScrollView.imageArray = tempArr.copy;
        
    } failedResultHandler:^(id response) {

    } requestErrorHandler:^(id error) {

    }];

}

-(void)setupDataSystemNoticeList
{
    BICBaseRequest * request = [[BICBaseRequest alloc] init];
    
    [[BICMainService sharedInstance] analyticalSystemNoticeListData:request serverSuccessResultHandler:^(id response) {
        
        BICSystemImageResponse * responseM = (BICSystemImageResponse *)response;
        NSMutableArray * arrMul = [NSMutableArray array];
        for (RowsResponse* row in responseM.data.rows) {
            [arrMul addObject:row];
        }

        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [SDArchiverTools archiverObject:arrMul.copy ByKey:kHomePageNoticeList];
        });
        if (arrMul.count>0) {
            [self.boardView setupUI:arrMul.copy];
        }
      
    } failedResultHandler:^(id response) {
      
    } requestErrorHandler:^(id error) {
       
    }];
    
}
-(void)setupDataGetHomeList
{
    BICGetTopListRequest * request = [[BICGetTopListRequest alloc] init];
    [[BICMainService sharedInstance] analyticalGetHomeListData:request serverSuccessResultHandler:^(id response) {
        BICGetTopListResponse * responseM = (BICGetTopListResponse*)response;
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [SDArchiverTools archiverObject:responseM ByKey:kHomePageHomeList];
        });
        [self.listView setUIHomeList:responseM];
        
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_header endRefreshing];
        }
    } failedResultHandler:^(id response) {
        if ([self.tableView.mj_header isRefreshing]) {
                 [self.tableView.mj_header endRefreshing];
             }
    } requestErrorHandler:^(id error) {
        if ([self.tableView.mj_header isRefreshing]) {
                 [self.tableView.mj_header endRefreshing];
             }
    }];
    
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=[UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}
-(BICMainListView*)listView
{
    if (!_listView) {
        _listView = [[BICMainListView alloc] init];
         BICGetTopListResponse * responseM = [SDArchiverTools unarchiverObjectByKey:kHomePageHomeList];
        if (responseM) {
            [_listView setUIHomeList:responseM];
        }
    }
    return _listView;
}
-(void)setupUI
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(-kNavBar_Height);
    }];

    CustomGifHeader * header = [CustomGifHeader headerWithRefreshingBlock:^{
        //涨跌幅榜刷新
        [[NSNotificationCenter defaultCenter] postNotificationName:BICHomeRefresh object:nil];
        //请求轮播图
        [self setupDataSystemImage];
        //公告信息
        [self setupDataSystemNoticeList];
        //中间最新币对行情
        [self setupDataGetHomeList];
    }];
    
    self.tableView.mj_header = header;

}

- (XRCarouselView *)cycleScrollView
{
    if (!_cycleScrollView) {
        _cycleScrollView = [[XRCarouselView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kCarouselViewHeight)];
        _cycleScrollView.delegate = self;
        //设置占位图片,须在设置图片数组之前设置,不设置则为默认占位图
        _cycleScrollView.placeholderImage = kHomePageCarousel_Placeholder;
        //设置每张图片的停留时间，默认值为5s，最少为1s
        _cycleScrollView.time = 3;
        //设置分页控件的图片,不设置则为系统默认
//        [_cycleScrollView setPageImage:[UIImage imageNamed:@"point"] andCurrentPageImage:[UIImage imageNamed:@"point_select"]];
        //设置分页控件的位置，默认为PositionBottomCenter
        _cycleScrollView.pagePosition = PositionBottomRight;
        // 设置滑动时gif停止播放
        _cycleScrollView.gifPlayMode = GifPlayModePauseWhenScroll;
        
        NSArray *tempArray = [SDArchiverTools unarchiverObjectByKey:kHomePageSystemImage];
        if (tempArray.count>0) {
            NSMutableArray * tempArr  = [[NSMutableArray alloc] init];
            for (RowsResponse* row in tempArray) {
                [tempArr addObject:[NSString stringWithFormat:@"%@"URL8801"/%@",kBaseUrl,row.fileUrl]];
            }
            _cycleScrollView.imageArray = tempArr.copy;
        }
        
    }
    return _cycleScrollView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellId = @"cellId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row==0) {
        cell.backgroundColor = kBICHomeBGColor;
        [cell addSubview:self.cycleScrollView];
        [cell addSubview:self.boardView];
        
    }else if(indexPath.row==1)
    {
        cell.backgroundColor = kBICHomeBGColor;
        [cell addSubview:self.listView];
        [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.top.equalTo(cell);
            }];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return kCarouselViewHeight + 40;
    }else if(indexPath.row==1)
    {
        return 227.f + self.upsCount * 76.f;
    }
    return 44.f;
}
#pragma mark -- 点击图片回调
- (void)carouselView:(XRCarouselView *)carouselView clickImageAtIndex:(NSInteger)index
{

    RowsResponse* response=[self.arrMul objectAtIndex:index];
    if (response.jumpUrl) {

        RSDHomeListWebVC * webVC = [[RSDHomeListWebVC alloc] init];
        webVC.navigationShow = YES;
        webVC.listWebStr =  response.jumpUrl;
        webVC.naviStr=response.title;
        [self.navigationController pushViewController:webVC animated:YES];
    }
    
}

#pragma mark -- scrollViewDidScroll
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    CGFloat minAlphaOffset = - kNavBar_Height;
    CGFloat maxAlphaOffset = ContentOff_Y;
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat alpha = (offset - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset);

    if (alpha>1) {
        alpha=1;
    }
    [self setNavTitleRight:alpha];

}



-(void)setNavTitleRight:(float)alpha
{
//    self.navigationTitleLabel.alpha = alpha;
    self.navigationTitleLabel.textColor = [UIColor colorWithHexColorString:@"33353B" alpha:self.alpha];

    self.navigationRightBtn.alpha = alpha;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromContextWithColor:[UIColor colorWithHexColorString:@"FFFFFF" alpha:alpha]] forBarMetrics:UIBarMetricsDefault];
    self.alpha = alpha;
}

@end

//
//  YStockChartViewController.m
//  BTC-Kline
//
//  Created by yate1996 on 16/4/27.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "BTStockChartViewController.h"
#import "Y_StockChartView.h"
#import "Y_KLineGroupModel.h"
#import "UIColor+Y_StockChart.h"
#import "AppDelegate.h"
#import "BTBiModel.h"
#import "BTDealMarketModel.h"
#import "BTMarketModel.h"
#import "LineKFullScreenViewController.h"
#import "UIViewController+INMOChildViewControlers.h"
#import "Y_KLineModel.h"
#import "Y_KLineView.h"
#import "Y_KLineMainView.h"
#import "BTScreenshotsPopView.h"

#import "RSDZXYNavition.h"
#import "BICEXCBuySaleView.h"
#import "BICEXCChangeDoneView.h"
#import "BICEXCBomSaleBuyView.h"

#import "BICKLineRequest.h"
#import "BICCoinAndUnitResponse.h"
#import "BICMarketGetResponse.h"
#import "BICKLineResponse.h"

#import "BICGetHistoryListResponse.h"

#import "BICSockJSRouter.h"

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define SCREEN_MAX_LENGTH MAX(KScreenWidth,kScreenHeight)
#define IS_IPHONE_X (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)
#define KHeaderHeight 120+410+10+12+16
#define bomSaleBuyViewHeight 64.f


typedef NS_ENUM(NSInteger, KLineTimeType) {
    KLineTimeTypeMinute = 100,
    KLineTimeTypeMinute5,
    KLineTimeTypeMinute15,
    KLineTimeTypeMinute30,
    KLineTimeTypeHour,
    KLineTimeTypeHour4,
    KLineTimeTypeDay,
    KLineTimeTypeWeek,
    KLineTimeTypeMonth,
    KLineTimeTypeOther
};
static NSString *const contentCellID = @"contentCellID";
static NSString *const dealCellID = @"dealCellID";
static NSString *const biInfoCellID = @"biInfoCellID";
static NSString *const biInfoDesCellID = @"biInfoDesCellID";
static NSString *const depthCellID = @"depthCellID";

static int websocketFlag = 0 ;

@interface BTStockChartViewController ()<Y_StockChartViewDataSource,Y_StockChartViewDelegate,UITableViewDelegate,UITableViewDataSource,SRWebSocketDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) Y_StockChartView *lineKView;

@property (assign, nonatomic) BOOL isShowKLineFullScreenViewController;

@property (nonatomic, strong) Y_KLineGroupModel *groupModel;

@property (nonatomic, copy) NSMutableDictionary <NSString*, Y_KLineGroupModel*> *modelsDict;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, copy) NSString *type;

@property (strong, nonatomic) UILabel *price;

@property (strong, nonatomic) UILabel *zfLabel;

@property (strong, nonatomic) UILabel *zfLabelPrecent;

@property (strong, nonatomic) UILabel *rightL;

//分段选择
@property (nonatomic, assign) NSInteger biInfoType;
//成交数组
@property (nonatomic, strong) NSMutableArray *dealArray;
//币种简介标题
@property (nonatomic, strong) NSArray *biInfoTitleArray;
//币种简介描述
@property (nonatomic, strong) NSArray *biInfoDesArray;
//筛选面板
@property (nonatomic, assign) BOOL isShowBiBan;
//头部model
@property (nonatomic, strong) BTMarketModel *marketModel;
//币列表
@property (nonatomic, strong) NSMutableArray *marketModelArr;
//是否收藏
//@property (nonatomic, assign) BOOL isCollect;
//收藏按钮
@property (nonatomic, strong) UIButton *collect;

//全屏K线
@property (nonatomic, strong) LineKFullScreenViewController *lineKFullScreenViewController;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) BOOL isFirst;

@property (nonatomic,assign) BOOL isHidden;

@property (nonatomic, strong) BICEXCBuySaleView* buySaleView;

@property (nonatomic, strong) BICEXCChangeDoneView* changeDoneView;

@property (nonatomic, strong) BICEXCBomSaleBuyView* bomSaleBuyView;

@property (nonatomic, strong) BICCoinAndUnitResponse *responseM;

@property (nonatomic, strong) BICGetHistoryListResponse * historyResponseM;

@property (nonatomic, strong) BICMarketGetResponse * marketGetResponse;

@property (nonatomic, strong)RSDZXYNavition * nav;

@property (nonatomic, assign)Boolean preferStatusHidden;

@end

@implementation BTStockChartViewController

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}



-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
}

- (void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSMutableArray *)dealArray
{
    if (_dealArray == nil) {
        _dealArray = [[NSMutableArray alloc] init];
    }
    return _dealArray;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController.navigationBar setHidden:YES];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    
    [[BICSockJSRouter shareInstance] SockJSKLineStop];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBICHistoryCellBGColor;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateRate:) name:NSNotificationCenterBICRateConfig object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SockJS_Type_Market:) name:NSNotificationCenteSockJSTopicMarket object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess:) name:NSNotificationCenterLoginSucceed object:nil];

    self.currentIndex = -1;
    self.isHidden = YES;
    self.preferStatusHidden=NO;
    //导航栏
    //    [self setupNavView];
    [self setupNavUI];
    //初始化tableView
    [self setupTableView];
    
    //初始化头部
    [self setuptopView];
    
    [self setupBottom];
    
    //加载头部数据
    [self loadBiTopMarketData];
    
    [self analyticalGetHistoryListData];
    
    [self setupSaleBuyData];
    
}
-(void)SockJS_Type_Market:(NSNotification*)notify
{
    marketGetResponse  * response = notify.object;
    
    BICMarketGetResponse * responseM =[[BICMarketGetResponse alloc] init];
    
    responseM.data = response;
    
    self.marketGetResponse = responseM;
    
    RSDLog(@"marketGetResponse--%@",response);
    //    self.nav.marketGetResponse = self.marketGetResponse;
    
    BTMarketModel *marketModel = [[BTMarketModel alloc] init];
    
    BTDealMarketModel * dealM = [[BTDealMarketModel alloc] init];
    
    dealM.NewPrice = responseM.data.amount;
    
    NSString* currencyPair=[NSString stringWithFormat:@"%@-%@",[BICDeviceManager GetPairCoinName],[BICDeviceManager GetPairUnitName]];

    if ([self.marketGetResponse.data.currencyPair isEqualToString:currencyPair]) {
        [self updateLoadBiTopMarketUI:responseM DealM:dealM BTMarketModel:marketModel];
    }
    
}

-(void)updateRate:(NSNotification*)notify
{
    if ([[BICDeviceManager getCurrentRate] isEqualToString:@"CNY"]) {
        self.zfLabel.text = NSStringFormat(@"¥%.2f",[self.marketGetResponse.data.cnyAmount floatValue]*self.marketGetResponse.data.amount.floatValue);
    }
    
    if ([[BICDeviceManager getCurrentRate] isEqualToString:@"USD"]) {
        self.zfLabel.text = NSStringFormat(@"$%.2f",[self.marketGetResponse.data.usdAmount floatValue]*self.marketGetResponse.data.amount.floatValue);
    }
    
}
-(void)loginSuccess:(NSNotification*)noti
{
    [self loadBiTopMarketData];
}

//盘口
-(void)setupSaleBuyData
{
    BICLimitMarketRequest * request = [[BICLimitMarketRequest alloc] init];
    if (self.model) {
        NSArray * arr = [self.model.currencyPair componentsSeparatedByString:@"-"];
        if (arr.count>1) {
            request.coinName = arr[0];
            request.unitName = arr[1];
        }
    }else{
        request.coinName = [BICDeviceManager GetPairCoinName];
        request.unitName = [BICDeviceManager GetPairUnitName];
        
    }
    WEAK_SELF
    [[BICExchangeService sharedInstance] analyticalListOrderByCoinAndUnitData:request serverSuccessResultHandler:^(id response) {
        weakSelf.responseM = (BICCoinAndUnitResponse*)response;
        kPOSTNSNotificationCenter(NSNotificationCenterBICChangeSocketView, weakSelf.responseM);
        weakSelf.buySaleView.responseM = weakSelf.responseM;
        
    } failedResultHandler:^(id response) {
        
    } requestErrorHandler:^(id error) {
        
    }];
}
-(void)backTo
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 推送
- (void)webSocketDidOpen:(SRWebSocket *)webSocket
{
//    NSLog(@"______webSocket___open___%@",webSocket.url);
}
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean
{
//    NSLog(@"______webSocket_____close____");
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    
//    NSLog(@"webSocket--%d",websocketFlag++);
    
    //收到服务端发送过来的消息
    NSDictionary *dict = [NSString dictionaryWithJsonString:message];
    if ([dict[@"type"] integerValue] == 2){ //最新成交
        
    }else if ([dict[@"type"] integerValue] == 4){ //头部最新价
        
        
    }else if ([dict[@"type"] integerValue] == 21){
        
        self.dataArray = dict[@"data"][@"datas"][@"data"];
        kWeakSelf(self)
        dispatch_async(dispatch_get_main_queue(), ^{
            if (weakself.groupModel != nil &&weakself.dataArray.count > 0) {
                //                NSLog(@"%@",self.dataArray[0]);
                Y_KLineModel *lineModel = [weakself.groupModel.models lastObject];
                [lineModel initWithArray:weakself.dataArray[0]];
                //                [weakself.lineKView.kLineView reDraw];
                //
                //                return ;
                
                // 推送过来的数据的第一条加上你设置的蜡烛图时间
                // 如果超过了你的当前时间,就说明还不需要刷新界面;
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:lineModel.Date.doubleValue/1000 + weakself.type.integerValue * 60];
                // end > start  =>  Yes  ... 后 > 前 ...
                BOOL  isresh  = [weakself compareDate:[NSDate date] withDate:date];
                
                if (!isresh) {
                    lineModel.Date = [NSString stringWithFormat:@"%@",@(lineModel.Date.doubleValue +1)];
                    //暂时关闭
                    [self reloadData];
                    
                }else
                {
                    //                NSLog(@"122223312312321321321123");
                }
                //                NSString * price = [NSString stringWithFormat:@"%@ ",[EXUnit formatternumber:modle.quote_asset_precision.intValue assess:modle.last]];
                NSString *price = NSStringFormat(@"%@",weakself.dataArray[0][4]);
                [weakself.lineKView.kLineView.kLineMainView  uploadPrice:price];
                [weakself.lineKView.kLineView drawMainView];
            }
        });
    }else if ([dict[@"type"] integerValue] == 18){
        
        
    }else if ([dict[@"type"] integerValue] == 19){
    }
}

-(void)SockJSKLine:(Y_KLineModel *)lineModel Type:(NSString*)type
{
    //插入以前的group 对应的type
    Y_KLineGroupModel * group = [self.modelsDict objectForKey:type];
    if (group) {
        NSMutableArray <Y_KLineModel*>* arr = [NSMutableArray array];
        [arr addObjectsFromArray:group.models];
        [arr addObject:lineModel];
        group.models = arr;
        [self.modelsDict setObject:group forKey:type];
    }
    
    //如果恰好是当前类型有推送,那么更新当前k线
    if (self.type == type) {
        [self.lineKView reloadData];
        NSString *price = NSStringFormat(@"%@",lineModel.Close);
        [self.lineKView.kLineView.kLineMainView  uploadPrice:price];
        [self.lineKView.kLineView drawMainView];
    }
    
}
//比较两个日期的大小
- (BOOL)compareDate:(NSDate*)stary withDate:(NSDate*)end
{
    NSComparisonResult result = [stary compare: end];
    if (result==NSOrderedSame)
    {
        //相等
        return NO;
    }else if (result==NSOrderedAscending)
    {
        //结束时间大于开始时间
        return YES;
    }else if (result==NSOrderedDescending)
    {
        //结束时间小于开始时间
        return NO;
    }
    return NO;
}

- (void)setupTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavBar_Height, KScreenWidth, KScreenHeight-kNavBar_Height-bomSaleBuyViewHeight) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
}
-(void)setupBottom
{
    [self.view addSubview:self.bomSaleBuyView];
    WEAK_SELF
    [self.bomSaleBuyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.height.equalTo(@(bomSaleBuyViewHeight));
        make.bottom.equalTo(weakSelf.view).offset(-TabbarSafeBottomMargin);
    }];
}
-(void)setupNavUI
{
    NSString * navTitle = @"";
    
    if (self.model) {
        navTitle = [NSString stringWithFormat:@"%@",[self.model.currencyPair stringByReplacingOccurrencesOfString:@"-" withString:@"/"]];
    }else{
        navTitle = [NSString stringWithFormat:@"%@/%@",[BICDeviceManager GetPairCoinName],[BICDeviceManager GetPairUnitName]];
    }
    
    WEAK_SELF
    RSDZXYNavition * nav = [[RSDZXYNavition alloc] initWithTitle:navTitle RightHidden:NO TapBlock:^(NSString *str, NSInteger index) {
        SDUserDefaultsSET(str, BICRateConfigType);
        [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenterBICRateConfig object:nil];
    } TapLeftBlock:^{
        weakSelf.preferStatusHidden=YES;
        [weakSelf full];
    } BackTo:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } ValueArray:@[@"CNY",@"USD"] Hidden:NO];
    
    self.nav = nav;
    [self.view addSubview:nav];
}
- (BOOL)prefersStatusBarHidden {
    return self.preferStatusHidden;
}
- (void)setupNavView
{
    UIView *navView = [[UIView alloc] init];
    navView.backgroundColor = kBICWhiteColor;
    [self.view addSubview:navView];
    kWeakSelf(self)
    [navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(weakself.view);
        make.height.equalTo(@(kTopHeight));
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = RGB(13, 23, 35);
    [navView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(navView);
        make.height.equalTo(@1);
    }];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 20, 44, 44);
    [backBtn setImage:IMAGE_NAMED(@"transaction-takeup-ic") forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backBtn];
    
    UIButton *collect = [UIButton buttonWithType:UIButtonTypeCustom];
    [navView addSubview:collect];
    _collect = collect;
    
    UIButton *full = [UIButton buttonWithType:UIButtonTypeCustom];
    [full setImage:IMAGE_NAMED(@"line_quanp") forState:UIControlStateNormal];
    [navView addSubview:full];
    
    
    UIButton *share = [UIButton buttonWithType:UIButtonTypeCustom];
    [share setImage:IMAGE_NAMED(@"line_share") forState:UIControlStateNormal];
    [navView addSubview:share];
    
    
    [full mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(share.mas_left).offset(-15);
        make.centerY.equalTo(share);
    }];
    
    [collect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(full.mas_left).offset(-15);
        make.centerY.equalTo(share);
    }];
}

- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setuptopView
{
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor clearColor];
    topView.height = KHeaderHeight;
    self.tableView.tableHeaderView = topView;
    
    UIView *biTopInfo = [[UIView alloc] init];
    biTopInfo.layer.cornerRadius = 8.f;
//    biTopInfo.layer.masksToBounds = YES;
    [biTopInfo isYY];
    biTopInfo.backgroundColor = kBICWhiteColor;
    [topView addSubview:biTopInfo];
    
    [biTopInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView).offset(kBICMargin);
        make.right.equalTo(topView).offset(-kBICMargin);
        make.height.equalTo(@(120));
        make.top.equalTo(topView).offset(kBICMargin);
    }];
    UIView * lineBGView = [[UIView alloc] initWithFrame:CGRectMake(kBICMargin, 120+12+16, KScreenWidth-2*kBICMargin, 410+10)];
    lineBGView.backgroundColor = kBICWhiteColor;
    lineBGView.layer.cornerRadius = 8.f;
//    lineBGView.layer.masksToBounds = YES;
    [lineBGView isYY];
    [topView addSubview:lineBGView];
    
    _lineKView = [[Y_StockChartView alloc] initWithFrame:CGRectMake(16, 10, KScreenWidth-2*kBICMargin-32, 410)];
    _lineKView.backgroundColor = kBICWhiteColor;
    
    _lineKView.isFullScreen = NO;
    _isShowKLineFullScreenViewController = NO;
    _lineKView.itemModels = @[
        [Y_StockChartViewItemModel itemModelWithTitle:BTLanguage(@"分时") type:Y_StockChartcenterViewTypeKline],
        [Y_StockChartViewItemModel itemModelWithTitle:BTLanguage(@"15分") type:Y_StockChartcenterViewTypeKline],
        [Y_StockChartViewItemModel itemModelWithTitle:BTLanguage(@"1小时") type:Y_StockChartcenterViewTypeKline],
        //                              [Y_StockChartViewItemModel itemModelWithTitle:@"4小时" type:Y_StockChartcenterViewTypeKline],
        [Y_StockChartViewItemModel itemModelWithTitle:BTLanguage(@"日线") type:Y_StockChartcenterViewTypeKline],
        [Y_StockChartViewItemModel itemModelWithTitle:BTLanguage(@"更多") type:Y_StockChartcenterViewTypeOther],
        [Y_StockChartViewItemModel itemModelWithTitle:BTLanguage(@"指标") type:Y_StockChartcenterViewTypeOther],
    ];
    _lineKView.dataSource = self;
    _lineKView.delegate = self;
    
    [self addLinesView];
    
    [lineBGView addSubview:self.lineKView];
    
    //价格
    UILabel *price = [[UILabel alloc] init];
    price.text = NSStringFormat(@"%f",self.biModel.LatestPrice);
    price.textColor = kBICGetHomeTitleColor;
    price.font = BOLDSYSTEMFONT(24);
    [biTopInfo addSubview:price];
    _price = price;
    
    //涨跌
    UILabel *zfLabel = [[UILabel alloc] init];
    zfLabel.textColor = kBICGetHomePriceColor;
    //    zfLabel.text = NSStringFormat(@"¥%f %@",self.biModel.ExchangeAmt * self.biModel.CurrencyRate,self.biModel.Change);
    zfLabel.text = NSStringFormat(@"¥%f",self.biModel.ExchangeAmt * self.biModel.CurrencyRate);
    zfLabel.font = FONT_WITH_SIZE(14);
    [biTopInfo addSubview:zfLabel];
    _zfLabel = zfLabel;
    
    UILabel *zfLabelPrecent = [[UILabel alloc] init];
    zfLabelPrecent.textColor = kBICGetHomeCellBtnGColor;
    //    zfLabel.text = NSStringFormat(@"¥%f %@",self.biModel.ExchangeAmt * self.biModel.CurrencyRate,self.biModel.Change);
    zfLabelPrecent.text = self.biModel.Change?:@"0.00%";
    
    zfLabelPrecent.font = FONT_WITH_SIZE(24);
    [biTopInfo addSubview:zfLabelPrecent];
    _zfLabelPrecent = zfLabelPrecent;
    
    
    //
    UILabel *rightTL = [[UILabel alloc] init];
    
    rightTL.text = [NSString stringWithFormat:@"24H%@\n24H%@\n24H%@",LAN(@"量"),LAN(@"高"),LAN(@"低")];
    rightTL.textColor = kBICGetHomePriceColor;
    rightTL.font = FONT_WITH_SIZE(14);
    rightTL.numberOfLines = 3;
    [rightTL setSpace:rightTL.text lineSpace:8 paraSpace:0 alignment:1 kerSpace:0];
    [biTopInfo addSubview:rightTL];
    
    UILabel *rightL = [[UILabel alloc] init];
    rightL.text = @"--\n--\n--";
    rightL.textColor = kBICGetHomeCellPriceColor;
    rightL.font = FONT_WITH_SIZE(14);
    rightL.numberOfLines = 3;
    [rightL setSpace:rightL.text lineSpace:8 paraSpace:0 alignment:1 kerSpace:0];
    [biTopInfo addSubview:rightL];
    _rightL = rightL;
    
    
    
    //行情价格
    [price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(biTopInfo.mas_centerX).offset(-12);
        make.top.equalTo(biTopInfo).offset(16);
    }];
    
    //对应汇率的价格
    [zfLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(price);
        make.centerY.equalTo(biTopInfo);
    }];
    
    //涨幅
    [zfLabelPrecent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(zfLabel);
        make.bottom.equalTo(biTopInfo).offset(-16);
    }];
    
    
    [rightTL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(biTopInfo);
        make.left.equalTo(biTopInfo.mas_centerX).offset(12);
    }];
    
    [rightL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.centerY.equalTo(rightTL);
        make.left.equalTo(rightTL.mas_right).offset(7);
    }];
    
    
    
    //    UIView *line = [[UIView alloc] init];
    //    line.backgroundColor = [UIColor clearColor];
    //    [topView addSubview:line];
    //
    //    [line mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.right.bottom.equalTo(topView);
    //        make.height.mas_equalTo(10);
    //    }];
    
}

- (NSMutableDictionary<NSString *,Y_KLineGroupModel *> *)modelsDict
{
    if (!_modelsDict) {
        _modelsDict = @{}.mutableCopy;
    }
    return _modelsDict;
}

#pragma mark - Y_StockChartViewDataSource

-(id)stockDatasWithIndex:(NSInteger)index {
    NSString *type;
    switch (index) {
        case 0:type = @"1";//@"1min";
            break;
        case 1:type = @"15";//@"15min";
            break;
        case 2:type = @"60";//@"1hour";
            break;
        case 3:type = @"1440";//@"1day";
            break;
        case 5:type = @"1";//@"1min";
            break;
        case 6:type = @"5";//@"5min";
            break;
        case 7:type = @"30";//@"30min";
            break;
        case 8:type = @"10080";//@"1week";
            break;
        case 9:type = @"43200";//@"1month";
            break;
        default:
            break;
    }
    
    self.currentIndex = index;
    self.type = type;
    
    NSString * currencyPair = @"";
    if (self.model) {
        currencyPair = self.model.currencyPair;
    }else{
        currencyPair = [NSString stringWithFormat:@"%@-%@",[BICDeviceManager GetPairCoinName],[BICDeviceManager GetPairUnitName]];
    }
    
    if (index == 0 || index == 1 || index == 2 || index == 3) {
        _lineKView.isMoreTimeDataUpdate = NO;
    }
    else{
        _lineKView.isMoreTimeDataUpdate = YES;
    }
    
    //点过了就是注册过了,就不需要请求了
    if(![self.modelsDict objectForKey:type]){
        WEAK_SELF
        [[BICSockJSRouter shareInstance] SockJSKLineStartSockJS_Type:SockJS_Type_KLine CurrencyPair:currencyPair ForType:self.type KLineArrayBlock:^(Y_KLineModel *lineModel,NSString *type) {
            [weakSelf SockJSKLine:lineModel Type:type];
        }];
        
        //加载数据
        [self reloadData];
    }
    else{
        return [self.modelsDict objectForKey:type].models;
    }
    
    return nil;
}

- (void)loadBiTopMarketData
{
    BICKLineRequest * request = [[BICKLineRequest alloc] init];
    NSString * currencyPair;
    if (self.model) {
        currencyPair = self.model.currencyPair;
    }else{
        currencyPair = [NSString stringWithFormat:@"%@-%@",[BICDeviceManager GetPairCoinName],[BICDeviceManager GetPairUnitName]];
    }
    request.currencyPair = currencyPair;
    WEAK_SELF
    [[BICExchangeService sharedInstance] analyticalMarketGetData:request serverSuccessResultHandler:^(id response) {
        BICMarketGetResponse * responseM =(BICMarketGetResponse*)response;
        weakSelf.marketGetResponse = responseM;
        weakSelf.nav.marketGetResponse = weakSelf.marketGetResponse;
        BTMarketModel *marketModel = [[BTMarketModel alloc] init];
        BTDealMarketModel * dealM = [[BTDealMarketModel alloc] init];
        dealM.NewPrice = responseM.data.amount;
        
        [weakSelf updateLoadBiTopMarketUI:responseM DealM:dealM BTMarketModel:marketModel];
        
    } failedResultHandler:^(id response) {
        
    } requestErrorHandler:^(id error) {
        
    }];
    
}

-(void)updateLoadBiTopMarketUI:(BICMarketGetResponse *)responseM
                         DealM:(BTDealMarketModel *)dealM
                 BTMarketModel:(BTMarketModel *)marketModel
{
    //涨幅字段
    dealM.Change = [NSString stringWithFormat:@"%.2f%%",([responseM.data.percent floatValue] *100)];
    dealM.SumNum = [responseM.data.total doubleValue];
    dealM.HighestPrice = [responseM.data.highest doubleValue];
    dealM.LowestPrice = [responseM.data.lowest doubleValue];
    marketModel.DealMarket = dealM;
    self.marketModel = marketModel;
    
    self.price.text = marketModel.DealMarket.NewPrice;
    
    if (![responseM.data.percent containsString:@"-"]) { //涨
        self.price.textColor = kBICGetHomeTitleColor;
        if ([[BICDeviceManager getCurrentRate] isEqualToString:@"CNY"]) {
            self.zfLabel.text = NSStringFormat(@"%.2f",[responseM.data.cnyAmount floatValue]*responseM.data.amount.floatValue);
            self.zfLabel.text = NumFormat(self.zfLabel.text);
            self.zfLabel.text = NSStringFormat(@"¥%@",self.zfLabel.text);
        }
        
        if ([[BICDeviceManager getCurrentRate] isEqualToString:@"USD"]) {
            self.zfLabel.text = NSStringFormat(@"%.2f",[responseM.data.usdAmount floatValue]*responseM.data.amount.floatValue);
            self.zfLabel.text = NumFormat(self.zfLabel.text);
            self.zfLabel.text = NSStringFormat(@"$%@",self.zfLabel.text);
        }
        self.zfLabelPrecent.text = [NSString stringWithFormat:@"+%@",marketModel.DealMarket.Change];
        self.zfLabelPrecent.textColor = kBICGetHomeCellBtnGColor;
    }else{
        self.price.textColor = kBICGetHomeTitleColor;
        if ([[BICDeviceManager getCurrentRate] isEqualToString:@"CNY"]) {
            self.zfLabel.text = NSStringFormat(@"%.2f",[responseM.data.cnyAmount floatValue]*responseM.data.amount.floatValue);
            self.zfLabel.text = NumFormat(self.zfLabel.text);
            self.zfLabel.text = NSStringFormat(@"¥%@",self.zfLabel.text);
        }
        if ([[BICDeviceManager getCurrentRate] isEqualToString:@"USD"]) {
            self.zfLabel.text = NSStringFormat(@"%.2f",[responseM.data.usdAmount floatValue]*responseM.data.amount.floatValue);
            self.zfLabel.text = NumFormat(self.zfLabel.text);
            self.zfLabel.text = NSStringFormat(@"$%@",self.zfLabel.text);
        }
        
        self.zfLabelPrecent.text = [NSString stringWithFormat:@"%@",marketModel.DealMarket.Change];
        self.zfLabelPrecent.textColor = kBICGetHomePercentRColor;
    }
    
    NSString * market = responseM.data.total;
    NSString * HighestPrice = responseM.data.highest;
    NSString * LowestPrice = responseM.data.lowest;
    
    self.rightL.text = NSStringFormat(@"%@\n%@\n%@",NumFormat(market),NumFormat(HighestPrice),NumFormat(LowestPrice));
}

-(void)analyticalGetHistoryListData
{
    BICKLineRequest * request = [[BICKLineRequest alloc] init];
    
    NSString * currencyPair;
    if (self.model) {
        currencyPair = self.model.currencyPair;
    }else{
        currencyPair = [NSString stringWithFormat:@"%@-%@",[BICDeviceManager GetPairCoinName],[BICDeviceManager GetPairUnitName]];
    }
    request.currencyPair=currencyPair;
    WEAK_SELF
    [[BICExchangeService sharedInstance] analyticalGetHistoryListData:request serverSuccessResultHandler:^(id response) {
        BICGetHistoryListResponse * responseM = (BICGetHistoryListResponse*)response;
        
        weakSelf.changeDoneView.responseM = responseM;
        
        weakSelf.historyResponseM = responseM;
        
        [weakSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
        
    } failedResultHandler:^(id response) {
        
    } requestErrorHandler:^(id error) {
        
    }];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.biInfoType == 0) {
        return 2;
    }else if (self.biInfoType == 1){
        return self.dealArray.count > 20?20:self.dealArray.count;
    }else{
        return self.biInfoTitleArray.count;
    }
    return 2;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NSString* cellId = @"cellId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row==0) {
        cell.backgroundColor = kBICHistoryCellBGColor;
        [cell addSubview:self.buySaleView];
        [self.buySaleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell).offset(kBICMargin);
            make.right.equalTo(cell).offset(-kBICMargin);
            make.top.equalTo(cell).offset(12);
            make.bottom.equalTo(cell).offset(-12);
        }];
    }else if(indexPath.row==1)
    {
        cell.backgroundColor = kBICHistoryCellBGColor;
        [cell addSubview:self.changeDoneView];
        [self.changeDoneView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell).offset(kBICMargin);
            make.right.equalTo(cell).offset(-kBICMargin);
            make.top.equalTo(cell).offset(0);
            make.bottom.equalTo(cell).offset(0);
        }];
    }
    return cell;
}

-(BICEXCBuySaleView*)buySaleView
{
    if (!_buySaleView) {
        _buySaleView = [[BICEXCBuySaleView alloc] initWithNib];
    }
    return _buySaleView;
}

-(BICEXCChangeDoneView*)changeDoneView
{
    if (!_changeDoneView) {
        _changeDoneView = [[BICEXCChangeDoneView alloc] initWithNib];
    }
    return _changeDoneView;
}

-(BICEXCBomSaleBuyView*)bomSaleBuyView
{
    if (!_bomSaleBuyView) {
        _bomSaleBuyView = [[BICEXCBomSaleBuyView alloc] initWithNib];
    }
    return _bomSaleBuyView;
}
-(void)setModel:(getTopListResponse *)model
{
    _model = model;
    self.bomSaleBuyView.model = model;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        return 264.f;
    }
    if (self.historyResponseM.data.count<6) {
        return 262.f + 24*28 ;
    }else{
        if (self.historyResponseM.data.count<30) {
            return 262.f + (self.historyResponseM.data.count-6)*28;
        }else{
            return 262.f + 24*28;
        }
    }
    return 262.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    //sectionheader的高度，这是要放分段控件的
    return 0.01;
}

- (void)addLinesView {
    CGFloat white = _lineKView.bounds.size.height /4;
    CGFloat height = _lineKView.bounds.size.width /4;
    //横格
    for (int i = 0;i < 4;i++ ) {
        UIView *hengView = [[UIView alloc] initWithFrame:CGRectMake(0, white * (i + 1),_lineKView.bounds.size.width , 1)];
        hengView.backgroundColor = RGB(223, 225, 231);
        [_lineKView addSubview:hengView];
        [_lineKView sendSubviewToBack:hengView];
    }
    //竖格
    for (int i = 0;i < 4;i++ ) {
        
        UIView *shuView = [[UIView alloc]initWithFrame:CGRectMake(height * (i + 1), 47, 1, _lineKView.bounds.size.height - 62)];
        shuView.backgroundColor = RGB(223, 225, 231);
        [_lineKView addSubview:shuView];
        [_lineKView sendSubviewToBack:shuView];
        if (i==3) {
            shuView.hidden = YES;
        }
    }
    UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake(5, 245, 120, 20)];
    [logo setImage:IMAGE_NAMED(@"logo")];
    logo.contentMode = UIViewContentModeScaleAspectFit;
    [_lineKView addSubview:logo];
    [_lineKView sendSubviewToBack:logo];
}


- (void)reloadData1
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    //    {"tradeType": "3","CoinId": "4","CurrencyId": "19","LineType": 1
    param[@"tradeType"] = @"3";
    param[@"LineType"] = self.type;
    param[@"CoinId"] = @"4";
    param[@"CurrencyId"] = @"19";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Parameters"] = [param mj_JSONString];
    kWeakSelf(self)
    [FDNetworkHelper POST:@"http://43.231.184.237:8008/api/TradeCenter/GetLineData" parameters:params success:^(id responseObject) {
        
        if (responseObject[@"data"]) {
            if ([responseObject[@"data"][@"datas"][@"data"] isKindOfClass:[NSNull class]] || [responseObject[@"data"][@"datas"][@"data"] isEqual:[NSNull null]] || responseObject[@"data"][@"datas"][@"data"] == nil) {
                return ;
            }
            Y_KLineGroupModel *groupModel = [Y_KLineGroupModel objectWithArray:responseObject[@"data"][@"datas"][@"data"]];
            weakself.groupModel = groupModel;
            [weakself.modelsDict setObject:groupModel forKey:weakself.type];
            [weakself.lineKView reloadData];
        }else{
//            NSLog(@"%@",responseObject);
        }
    } failure:^(NSError *error) {
        
    }];
}
-(NSString*)getTimeType:(NSString*)type
{
    NSString* timeType = @"MINUTE";
    switch (type.intValue) {
         case 1:timeType = @"MINUTE";//@"1min";
             break;
         case 5:timeType = @"MINUTE";//@"30min";
             break;
         case 15:timeType = @"MINUTE";//@"15min";
             break;
         case 30:timeType = @"MINUTE";//@"1week";
             break;
         case 60:timeType = @"HOUR";//@"1hour";
             break;
         case 1440:timeType = @"DAY";//@"1day";
             break;
         case 10080:timeType = @"WEEK";//@"1min";
             break;

         default:
             break;
     }
    
    return timeType;
}
-(NSString*)getTimeNumber:(NSString*)type
{
    NSString* timeNumber = @"15";
    switch (type.intValue) {
         case 1:timeNumber = @"1";//@"1min";
             break;
         case 5:timeNumber = @"5";//@"30min";
             break;
         case 15:timeNumber = @"15";//@"15min";
             break;
         case 30:timeNumber = @"30";//@"1week";
             break;
         case 60:timeNumber = @"1";//@"1hour";
             break;
         case 1440:timeNumber = @"1";//@"1day";
             break;
         case 10080:timeNumber = @"1";//@"1min";
             break;

         default:
             break;
     }
    
    return timeNumber;
}
- (void)reloadData
{
    BICKLineRequest *request = [[BICKLineRequest alloc] init];
    
    if (self.model) {
        request.currencyPair = self.model.currencyPair;
    }else{
        request.currencyPair=[NSString stringWithFormat:@"%@-%@",[BICDeviceManager GetPairCoinName],[BICDeviceManager GetPairUnitName]];
    }

    request.timeType=[self getTimeType:self.type];
    request.timeNumber=[self getTimeNumber:self.type];
    
    WEAK_SELF
    [[BICExchangeService sharedInstance] analyticalMarketQueryData:request serverSuccessResultHandler:^(id response) {
        BICKLineResponse * responseM = (BICKLineResponse*)response;
        NSMutableArray * mulArr = [NSMutableArray array];
        for (kLineResponse * model in responseM.data) {
            NSMutableArray *innnerArr = [NSMutableArray array];
            [innnerArr addObject:model.timestamp];
            [innnerArr addObject:model.open];
            [innnerArr addObject:model.highest];
            [innnerArr addObject:model.lowest];
            [innnerArr addObject:model.close];
            [innnerArr addObject:model.total];
            [mulArr addObject:innnerArr];
        }
        
        Y_KLineGroupModel *groupModel = [Y_KLineGroupModel objectWithArray:mulArr];
        
        if (groupModel) {
            
            weakSelf.groupModel = groupModel;
            [weakSelf.modelsDict setObject:groupModel forKey:weakSelf.type];
            [weakSelf.lineKView reloadData];
            
        }
        
    } failedResultHandler:^(id response) {
        
    } requestErrorHandler:^(id error) {
        
    }];
    
}

- (void)showKLineFullScreenViewController{
    if (!_lineKFullScreenViewController) {
        _lineKFullScreenViewController = [[LineKFullScreenViewController alloc] init];
    }
    kWeakSelf(self);
    _lineKFullScreenViewController.biModel = self.biModel;
    _lineKFullScreenViewController.marketModel = self.marketModel;
    _lineKFullScreenViewController.onClickBackButton = ^(LineKFullScreenViewController *controller) {
        weakself.preferStatusHidden=NO;
        CGRect tempFrame = CGRectMake(KScreenWidth * 2, 0, KScreenWidth, KScreenHeight);
        if (weakself.lineKFullScreenViewController.view.frame.origin.x == 0) {
            [UIView animateWithDuration:0.35 animations:^{
                weakself.lineKFullScreenViewController.view.frame = tempFrame;
            } completion:^(BOOL finished) {
                weakself.isShowKLineFullScreenViewController = NO;
                [weakself containerRemoveChildViewController:weakself.lineKFullScreenViewController];
                [weakself.navigationController.navigationBar setHidden:YES];
            }];
        }
    };
    _lineKFullScreenViewController.view.frame = CGRectMake(KScreenWidth*2, 0, KScreenWidth, KScreenHeight);
    [_lineKFullScreenViewController.view setNeedsLayout];
    CGRect tempFrame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    if (_lineKFullScreenViewController.view.frame.origin.x > KScreenWidth) {
        [UIView animateWithDuration:0.35 animations:^{
            weakself.lineKFullScreenViewController.view.frame = tempFrame;
        } completion:^(BOOL finished) {
            
        }];
        _isShowKLineFullScreenViewController = YES;
        
        [self containerAddChildViewController:_lineKFullScreenViewController parentView:self.view];
//        [self.navigationController pushViewController:_lineKFullScreenViewController animated:YES];
    }
    
}

#pragma mark - Y_StockChartViewDelegate

- (void)onClickFullScreenButtonWithTimeType:(Y_StockChartCenterViewType )timeType{
    if (!_isShowKLineFullScreenViewController) {
        [self showKLineFullScreenViewController];
    }
}

- (void)full
{
    [self showKLineFullScreenViewController];
}

@end

//
//  BICDataToUserDefault.m
//  Biconome
//
//  Created by 车林 on 2019/9/17.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICDataToUserDefault.h"
#import "BICGetWalletsResponse.h"
#import "BICGetWalletsRequest.h"
#import "BICMarketGetResponse.h"
#import "SDArchiverTools.h"
#import "BICSockJSRouter.h"
@interface BICDataToUserDefault()

@property(nonatomic,strong) NSMutableArray *dataArray;

@property(nonatomic,strong) BICGetWalletsRequest * request;
//@property(nonatomic,strong) NSTimer * timer;
@end

@implementation BICDataToUserDefault
-(instancetype)init
{
    if ([super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSucceed:) name:NSNotificationCenterLoginSucceed object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SockJS_Type_Market:) name:NSNotificationCenteSockJSTopicMarket object:nil];

    }
    return self;
}

-(void)loginSucceed:(NSNotification*)noti
{
    [self setupData];
}
-(void)setupData
{
    //请求钱包信息,包括BTC估值,钱包列表 并保存到本地
    [self setupDataMoney:self.request];
    
    //请求美元对人民币汇率 并保存到本地
    [self loadBiTopMarketData];
    
    //开启币对SockJS
    [self sockJS];
    

//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1
//      target: self
//    selector: @selector(sendPing)
//    userInfo: nil
//     repeats: YES];
//        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
//
}

//-(void)sendPing
//{
//    double amount = [BICDeviceManager GetBICToUSDT] + [BICDeviceManager getRandomNumber:1 to:10];
//
////           RSDLog(@"amount%lf",amount);
//           SDUserDefaultsSET(@(amount), BICBTCTOUSDT);
//
//               [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenterWallectUpdate object:nil];
//}



-(NSMutableArray*)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(void)sockJS
{
    [[BICSockJSRouter shareInstance] SockJSGlobeStart];
}

-(void)SockJS_Type_Market:(NSNotification*)notify
{
    marketGetResponse  * response = notify.object;
    
    if ([response.currencyPair isEqualToString:@"BTC-USDT"]) {
        
         SDUserDefaultsSET(@(response.amount.doubleValue), BICBTCTOUSDT);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenterWallectUpdate object:nil];
        
    }
  
}



-(void)setupDataMoney:(BICGetWalletsRequest*)request
{
    WEAK_SELF
    [[BICWalletService sharedInstance] analyticalWalletUsergetWalletsNewData:request serverSuccessResultHandler:^(id response) {
        BICGetWalletsResponse  *responseM = (BICGetWalletsResponse*)response;
        if (responseM.code==200) {
            [weakSelf.dataArray removeAllObjects];
            NSArray * arr = responseM.data;
             [weakSelf.dataArray addObjectsFromArray:arr];
            
            [self setupHeaderData:weakSelf.dataArray];
        }
    } failedResultHandler:^(id response) {

    } requestErrorHandler:^(id error) {

    }];
}


-(void)setupHeaderData:(NSArray*)array
{
    [SDArchiverTools archiverObject:array ByKey:BICWALLETLISTOFMINE];
    
    kPOSTNSNotificationCenter(NSNotificationCenterBICWalletList, nil);

}


-(BICGetWalletsRequest*)request
{
    if (!_request) {
        _request = [[BICGetWalletsRequest alloc] init];
    }
    _request.walletType = @"CCT";
    return _request;
}

//请求交易对最新信息
- (void)loadBiTopMarketData
{
    BICKLineRequest * request = [[BICKLineRequest alloc] init];
    request.currencyPair = @"BTC-USDT";
    [[BICExchangeService sharedInstance] analyticalMarketGetData:request serverSuccessResultHandler:^(id response) {
        
        BICMarketGetResponse * responseM =(BICMarketGetResponse*)response;
        
        SDUserDefaultsSET(@(responseM.data.cnyAmount.doubleValue), BICUSDTYANG);
        
        SDUserDefaultsSET(@(responseM.data.amount.doubleValue), BICBTCTOUSDT);
        
    } failedResultHandler:^(id response) {
        
    } requestErrorHandler:^(id error) {
        
    }];
    
}

@end

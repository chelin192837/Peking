//
//  BICChangePriceView.m
//  Biconome
//
//  Created by 车林 on 2019/8/23.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICChangePriceView.h"
#import "BICLimitMarketRequest.h"
#import "BICCoinAndUnitResponse.h"
#import "BICGetCoinPairConfigResponse.h"
#import "BICGetWalletsResponse.h"
#import "BICGetWalletsRequest.h"
#import "BICEXCMainVC.h"
#import "BICLoginVC.h"
#import "BICMarketGetResponse.h"
#import "UIView+shadowPath.h"
#import "UIControl+ZHW.h"

static CGFloat leftMargin = 12.f;
static CGFloat middenMargin = 0.f;

@interface BICChangePriceView()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topMargin;

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *percentView;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *mainBGView;

@property(nonatomic,strong)BICLimitMarketRequest *request;
@property (weak, nonatomic) IBOutlet UITextField *firstTex;
@property (weak, nonatomic) IBOutlet UITextField *secondTex;
@property (weak, nonatomic) IBOutlet UITextField *threeTex;

@property (weak, nonatomic) IBOutlet UILabel *priceLab;//价格
@property (weak, nonatomic) IBOutlet UILabel *numLab;//数量
@property (weak, nonatomic) IBOutlet UILabel *chargeLab;//成交额
@property (weak, nonatomic) IBOutlet UILabel *startPriceLab;

@property (weak, nonatomic) IBOutlet UILabel *CPriceLab;
@property(nonatomic,strong)BICGetCoinPairConfigResponse * response;

@property(nonatomic,strong)NSMutableArray * dataArray;

@property(nonatomic,strong)BICGetWalletsRequest * walletRequest;

@property(nonatomic,strong)GetWalletsResponse * getWalletsResponse;


@property (weak, nonatomic) IBOutlet UIView *zeroView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *zeroHeight;
@property (weak, nonatomic) IBOutlet UITextField *zeroTex;


@property(nonatomic,assign)BOOL isHaveDian;

@property(nonatomic,assign)BOOL isFirstZero;

@end

@implementation BICChangePriceView

-(instancetype)initWithNib
{
    self = [[NSBundle mainBundle] loadNibNamed:@"BICChangePriceView" owner:nil options:nil][0];
    kADDNSNotificationCenter(NSNotificationCenterBICChangeSocketView);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changePriceNotify:) name:NSNotificationCenterBICChangePriceConfig object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupWalletList) name:NSNotificationCenterBICWalletList object:nil];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSucceed:) name:NSNotificationCenterLoginSucceed object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(horLineToChangePrice:) name:NSNotificationCenterHorLineToChangePrice object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(middenPrice:) name:NSNotificationCenterMarketGet object:nil];


    self.CPriceLab.text = LAN(@"触发价格");
    
    self.mainBGView.layer.cornerRadius = 8.f;
//    self.mainBGView.layer.masksToBounds = YES;
    [self.mainBGView isYY];
    
    self.zeroTex.delegate = self;
    self.firstTex.delegate = self;
    self.secondTex.delegate = self;
    self.threeTex.delegate = self;
    if (![BICDeviceManager isLogin]) {
        [self.confirmBtn setTitle:LAN(@"登录") forState:UIControlStateNormal];
    }
    [self.firstTex addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
       [self.secondTex addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
       [self.threeTex addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.confirmBtn viewShadowPathWithColor:[UIColor blackColor] shadowOpacity:0.2 shadowRadius:4 shadowPathType:LeShadowPathCommon shadowPathWidth:7];

    self.confirmBtn.zhw_acceptEventInterval = 3 ;
    
    [self setupWalletList];

    return self;
}
-(void)horLineToChangePrice:(NSNotification*)notify
{
    BUYSALE_ORDERS* model = notify.object;
    if (model) {
        NSString * value = [NSString stringWithFormat:@"%.8lf",self.firstTex.text.doubleValue * self.secondTex.text.doubleValue];
        if(self.response.data.coinDecimals){
            self.firstTex.text =[BICDeviceManager changeFormatter:model.unitPrice length:self.response.data.coinDecimals.integerValue];
            self.threeTex.text =[BICDeviceManager changeFormatter:value length:self.response.data.coinDecimals.integerValue];
        }else{
            self.firstTex.text = model.unitPrice;
            self.threeTex.text = value;
        }
        
    }

}
-(void)middenPrice:(NSNotification*)noti
{
    BICMarketGetResponse * responseM = noti.object;
    if (responseM) {
        
        if(self.response.data.coinDecimals){
            self.firstTex.text =[BICDeviceManager changeFormatter:responseM.data.amount length:self.response.data.coinDecimals.integerValue];
        }else{
            self.firstTex.text = responseM.data.amount;
        }

    }
}
-(BICLimitMarketRequest*)request
{
    if (!_request) {
        _request = [[BICLimitMarketRequest alloc] init];
    }
    return _request;
}
-(void)updateUI:(ChangePriceType)priceType OrderType:(ChangeOrderType)orderType
{
    _priceType = priceType;
    _orderType = orderType;
    
    if (orderType==ChangeOrderType_Limit) {
        self.topMargin.constant = 142.f;
        self.topView.hidden = NO;
        
        self.zeroHeight.constant = 0.f;
        self.zeroView.hidden = YES;
        

    }
    
    if (orderType==ChangeOrderType_Market) {
        
        self.topMargin.constant = 0.f;
        self.topView.hidden = YES;
        
        self.zeroHeight.constant = 0.f;
        self.zeroView.hidden = YES;
    }
    
    
    if (orderType==ChangeOrderType_Stop) {
        
//        self.topMargin.constant = 0.f;
//        self.topView.hidden = YES;

    }
    
    if (priceType==ChangePriceType_Sale) {
        
        self.confirmBtn.backgroundColor = kBICGetHomePercentRColor;
        [self.confirmBtn setTitle:LAN(@"卖出") forState:UIControlStateNormal];
        
    }
    if (priceType==ChangePriceType_Buy) {
        
        self.confirmBtn.backgroundColor = kBICGetHomeCellBtnGColor;
        [self.confirmBtn setTitle:LAN(@"买入") forState:UIControlStateNormal];
    }
    
    self.confirmBtn.layer.cornerRadius = 4.f;

    if (![BICDeviceManager isLogin]) {
        [self.confirmBtn setTitle:LAN(@"登录") forState:UIControlStateNormal];
    }

    [self.percentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSArray * arr = @[@"25%",@"50%",@"75%",@"100%"];
    
    CGFloat with = self.percentView.width/4;
    
    CGFloat height = 24.f;
    
    CGFloat y = 12.f ;
    
    for (int i=0; i<4; i++) {
        CGFloat x = i*with;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, y, with, height)];
        button.tag = 100+i;
        [button setTitle:arr[i] forState:UIControlStateNormal];
        if (i==0) {
            [self setHightLightBtn:button WithColor:kBICSYSTEMBGColor WithBool:YES];
        }else
        {
            [self setHightLightBtn:button WithColor:kBoardTextColor WithBool:NO];
        }
        button.titleLabel.font=[UIFont systemFontOfSize:11.f];
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.percentView addSubview:button];
    }
    NSString * NumStr = LAN(@"数量");
    NSString * ChangeStr = LAN(@"成交额");
    if (_priceType==ChangePriceType_Sale) {
        if(self.orderType==ChangeOrderType_Market){
            self.chargeLab.text = [NSString stringWithFormat:@"%@(%@)",NumStr,[BICDeviceManager GetPairCoinName]];
        }else{
            self.chargeLab.text = [NSString stringWithFormat:@"%@(%@)",ChangeStr,[BICDeviceManager GetPairUnitName]];
        }
    }
    if (_priceType==ChangePriceType_Buy) {
        self.chargeLab.text = [NSString stringWithFormat:@"%@(%@)",ChangeStr,[BICDeviceManager GetPairUnitName]];
    }
    [self layoutSubviews];
}
-(void)loginSucceed:(NSNotification*)noti
{
    [self updateUI:_priceType OrderType:_orderType];
}

-(void)click:(UIButton*)sender
{

    for (UIButton *btn in self.percentView.subviews) {
        if (btn!=sender) {
            [self setHightLightBtn:btn WithColor:kBoardTextColor WithBool:NO];
        }else{
            [self setHightLightBtn:btn WithColor:kBICSYSTEMBGColor WithBool:YES];
        }
    }
  
    if (self.getWalletsResponse.freeBalance.doubleValue > 0) {
       
        if (self.priceType == ChangePriceType_Buy) {
            if ((self.firstTex.text.length==0) &&
                (self.secondTex.text.length==0)) {
                return;
            }else{
                [self Calculation:(int)sender.tag];
            }

        }else{
            [self Calculation:(int)sender.tag];
        }

    }
    
}

- (IBAction)confirmClick:(id)sender {
    
    if (![BICDeviceManager isLogin]) {//跳转到登录页面
        BICLoginVC * loginVC = [[BICLoginVC alloc] initWithNibName:@"BICLoginVC" bundle:nil];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
            
        }];
        return;
    }
    
    [self Verification];
}

-(void)requestOrder{
    self.request.coinName = [BICDeviceManager GetPairCoinName];
       self.request.unitName = [BICDeviceManager GetPairUnitName];
       //buy 3 3 3   sale 2 3 3
       if (_orderType==ChangeOrderType_Limit) {
           self.request.totalNum = self.secondTex.text;
           self.request.unitPrice = self.firstTex.text;
           if (_priceType==ChangePriceType_Sale) {
               self.request.orderType=@"SELL";
               self.request.publishType=@"LIMIT";
               [self analyticalNewOrderData];
           }
           if (_priceType==ChangePriceType_Buy) {
               self.request.orderType=@"BUY";
               self.request.publishType=@"LIMIT";
               [self analyticalNewOrderData];
           }
       }
       
       if (_orderType==ChangeOrderType_Market) {

           if (_priceType==ChangePriceType_Sale) {
               self.request.orderType=@"SELL";
               self.request.publishType=@"MARKET";
               self.request.totalNum = self.threeTex.text;
               [self analyticalNewOrderData];
           }
           if (_priceType==ChangePriceType_Buy) {
               self.request.orderType=@"BUY";
               self.request.publishType=@"MARKET";
               self.request.turnover = self.threeTex.text;
               self.request.totalTurnover=self.threeTex.text;
               [self analyticalNewOrderData];
           }
       }
       
       if (_orderType==ChangeOrderType_Stop) {
           
           self.request.totalNum = self.secondTex.text;
           self.request.unitPrice = self.firstTex.text;
           self.request.triggerPrice = self.zeroTex.text;
           self.request.publishType=@"STOP";
           if (_priceType==ChangePriceType_Sale) {
               self.request.orderType=@"SELL";
               [self analyticalNewOrderData];
           }
           if (_priceType==ChangePriceType_Buy) {
               self.request.orderType=@"BUY";
               [self analyticalNewOrderData];
           }
       }
}


-(void)analyticalOrderLimitBuyData
{
    [ODAlertViewFactory showLoadingViewWithView:self];
    WEAK_SELF
    [[BICExchangeService sharedInstance] analyticalOrderLimitBuyData:self.request serverSuccessResultHandler:^(id response) {
        BICBaseResponse * responseM = (BICBaseResponse*)response;
        
        if (responseM.code==200) {
            [BICDeviceManager AlertShowTip:LAN(@"买入成功")];
            [weakSelf.vc setupRefresh];
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
        [ODAlertViewFactory hideAllHud:weakSelf];
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf];
    }];
}
-(void)analyticalOrderMarketBuyData
{
    [ODAlertViewFactory showLoadingViewWithView:self];
    WEAK_SELF
    [[BICExchangeService sharedInstance] analyticalOrderMarketBuyData:self.request serverSuccessResultHandler:^(id response) {
        BICBaseResponse * responseM = (BICBaseResponse*)response;
        
        if (responseM.code==200) {
            [BICDeviceManager AlertShowTip:LAN(@"买入成功")];
//            [weakSelf.vc setupRefresh];
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
        [ODAlertViewFactory hideAllHud:weakSelf];
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf];
    }];
}
//新下单
-(void)analyticalNewOrderData
{
    [ODAlertViewFactory showLoadingViewWithView:self];
    WEAK_SELF
    [[BICExchangeService sharedInstance] analyticalNewOrderData:self.request serverSuccessResultHandler:^(id response) {
        BICBaseResponse * responseM = (BICBaseResponse*)response;
        
        if (responseM.code==200) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:ISNeedUpdateExchangeView];
            [[NSUserDefaults standardUserDefaults] synchronize];
            if([weakSelf.request.orderType isEqualToString:@"BUY"]){
                [BICDeviceManager AlertShowTip:LAN(@"买入成功")];
            }else{
                [BICDeviceManager AlertShowTip:LAN(@"卖出成功")];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenterCurrentDelegateNotify object:nil];

//            [weakSelf.vc setupRefresh];
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
        [ODAlertViewFactory hideAllHud:weakSelf];
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf];
    }];
}

-(void)analyticalOrderLimitSellData
{
    [ODAlertViewFactory showLoadingViewWithView:self];
    WEAK_SELF
    [[BICExchangeService sharedInstance] analyticalOrderLimitSellData:self.request serverSuccessResultHandler:^(id response) {
        BICBaseResponse * responseM = (BICBaseResponse*)response;
        
        if (responseM.code==200) {
            
            [BICDeviceManager AlertShowTip:LAN(@"卖出成功")];
            [weakSelf.vc setupRefresh];
            
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
        [ODAlertViewFactory hideAllHud:weakSelf];
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf];
    }];
}
-(void)analyticalOrderMarketSellData
{
    [ODAlertViewFactory showLoadingViewWithView:self];
    WEAK_SELF
    [[BICExchangeService sharedInstance] analyticalOrderMarketSellData:self.request serverSuccessResultHandler:^(id response) {
        BICBaseResponse * responseM = (BICBaseResponse*)response;
        
        if (responseM.code==200) {
            
            [BICDeviceManager AlertShowTip:LAN(@"卖出成功")];
            [weakSelf.vc setupRefresh];
            
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
        [ODAlertViewFactory hideAllHud:weakSelf];
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf];
    }];
}
-(void)analyticalOrderStopSellData
{
    [ODAlertViewFactory showLoadingViewWithView:self];
    WEAK_SELF
    [[BICExchangeService sharedInstance] analyticalOrderStopSellData:self.request serverSuccessResultHandler:^(id response) {
        BICBaseResponse * responseM = (BICBaseResponse*)response;
        
        if (responseM.code==200) {
            
            [BICDeviceManager AlertShowTip:LAN(@"卖出成功")];
            [weakSelf.vc setupRefresh];
            
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
        [ODAlertViewFactory hideAllHud:weakSelf];
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf];
    }];
}
-(void)analyticalOrderStopBuyData
{
    [ODAlertViewFactory showLoadingViewWithView:self];
    WEAK_SELF
    [[BICExchangeService sharedInstance] analyticalOrderStopBuyData:self.request serverSuccessResultHandler:^(id response) {
        BICBaseResponse * responseM = (BICBaseResponse*)response;
        
        if (responseM.code==200) {
            
            [BICDeviceManager AlertShowTip:LAN(@"买入成功")];
            [weakSelf.vc setupRefresh];
            
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
        [ODAlertViewFactory hideAllHud:weakSelf];
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf];
    }];
}
-(void)setHightLightBtn:(UIButton*)sender WithColor:(UIColor*)color WithBool:(BOOL)index
{
    sender.layer.cornerRadius = 4.f;
    [sender setTitleColor:color forState:UIControlStateNormal];
    if (index) {
        sender.layer.borderColor = color.CGColor;
        sender.layer.borderWidth = 1.f ;
    }else{
        sender.layer.borderColor = [UIColor clearColor].CGColor;
    }
}
-(void)notify:(NSNotification*)notify
{
    NSLog(@"coin--%@--unit--%@",[BICDeviceManager GetPairCoinName],[BICDeviceManager GetPairUnitName]);
    NSString * priceStr = LAN(@"价格");
    NSString * NumStr = LAN(@"数量");
    NSString * ChangeStr = LAN(@"成交额");

    self.priceLab.text = [NSString stringWithFormat:@"%@(%@)",priceStr,[BICDeviceManager GetPairUnitName]];
    self.numLab.text = [NSString stringWithFormat:@"%@(%@)",NumStr,[BICDeviceManager GetPairCoinName]];
   
    NSString * pair = @"";
    if (_priceType==ChangePriceType_Sale) {
        if(self.orderType==ChangeOrderType_Market){
            pair =[BICDeviceManager GetPairCoinName];
            self.chargeLab.text = [NSString stringWithFormat:@"%@(%@)",NumStr,pair];
        }else{
            pair =[BICDeviceManager GetPairUnitName];
            self.chargeLab.text = [NSString stringWithFormat:@"%@(%@)",ChangeStr,pair];
        }
    }
    if (_priceType==ChangePriceType_Buy) {
        pair =[BICDeviceManager GetPairUnitName];
        self.chargeLab.text = [NSString stringWithFormat:@"%@(%@)",ChangeStr,pair];

    }
    
    self.startPriceLab.text=[NSString stringWithFormat:@"%@(%@)",LAN(@"触发价格"),[BICDeviceManager GetPairUnitName]];

}

-(void)changePriceNotify:(NSNotification *)notify
{
    BICGetCoinPairConfigResponse * responseM = notify.object;
    
    self.response = responseM;
    
    NSArray *arr = [BICDeviceManager GetWalletList];
    
    if (arr.count > 0) {
        
        self.dataArray = [NSMutableArray arrayWithArray:arr];
    }
    
    [self setupGetWallletResponse];

}

-(void)setupWalletList
{
    
    NSArray *arr = [BICDeviceManager GetWalletList];
    
    RSDLog(@"GetWalletList--%@",arr);

    if (arr.count > 0) {
        
        self.dataArray = [NSMutableArray arrayWithArray:arr];
    }
    
    [self setupGetWallletResponse];
}

-(NSMutableArray*)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(BICGetWalletsRequest*)walletRequest
{
    if (!_walletRequest) {
        _walletRequest = [[BICGetWalletsRequest alloc] init];
    }
    _walletRequest.walletType = @"CCT";
    return _walletRequest;
}

-(void)setupGetWallletResponse
{
    self.getWalletsResponse = nil;
  
    //买入,取unit
    if (self.priceType==ChangePriceType_Buy) {
        for (GetWalletsResponse* model in self.dataArray) {
            if ([model.tokenSymbol isEqualToString:[BICDeviceManager GetPairUnitName]]) {
                self.getWalletsResponse = model;
            }
        }
    }
    
    //卖出,取coin
    if (self.priceType==ChangePriceType_Sale) {
        for (GetWalletsResponse* model in self.dataArray) {
            if ([model.tokenSymbol isEqualToString:[BICDeviceManager GetPairCoinName]]) {
                self.getWalletsResponse = model;
            }
        }
    }

}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    NSInteger limited = 8;//小数点后需要限制的个数
    if (textField==self.firstTex) {
        limited = self.response.data.coinDecimals.integerValue;
    }
    if (textField==self.secondTex) {
        limited = self.response.data.numDecimals.integerValue;
    }
    
    if (textField==self.threeTex || textField==self.zeroTex) {
        limited = self.response.data.coinDecimals.integerValue;
    }
    //    限制只能输入数字
    BOOL isHaveDian = YES;
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    
    if ([textField.text rangeOfString:@"."].location == NSNotFound) {
        isHaveDian = NO;
    }
    
    
    
    if ([string length] > 0) {
        
        unichar single = [string characterAtIndex:0];//当前输入的字符
        if ((single >= '0' && single <= '9') || single == '.') {//数据格式正确
            
            if([textField.text length] == 0){
                if(single == '.') {
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            
            //输入的字符是否是小数点
            if (single == '.') {
                if(!isHaveDian)//text中还没有小数点
                {
                    isHaveDian = YES;
                    return YES;
                    
                }else{
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }else{
                if (isHaveDian) {//存在小数点
                    
                    //判断小数点的位数
                    NSRange ran = [textField.text rangeOfString:@"."];
                    if (range.location - ran.location <= limited) {
                        return YES;
                    }else{
                        return NO;
                    }
                }else{
                    return YES;
                }
            }
            
//            return [self validateDian:textField Range:range String:string Limit:limited];

        }
        else{//输入的数据格式不正确
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
        
    }
    else
    {
        
        return YES;
    }

}

-(BOOL)validateDian:(UITextField*)textField
              Range:(NSRange)range
             String:(NSString*)string
             Limit :(NSInteger)limited
{
    if(textField) {
    if([textField.text rangeOfString:@"."].location==NSNotFound) {
    _isHaveDian=NO;
    }
    if([textField.text rangeOfString:@"0"].location==NSNotFound) {
    _isFirstZero=NO;
    }
    if([string length]>0)
    {
    unichar single=[string characterAtIndex:0];//当前输入的字符
    if((single >='0'&& single<='9') || single=='.')//数据格式正确
    {
    if([textField.text length]==0){
    if(single =='.'){
    //首字母不能为小数点
    return NO;
    }

    if(single =='0') {
    _isFirstZero=YES;
    return YES;
    }
    }
    if(single=='.'){
    if(!_isHaveDian)//text中还没有小数点
    {
    _isHaveDian=YES;
    return YES;
    }else{
    return NO;
    }
    }else if(single=='0'){
    if((_isFirstZero&&_isHaveDian)||(!_isFirstZero&&_isHaveDian)) {
    //首位有0有.（0.01）或首位没0有.（10200.00）可输入两位数的0
    if([textField.text isEqualToString:@"0.0"]){
    return NO;
    }
    NSRange ran=[textField.text rangeOfString:@"."];
    int tt=(int)(range.location-ran.location);
    if(tt <=2){
    return YES;
    }else{
    return NO;
    }
    }else if(_isFirstZero&&!_isHaveDian){
    //首位有0没.不能再输入0
    return NO;
    }else{
    return YES;
    }
    }else{
    if(_isHaveDian){
    //存在小数点，保留两位小数
    NSRange ran=[textField.text rangeOfString:@"."];
    int tt= (int)(range.location-ran.location);
    if(tt <=2){
    return YES;
    }else{
    return NO;
    }
    }else if(_isFirstZero&&!_isHaveDian){
    //首位有0没点
    return NO;
    }else{
    return YES;
    }
    }
    }else{
    //输入的数据格式不正确
    return NO;
    }
    }else{
    return YES;
    }
    }
    return YES;
}


- (void)textFieldDidChange:(id)sender {
    
    UITextField *_field = (UITextField *)sender;
    
    NSLog(@"%@",[_field text]);
    
    [self CalculationTextField:_field];

    
}
-(void)formatTextView
{
    
}
//输入框的计算
-(void)CalculationTextField:(UITextField *)textField
{
    if (textField != self.threeTex) {
        //两个输入框都有值,才计算
        if ((self.firstTex.text.length>0)&&(self.firstTex.text.length>0)) {
            NSString * value = [NSString stringWithFormat:@"%.8lf",self.firstTex.text.doubleValue * self.secondTex.text.doubleValue];
            if(self.response.data.coinDecimals){
                self.threeTex.text =[BICDeviceManager changeFormatter:value length:self.response.data.coinDecimals.integerValue];
            }else{
                self.threeTex.text = value;
            }
        }
    }
    
    if (textField == self.threeTex) {
        if ((self.firstTex.text.length>0)&&(self.firstTex.text.doubleValue !=0 )) {
            NSString * value = [NSString stringWithFormat:@"%.8lf",self.threeTex.text.doubleValue / self.firstTex.text.doubleValue];
            if(self.response.data.numDecimals){
                self.secondTex.text = [BICDeviceManager changeFormatter:value length:self.response.data.numDecimals.integerValue];
            }else{
                self.secondTex.text = value;
            }
        }
    }

}

//百分比的计算
-(void)Calculation:(int)index
{
  
    float percent = (index-100)*0.25 + 0.25;
    
    if (self.getWalletsResponse.freeBalance.doubleValue > 0) {
        if(self.response.data.coinDecimals){
            self.threeTex.text =[BICDeviceManager changeFormatter:[NSString stringWithFormat:@"%.8lf",self.getWalletsResponse.freeBalance.doubleValue * percent] length:self.response.data.coinDecimals.integerValue];
        }else{
            self.threeTex.text = [NSString stringWithFormat:@"%.8lf",self.getWalletsResponse.freeBalance.doubleValue * percent];
        }
        
        // 根据单价算数量
        if ((self.firstTex.text.length > 0)&&(self.firstTex.text.doubleValue !=0)) {
            
            double secondFloat = self.getWalletsResponse.freeBalance.doubleValue * percent/self.firstTex.text.doubleValue;
            if(self.response.data.numDecimals){
               self.secondTex.text = [BICDeviceManager changeFormatter:[NSString stringWithFormat:@"%.8lf",secondFloat] length:self.response.data.numDecimals.integerValue];
           }else{
               self.secondTex.text = [NSString stringWithFormat:@"%.8lf",secondFloat];
           }
            
        }
        
        //根据数量算单价
        if ((self.secondTex.text.length > 0)&&((self.secondTex.text.doubleValue !=0))) {
            
            double firstFloat = self.getWalletsResponse.freeBalance.doubleValue * percent/self.secondTex.text.doubleValue;
            if(self.response.data.coinDecimals){
                self.firstTex.text =[BICDeviceManager changeFormatter:[NSString stringWithFormat:@"%.8lf",firstFloat] length:self.response.data.coinDecimals.integerValue];
            }else{
                self.firstTex.text = [NSString stringWithFormat:@"%.8lf",firstFloat];
            }
            
        }
    }
    
}

//进行余额校验
-(void)requestWalletUsergetWalletsNewData
{
    WEAK_SELF
    BICGetWalletsRequest*request=[[BICGetWalletsRequest alloc] init];
    request.walletType=@"CCT";
    [ODAlertViewFactory showLoadingViewWithView:self];
    [[BICWalletService sharedInstance] analyticalWalletUsergetWalletsNewData:request serverSuccessResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf];
        BICGetWalletsResponse  *responseM = response;
        if (responseM.code==200) {
            NSArray * arr = responseM.data;
            GetWalletsResponse *buyEnd=nil;
            GetWalletsResponse *sellEnd=nil;
            for(int i=0;i<arr.count;i++){
                GetWalletsResponse *res=[arr objectAtIndex:i];
                if([res.tokenSymbol isEndWithString:[BICDeviceManager GetPairUnitName]]){
                    buyEnd=res;
                    break;
                }
            }
            
            for(int i=0;i<arr.count;i++){
                GetWalletsResponse *res=[arr objectAtIndex:i];
                if([res.tokenSymbol isEndWithString:[BICDeviceManager GetPairCoinName]]){
                    sellEnd=res;
                    break;
                }
            }
            
            if(!buyEnd){
                [BICDeviceManager AlertShowTip:[NSString stringWithFormat:@"%@",LAN(@"余额不足")]];
                return;
            }
            
            if(!sellEnd){
                [BICDeviceManager AlertShowTip:[NSString stringWithFormat:@"%@",LAN(@"余额不足")]];
                return;
            }
            
            //卖出 比较数量
            if (weakSelf.priceType==ChangePriceType_Sale) {
                if(weakSelf.orderType==ChangeOrderType_Limit || weakSelf.orderType==ChangeOrderType_Stop){
                    if([weakSelf.secondTex.text doubleValue]>[sellEnd.freeBalance doubleValue]){
                        [BICDeviceManager AlertShowTip:[NSString stringWithFormat:@"%@%@",LAN(@"数量不能大于"),sellEnd.freeBalance]];
                        return;
                    }
                }else{
                    if([weakSelf.threeTex.text doubleValue]>[sellEnd.freeBalance doubleValue]){
                        [BICDeviceManager AlertShowTip:[NSString stringWithFormat:@"%@%@",LAN(@"数量不能大于"),sellEnd.freeBalance]];
                        return;
                    }
                }
            //买入 比较成交额
            }else if (weakSelf.priceType==ChangePriceType_Buy) {
                if([weakSelf.threeTex.text doubleValue]>[buyEnd.freeBalance doubleValue]){
                    [BICDeviceManager AlertShowTip:[NSString stringWithFormat:@"%@%@",LAN(@"成交额不能大于"),buyEnd.freeBalance]];
                    return;
                }
            }
            
            //校验完成 进行下单操作
            [weakSelf requestOrder];
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf];
    }];
}
-(void)Verification
{
    if (self.orderType==ChangeOrderType_Limit) {
        
        if (self.response.data.lowest) {
            if (self.firstTex.text.doubleValue < self.response.data.lowest.doubleValue) {
                [BICDeviceManager AlertShowTip:[NSString stringWithFormat:@"%@%@",LAN(@"买入价格不能小于"),self.response.data.lowest]];
                return;
            }
        }
     
        if (self.response.data.highest) {
            if (self.firstTex.text.doubleValue > self.response.data.highest.doubleValue) {
                [BICDeviceManager AlertShowTip:[NSString stringWithFormat:@"%@%@",LAN(@"买入价格不能大于"),self.response.data.highest]];
                return;
            }
        }
      
        if (self.secondTex.text.length==0) {
            [BICDeviceManager AlertShowTip:LAN(@"委托数量不能为空")];
            return;

        }
        
        if (self.secondTex.text.doubleValue < self.response.data.minNum.doubleValue) {
            
              [BICDeviceManager AlertShowTip:[NSString stringWithFormat:@"%@ %@%@",LAN(@"最小下单量为:"),self.response.data.minNum,[BICDeviceManager GetPairCoinName]]];
              return;

          }
          
        
//        minNum
        
    }
    
    if (self.orderType==ChangeOrderType_Market) {
        if (self.priceType == ChangePriceType_Sale) {
            
            if (self.threeTex.text.doubleValue < self.response.data.minNum.doubleValue) {
                     
                       [BICDeviceManager AlertShowTip:[NSString stringWithFormat:@"%@ %@%@",LAN(@"最小下单量为:"),self.response.data.minNum,[BICDeviceManager GetPairCoinName]]];
                       return;

                   }
            
        }
        
    }
    
    if (self.orderType==ChangeOrderType_Stop) {
        if (self.zeroTex.text.length==0) {
            [BICDeviceManager AlertShowTip:LAN(@"触发价格不能为空")];
            return;
        }
        
        if ([self.zeroTex.text doubleValue]==0) {
            [BICDeviceManager AlertShowTip:LAN(@"触发价格不能为0")];
            return;
        }
        
        
        if (self.response.data.lowest) {
            if (self.firstTex.text.doubleValue < self.response.data.lowest.doubleValue) {
                [BICDeviceManager AlertShowTip:[NSString stringWithFormat:@"%@%@",LAN(@"买入价格不能小于"),self.response.data.lowest]];
                return;
            }
        }
        
        if (self.response.data.highest) {
            if (self.firstTex.text.doubleValue > self.response.data.highest.doubleValue) {
                [BICDeviceManager AlertShowTip:[NSString stringWithFormat:@"%@%@",LAN(@"买入价格不能大于"),self.response.data.highest]];
                return;
            }
        }
        
        if (self.secondTex.text.length==0) {
            [BICDeviceManager AlertShowTip:LAN(@"委托数量不能为空")];
            return;

        }
        
        if (self.secondTex.text.doubleValue < self.response.data.minNum.doubleValue) {
            
              [BICDeviceManager AlertShowTip:[NSString stringWithFormat:@"%@ %@%@",LAN(@"最小下单量为:"),self.response.data.minNum,[BICDeviceManager GetPairCoinName]]];
              return;

          }
    

    }

    [self requestWalletUsergetWalletsNewData];
}




@end

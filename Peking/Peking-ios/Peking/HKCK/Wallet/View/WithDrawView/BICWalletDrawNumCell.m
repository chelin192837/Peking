//
//  BICWalletDrawNumCell.m
//  Biconome
//
//  Created by 车林 on 2019/9/2.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICWalletDrawNumCell.h"
#import "BICSendRegCodeRequest.h"
#import "BICSWViewController.h"
#import "WKWebViewController.h"
@interface BICWalletDrawNumCell()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *balanceLab;

@property (weak, nonatomic) IBOutlet UILabel *minWdAmountLab;
@property (weak, nonatomic) IBOutlet UILabel *limitPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *gasPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *accountLab;

@property (weak, nonatomic) IBOutlet UITextField *numField;
@property (weak, nonatomic) IBOutlet UIButton *drawBtn;



@property (weak, nonatomic) IBOutlet UILabel *drawCoinNumLab;

@end

@implementation BICWalletDrawNumCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Initialization code
    self.numField.delegate = self;
    
    [self.drawBtn setTitle:LAN(@"提币") forState:UIControlStateNormal];
    
    self.drawCoinNumLab.text = LAN(@"提币数量");
    
    self.accountLab.text = [NSString stringWithFormat:@"%@: 0.0000000",LAN(@"实际到账")];

}

+(instancetype)exitWithTableView:(UITableView*)tableView
{
    NSString* cellId = @"BICWalletDrawNumCell";
    BICWalletDrawNumCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
    }
    return cell;
}
-(void)setResponse:(GetWalletsResponse *)response
{
    _response = response;

    NSDictionary *attributes = @{NSFontAttributeName:self.balanceLab.font,NSForegroundColorAttributeName:UIColorWithRGB(0x6653FF)};
    NSDictionary *attributes2 = @{NSFontAttributeName:self.balanceLab.font,NSForegroundColorAttributeName:self.balanceLab.textColor};
    NSMutableAttributedString *balanceValue1=[[NSMutableAttributedString alloc] initWithString:LAN(@"可用") attributes:attributes2];
    NSMutableAttributedString *balanceValue2=[[NSMutableAttributedString alloc] initWithString:NumFormat(response.freeBalance) attributes:attributes];
    NSMutableAttributedString *balanceValue3=[[NSMutableAttributedString alloc] initWithString:response.tokenSymbol attributes:attributes2];
    [balanceValue1 appendAttributedString:balanceValue2];
    [balanceValue1 appendAttributedString:balanceValue3];
    self.balanceLab.attributedText=balanceValue1;
    self.balanceLab.userInteractionEnabled=YES;
    UITapGestureRecognizer*tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(freeBalanceClick)];
    [self.balanceLab addGestureRecognizer:tapGesture];
    
    self.minWdAmountLab.text = [NSString stringWithFormat:@"%@: %@ %@",LAN(@"最小提币数量"),NumFormat(response.minWdAmount),response.tokenSymbol];
    
    self.limitPriceLab.text = [NSString stringWithFormat:@"%@: %@ %@",LAN(@"限额"),NumFormat(response.limitPrice),response.tokenSymbol];
    
    self.gasPriceLab.text = [NSString stringWithFormat:@"%@: %@ %@",LAN(@"手续费"),NumFormat(response.gasPrice?:@"0"),response.tokenSymbol];
    
    self.accountLab.text = [NSString stringWithFormat:@"%@: 0.0000000 %@",LAN(@"实际到账"),response.tokenSymbol];
    
}

-(void)freeBalanceClick{
    self.numField.text=self.response.freeBalance;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
 
    NSInteger limited = 8;//小数点后需要限制的个数

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
        }else{//输入的数据格式不正确
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    else
    {
        return YES;
    }
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CGFloat account =textField.text.doubleValue - _response.gasPrice.doubleValue;
   
    if (account > 0.f) {
        NSString * str =[NSString stringWithFormat:@"%.8lf",account];
        self.accountLab.text = [NSString stringWithFormat:@"%@: %@ %@",LAN(@"实际到账"),NumFormat(str),_response.tokenSymbol];
    }
}

- (IBAction)btnClick:(id)sender {
    
    if (self.numField.text.length<1) {
        [BICDeviceManager AlertShowTip:LAN(@"提币数量必填")];
        return;
    }
    if(self.numField.text.doubleValue>self.response.freeBalance.doubleValue){
        [BICDeviceManager AlertShowTip:[NSString stringWithFormat:@"%@ %@",LAN(@"可用"),_response.freeBalance]];
        return;
    }
    if (self.numField.text.doubleValue >_response.limitPrice.doubleValue ) { //限额
        
        [BICDeviceManager AlertShowTip:[NSString stringWithFormat:@"%@ %@",LAN(@"最大提币数量为:"),_response.limitPrice]];
        return;
    }
    if (self.numField.text.doubleValue < _response.minWdAmount.doubleValue ) { //最小提币数量
        [BICDeviceManager AlertShowTip:[NSString stringWithFormat:@"%@ %@",LAN(@"最小提币数量为:"),_response.minWdAmount]];
        return;
    }
    
    if (self.response.toAddr.length==0)
    {
        [BICDeviceManager AlertShowTip:LAN(@"请输入提现地址")];
        return;
    }
    
    [self sendCode];
  
    
}

-(void)sendCode
{
    WKWebViewController * wkWeb = [[WKWebViewController alloc] init];
    wkWeb.isWhiteNav = YES;
    wkWeb.successBlock = ^{
            BICSWViewController * swViewVC = [[BICSWViewController alloc] initWithNibName:NSStringFromClass([BICSWViewController class]) bundle:nil];
            swViewVC.loginType = LoginRegType_Draw;
            BICWalletTransferRequest * request = [[BICWalletTransferRequest alloc] init];
            request.tokenName = self.response.tokenName;
            request.tokenSymbol=self.response.tokenSymbol;
            request.tokenId=self.response.tokenId;
            request.tokenAddr = self.response.tokenAddr;
            request.walletType=@"CCT";
            request.toAddr=self.response.toAddr;
            request.amount= self.numField.text;
            request.phone =SDUserDefaultsGET(BICMOBILE);
            request.verifyType= @"phone";
            BICRegisterRequest * requsestModel = [[BICRegisterRequest alloc] init];
            requsestModel.tel = SDUserDefaultsGET(BICMOBILE);
            requsestModel.internationalCode = SDUserDefaultsGET(BICInternationalCode);
            NSNumber* index = SDUserDefaultsGET(BICBindGoogleAuth);
           if (index.boolValue) { //已经绑定了
               request.googleKey = @"oxffffff";
            }
            swViewVC.transferRequest = request;
    
            swViewVC.requsestModel = requsestModel;
            
            if ([self.response.walletGasType isEqualToString:@"BTC"]) {
                swViewVC.WalletType=Wallet_Type_BTC;
                request.chainType=@"1";
            }
            if ([self.response.walletGasType isEqualToString:@"ETH"]) {
                swViewVC.WalletType=Wallet_Type_ETH;
                request.chainType=@"2";
            }
        
            [self.yq_viewController presentViewController:swViewVC animated:YES
                                               completion:nil];
    };
    
    [self.viewController.navigationController pushViewController:wkWeb animated:YES];

}

@end






















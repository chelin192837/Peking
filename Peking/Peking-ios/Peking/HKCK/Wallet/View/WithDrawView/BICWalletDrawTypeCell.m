//
//  BICWalletDrawTypeCell.m
//  Biconome
//
//  Created by 车林 on 2019/9/2.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICWalletDrawTypeCell.h"
#import "MMScanViewController.h"
@interface BICWalletDrawTypeCell()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *addTextView;
@property (weak, nonatomic) IBOutlet UITextView *remarkTextView;


@property (weak, nonatomic) IBOutlet UILabel *coinTypeLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;

@property (weak, nonatomic) IBOutlet UILabel *remarkLab;

@property (weak, nonatomic) IBOutlet UILabel *notUseRemarkLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewHeight;
@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UIButton *omniBtn;
@property (weak, nonatomic) IBOutlet UIButton *ERCBtn;


@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHeight;

@end
@implementation BICWalletDrawTypeCell

- (IBAction)omnClick:(UIButton*)sender {
    _response.walletGasType = @"BTC";
    [self setBtn:sender];
}
- (IBAction)ERCClick:(UIButton*)sender {
    _response.walletGasType = @"ETH";
    [self setBtn:sender];
}
-(void)setBtn:(UIButton*)sender
{
    if (sender == self.omniBtn) {

        self.omniBtn.layer.borderColor = kBICSYSTEMBGColor.CGColor;
        [self.omniBtn setTitleColor:kBICSYSTEMBGColor forState:UIControlStateNormal];
        

        self.ERCBtn.layer.borderColor = [UIColor clearColor].CGColor;
        [self.ERCBtn setTitleColor:kNVABICSYSTEMTitleColor forState:UIControlStateNormal];
    }
    
    if (sender==self.ERCBtn) {

        self.omniBtn.layer.borderColor = [UIColor clearColor].CGColor;
        [self.omniBtn setTitleColor:kNVABICSYSTEMTitleColor forState:UIControlStateNormal];
        
   
        self.ERCBtn.layer.borderColor = kBICSYSTEMBGColor.CGColor;
        [self.ERCBtn setTitleColor:kBICSYSTEMBGColor forState:UIControlStateNormal];
        
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.coinTypeLab.text = LAN(@"链类型");
    self.addressLab.text = LAN(@"地址");
    self.remarkLab.text = LAN(@"备注");
    self.notUseRemarkLab.text = LAN(@"不使用备注");
    
    self.addTextView.delegate = self;
    
    self.omniBtn.layer.cornerRadius = 4.f;
    self.omniBtn.layer.masksToBounds = YES;
    self.omniBtn.layer.borderColor = kBICSYSTEMBGColor.CGColor;
    self.omniBtn.layer.borderWidth = 1.f;
    [self.omniBtn setTitleColor:kBICSYSTEMBGColor forState:UIControlStateNormal];
    self.omniBtn.backgroundColor = kBICMainListBGColor;
    
    self.ERCBtn.layer.cornerRadius = 4.f;
    self.ERCBtn.layer.masksToBounds = YES;
    self.ERCBtn.layer.borderColor = [UIColor clearColor].CGColor;
    self.ERCBtn.layer.borderWidth = 1.f;
    [self.ERCBtn setTitleColor:kNVABICSYSTEMTitleColor forState:UIControlStateNormal];
    self.ERCBtn.backgroundColor = kBICMainListBGColor;
    
    

}
- (IBAction)QRCodeBtn:(id)sender {
    
    MMScanViewController *scanVc = [[MMScanViewController alloc] initWithQrType:MMScanTypeQrCode onFinish:^(NSString *result, NSError *error) {
        if (error) {
            [BICDeviceManager AlertShowTip:[NSString stringWithFormat:@"%@",error]];
        } else {
            self.addTextView.text = result;
            self.response.toAddr = result;
        }
    }];
    [self.yq_viewController.navigationController pushViewController:scanVc animated:YES];
}

+(instancetype)exitWithTableView:(UITableView*)tableView
{
    NSString* cellId = @"BICWalletDrawTypeCell";
    BICWalletDrawTypeCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
    }
    return cell;
}
-(void)setResponse:(GetWalletsResponse *)response
{
    _response = response;
    
    if (![response.tokenSymbol isEqualToString:@"USDT"]) {
        
        self.topView.hidden = YES;
        self.topViewHeight.constant = 0.f;
    }else{
        self.topView.hidden = NO;
        self.topViewHeight.constant = 96.f;
    }
    if (!response.isRemark) {
        
        self.bottomView.hidden = YES;
        self.bottomHeight.constant = 0.f;
    }else{
        self.bottomView.hidden = NO;
        self.bottomHeight.constant = 95.f;
    }
    
    
    _response.walletGasType = @"BTC";
    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView==self.addTextView) {
        self.response.toAddr = self.addTextView.text;
    }
}

@end

//
//  BICGoogleAuthQRCell.m
//  Biconome
//
//  Created by 车林 on 2019/9/4.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICGoogleAuthQRCell.h"

#import "BICImageManager.h"

#import "BICGooglePasswordVC.h"

#define QRCODE_HEAD @"otpauth://totp/Biconomy.com?secret="

@interface BICGoogleAuthQRCell()
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UILabel *keyTLab;

@property (weak, nonatomic) IBOutlet UIImageView *QRImage;

@property (weak, nonatomic) IBOutlet UILabel *keyLab;

@property (weak, nonatomic) IBOutlet UIButton *tcopyKeyBtn;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
@implementation BICGoogleAuthQRCell

- (IBAction)nextBtn:(id)sender {
    
    BICGooglePasswordVC * goolePasswordVC = [[BICGooglePasswordVC alloc] init];

    goolePasswordVC.gooleKey = _response.data;
    
    [self.yq_viewController.navigationController pushViewController:goolePasswordVC animated:YES];
    
    self.bgView.layer.cornerRadius = 8.f;
    
    [self.bgView isYY];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.keyTLab.text = LAN(@"密钥");
    
    [self.tcopyKeyBtn setTitle:LAN(@"复制密钥") forState:UIControlStateNormal];
    
    [self.nextBtn setTitle:LAN(@"下一步") forState:UIControlStateNormal];

}


- (IBAction)btnClick:(id)sender {
    
    if (_response.data) {
        
        [BICDeviceManager pasteboard:_response.data];
        
        [BICDeviceManager AlertShowTip:LAN(@"复制成功")];
    }
    
}
-(void)setResponse:(BICBindGoogleResponse *)response
{
    _response = response;
   
    self.QRImage.image = [BICImageManager QRTranThoughString: [NSString stringWithFormat:@"%@%@",QRCODE_HEAD,response.data] WithSize:160.f];
    
    self.keyLab.text = response.data;

}
+(instancetype)exitWithTableView:(UITableView*)tableView
{
    NSString* cellId = @"BICGoogleAuthQRCell";
    BICGoogleAuthQRCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
    }
    return cell;
}
@end

//
//  BICQRSaveVC.m
//  Biconome
//
//  Created by 车林 on 2019/9/2.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICQRSaveVC.h"
#import "BICImageManager.h"
@interface BICQRSaveVC ()
@property (weak, nonatomic) IBOutlet UILabel *tokenSybomLab;
@property (weak, nonatomic) IBOutlet UIImageView *tokenSytobmImage;
@property (weak, nonatomic) IBOutlet UIImageView *QrcodeImage;
@property (weak, nonatomic) IBOutlet UILabel *tokenAddLab;
@property (weak, nonatomic) IBOutlet UILabel *remarkLab;

@end

@implementation BICQRSaveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)setResponse:(GetWalletsResponse *)response
{
    _response = response ;
    
    self.tokenAddLab.text = response.tokenSymbol;
    
    [self.tokenSytobmImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@"URL8801"/%@",kBaseUrl,response.logoAddr]] placeholderImage:kBTCImageIcon];

//    [self.tokenSytobmImage sd_setImageWithURL:[NSURL URLWithString:response.logoAddr] placeholderImage:kBTCImageIcon];
    
    self.QrcodeImage.image =[BICImageManager QRTranThoughString:response.addr WithSize:160.f];
    
    self.tokenAddLab.text = response.addr;
    
    self.remarkLab.text = LAN(@"暂无数据");
    
    [self.view layoutIfNeeded];
}

@end

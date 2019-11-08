//
//  BICQRSaveView.m
//  Biconome
//
//  Created by 车林 on 2019/9/2.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICQRSaveView.h"
#import "BICImageManager.h"
@interface BICQRSaveView()

@property (weak, nonatomic) IBOutlet UILabel *tokenSybomLab;
@property (weak, nonatomic) IBOutlet UIImageView *tokenSytobmImage;
@property (weak, nonatomic) IBOutlet UIImageView *QrcodeImage;
@property (weak, nonatomic) IBOutlet UILabel *tokenAddLab;
@property (weak, nonatomic) IBOutlet UILabel *remarkLab;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *remarkBGViewHeight;
@property (weak, nonatomic) IBOutlet UIView *remarkBGView;

@end

@implementation BICQRSaveView

-(instancetype)initWithBib
{
    self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
    
    self.bgView.layer.cornerRadius = 8;
    self.bgView.layer.masksToBounds=YES;
    return self;
}
-(void)setupUI:(GetWalletsResponse *)response
{
    
    self.tokenSybomLab.text = response.tokenSymbol;
    
//    [self.tokenSytobmImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@"URL8801"/%@",kBaseUrl,response.logoAddr]] placeholderImage:kBTCImageIcon];
   
//    [self.tokenSytobmImage sd_setImageWithURL:[NSURL URLWithString:response.logoAddr] placeholderImage:kBTCImageIcon];
    
    self.QrcodeImage.image =[BICImageManager QRTranThoughString:response.addr WithSize:160.f];
    
    if(![response.tokenSymbol isEqualToString:@"USDT"]){
        self.tokenAddLab.text = response.addr;
    }else{
        NSArray *array = [response.addr componentsSeparatedByString:@"|"];
        self.tokenAddLab.text = [array objectAtIndex:response.addrIndex];
    }
    if (!response.isRemark) {
        self.remarkBGView.hidden = YES;
        self.remarkBGViewHeight.constant = 0.f;
    }
  
    self.remarkLab.text = LAN(@"暂无备注信息");
    
    [self layoutIfNeeded];

    WEAK_SELF
    [ODAlertViewFactory showLoadingViewWithView:self];
    [self.tokenSytobmImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@"URL8801"/%@",kBaseUrl,response.logoAddr]] placeholderImage:kBTCImageIcon completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [ODAlertViewFactory hideAllHud:weakSelf];
           BICImageManager * imageManager = [[BICImageManager alloc] init];
           [imageManager SaveImageToLocalForView:weakSelf];
    }];
}
@end

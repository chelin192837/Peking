//
//  BICWallSaveCell.m
//  Biconome
//
//  Created by 车林 on 2019/8/31.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICWallSaveCell.h"
#import "BICImageManager.h"
#import "BICQRSaveVC.h"
#import "BICQRSaveView.h"

@interface BICWallSaveCell()

@property (weak, nonatomic) IBOutlet UIButton *saveQRBtn;

@end
@implementation BICWallSaveCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.saveQRBtn setTitle:LAN(@"保存二维码") forState:UIControlStateNormal];

}
- (IBAction)saveBtn:(id)sender {

//    BICQRSaveVC *vc = [[BICQRSaveVC alloc] init];
//    vc.response=_response;
//    [imageManager SaveImageToLocal:vc];
    BICQRSaveView * saveView = [[BICQRSaveView alloc] initWithBib];
    saveView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
 
//    [[SDWebImageManager sharedManager] cachedImageExistsForURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@"URL8801"/%@",kBaseUrl,_response.logoAddr]] completion:^(BOOL isInCache) {
//
//    }];
    [saveView setupUI:_response];
    
}
+(instancetype)exitWithTableView:(UITableView*)tableView
{
    NSString* cellId = @"BICWallSaveCell";
    BICWallSaveCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
    }
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setResponse:(GetWalletsResponse *)response
{
    _response = response;
}
@end

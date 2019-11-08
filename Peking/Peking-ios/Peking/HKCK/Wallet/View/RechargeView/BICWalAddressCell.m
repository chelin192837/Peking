//
//  BICWalAddressCell.m
//  Biconome
//
//  Created by 车林 on 2019/8/31.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICWalAddressCell.h"

@implementation BICWalAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (IBAction)copyBtn:(id)sender {
    
    if (self.QRTextLab.text.length>0) {
        [BICDeviceManager pasteboard:self.QRTextLab.text];
        
        [BICDeviceManager AlertShowTip:LAN(@"已复制")];
    }
 
}

+(instancetype)exitWithTableView:(UITableView*)tableView
{
    NSString* cellId = @"BICWalAddressCell";
    BICWalAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
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
    
    if(![self.response.tokenSymbol isEqualToString:@"USDT"]){
        self.QRTextLab.text = response.addr;
    }else{
        NSArray *array = [response.addr componentsSeparatedByString:@"|"];
        self.QRTextLab.text = [array objectAtIndex:response.addrIndex];
    }
    
}
@end

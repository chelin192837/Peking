//
//  BICWalletHistoryCell.m
//  Biconome
//
//  Created by 车林 on 2019/8/31.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICWalletHistoryCell.h"
#import "BICCancelView.h"
@interface BICWalletHistoryCell()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *transferTypeLab;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLab;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@end
@implementation BICWalletHistoryCell

- (IBAction)cancelClick:(id)sender {
    BICCancelView *view=[[BICCancelView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) title:LAN(@"提示") content:LAN(@"确认取消该笔提币?") left:LAN(@"再想想") right:LAN(@"确认取消")];
    WEAK_SELF
    view.clickRightItemOperationBlock = ^{
        BICWalletTransferRequest *req=[[BICWalletTransferRequest alloc] init];
        req.id=weakSelf.response.id;
        req.amount=weakSelf.response.amount;
        req.tokenSymbol=weakSelf.response.tokenSymbol;
        req.chainType=weakSelf.response.chainType;
        [[BICWalletService sharedInstance] analyticalWalletCancelWithdrawData:req serverSuccessResultHandler:^(id response) {
            BICBaseResponse *res=(BICBaseResponse *)response;
            if(res.code==200){
                [BICDeviceManager AlertShowTip:LAN(@"取消成功")];
                if(weakSelf.cancelClickItemOperationBlock){
                    weakSelf.cancelClickItemOperationBlock();
                }
            }else{
                [BICDeviceManager AlertShowTip:res.msg];
            }
        } failedResultHandler:^(id response) {
            
        } requestErrorHandler:^(id error) {
            
        }];
    };
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.bgView.layer.cornerRadius = 8.f;
//    self.bgView.layer.masksToBounds = YES;
    [self.bgView isYY];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.cancelBtn setTitle:LAN(@"取消") forState:UIControlStateNormal];
}
-(void)setResponse:(GetTransferInOutResponse *)response
{
    _response = response;
    
    NSString* transfer = @"";
    if ([response.transferType isEqualToString:@"IN"]) {
        transfer = LAN(@"充值");
    }
    if ([response.transferType isEqualToString:@"OUT"]) {
        transfer = LAN(@"提币");
    }
    if ([response.transferType isEqualToString:@"CCT"]) {
        transfer = LAN(@"币币交易");
    }
    if ([response.transferType isEqualToString:@"GAS"]) {
        transfer = LAN(@"手续费");
    }
    if ([response.transferType isEqualToString:@"TXMIN"]) {
        transfer = LAN(@"内部转账(自身)");
    }
    if ([response.transferType isEqualToString:@"TXOIN"]) {
        transfer = LAN(@"内部转账(他人)");
    }
    if ([response.transferType isEqualToString:@"BACKEND_ADD"]) {
        transfer = LAN(@"后台加币");
    }
    if ([response.transferType isEqualToString:@"BACKEND_SUD"]) {
        transfer = LAN(@"后台减币");
    }
    
    self.transferTypeLab.text = [NSString stringWithFormat:@"%@ %@ %@",transfer,response.tokenSymbol,response.amount];
    
    self.statusLab.text = [self getStatus:response.status];
    
    self.createTimeLab.text = [UtilsManager getLocalDateFormateUTCDate:response.createTime];
    
    if([response.status intValue]==2 || [response.status intValue]==3 ){
        self.cancelBtn.hidden=NO;
    }else{
        self.cancelBtn.hidden=YES;
    }
}



-(NSString*)getStatus:(NSString*)status
{
    NSString* statusValue=@"";
    switch (status.integerValue) {
        case 0:
        {
            statusValue = LAN(@"失败");
        }
            break;
        case 1:
        {
            statusValue = LAN(@"成功");

        }
            break;
        case 2:
        {
            statusValue = LAN(@"待初审提币");

        }
            break;
        case 3:
        {
            statusValue = LAN(@"待复审提币");

        }
            break;
        case 4:
        {
            statusValue = LAN(@"待出币");

        }
            break;
        case 5:
        {
            statusValue = LAN(@"打包中");

        }
            break;
        case 6:
        {
            statusValue = LAN(@"出币失败");

        }
            break;
        case 7:
        {
            statusValue = LAN(@"审核不通过");

        }
            break;
        case 8:
        {
            statusValue = LAN(@"已取消");

        }
            break;
            
        default:
            break;
    }
    return statusValue;
}
+(instancetype)exitWithTableView:(UITableView*)tableView
{
    NSString* cellId = NSStringFromClass(self);
    
    BICWalletHistoryCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
    }
    return cell;
}

@end

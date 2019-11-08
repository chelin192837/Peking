//
//  BICInviteReturnView.m
//  Biconome
//
//  Created by 车林 on 2019/10/5.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICInviteReturnView.h"
#import "BICQRSaveView.h"
#import "BICInviteQRVC.h"
@interface BICInviteReturnView()

@property (weak, nonatomic) IBOutlet UILabel *TitleLab;
@property (weak, nonatomic) IBOutlet UILabel *returnPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *returnPrice;

@property (weak, nonatomic) IBOutlet UILabel *directInviterLab;
@property (weak, nonatomic) IBOutlet UILabel *directInviter;

@property (weak, nonatomic) IBOutlet UILabel *indirectInviterLab;
@property (weak, nonatomic) IBOutlet UILabel *indirectInviter;

@property (weak, nonatomic) IBOutlet UILabel *inviteTypeLab;
@property (weak, nonatomic) IBOutlet UIButton *inviterQRCodeBtn;


@property (weak, nonatomic) IBOutlet UILabel *inviterLinkLab;
@property (weak, nonatomic) IBOutlet UILabel *inviterLink;

@property (weak, nonatomic) IBOutlet UILabel *inviterCodeLab;
@property (weak, nonatomic) IBOutlet UILabel *inviterCode;

@property (weak, nonatomic) IBOutlet UILabel *ruleLab;

@property (weak, nonatomic) IBOutlet UILabel *ruleDetail;

@property (weak, nonatomic) IBOutlet UILabel *noticeLab;

@property (weak, nonatomic) IBOutlet UILabel *notice;


@end
@implementation BICInviteReturnView

//邀请二维码
- (IBAction)inviteCodeBtn:(id)sender {
    
    BICInviteQRVC * qrVC = [[BICInviteQRVC alloc] init];

    qrVC.qrCode = _inviteReturnModel.inviterLink;
    
    [self.viewController.navigationController pushViewController:qrVC animated:YES];
    
}

//复制邀请链接
- (IBAction)inviteLinkBtn:(id)sender {
    if (_inviteReturnModel.inviterLink.length>0) {
        [BICDeviceManager pasteboard:_inviteReturnModel.inviterLink];
        [BICDeviceManager AlertShowTip:LAN(@"已复制")];
    }
    
}

//复制邀请码
- (IBAction)inviteNumBtn:(id)sender {
    if (_inviteReturnModel.inviterCode.length>0) {
        [BICDeviceManager pasteboard:_inviteReturnModel.inviterCode];
        [BICDeviceManager AlertShowTip:LAN(@"已复制")];
    }
}

-(instancetype)initWithNib
{
    self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
    [self setupUI];
    return self;
}
-(void)setInviteReturnModel:(BICInviteReturnModel *)inviteReturnModel
{
    _inviteReturnModel = inviteReturnModel;
    
    self.TitleLab.text = [NSString stringWithFormat:@"%@%@%@%@",LAN(@"邀请好友注册 Biconomy 获得"),[NSString stringWithFormat:@"%.2lf",inviteReturnModel.titlePrecent.doubleValue*100],@"%",LAN(@"交易返佣")];
    self.returnPrice.text = inviteReturnModel.returnPrice;
    self.directInviter.text = inviteReturnModel.directInviter;
    self.indirectInviter.text = inviteReturnModel.indirectInviter;
    self.inviterLink.text = inviteReturnModel.inviterLink;
    self.inviterCode.text = inviteReturnModel.inviterCode;
    
    NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:[self getText]];
    
    self.ruleDetail.lineBreakMode = NSLineBreakByWordWrapping;
    
    self.ruleDetail.numberOfLines=0;
    
    self.ruleDetail.attributedText = tncString;
    
    self.notice.text = [self getNotice];

}
-(void)setupUI
{
    
    self.returnPriceLab.text = LAN(@"返佣金额");
    
    self.directInviterLab.text = LAN(@"直接邀请(人)");
    
    self.indirectInviterLab.text = LAN(@"间接邀请(人)");
    
    self.inviteTypeLab.text = LAN(@"邀请方式");
    
    [self.inviterQRCodeBtn setTitle:LAN(@"邀请二维码") forState:UIControlStateNormal];
    
    self.inviterLinkLab.text = LAN(@"邀请链接");
    
    self.inviterCodeLab.text = LAN(@"邀请码");
    
    self.ruleLab.text = LAN(@"规则");
    
    self.noticeLab.text = LAN(@"特别注意");
    
    if ([BICDeviceManager languageIsChinese]) {
        self.height = 1200.f;
    }else{
        self.height = 1350.f;
    }

}
-(NSString*)getText
{
    NSString * text = @"";
    if ([BICDeviceManager languageIsChinese]) {
        text = @"1、好友接受邀请后，每产生一笔真实交易手续费，会产生相应比例的返佣。\n2、佣金以BTC的形式充值到您的账户，返佣比例为30%。\n3、返佣额 = 实际产生交易量 * 手续费比例 * 返佣比例。\n4、邀请人享受好友交易返佣有效时长以被邀请人实际注册的时间开始进行计算，到达有效时长（90天）后您将不享受该邀请人交易产生手续费的返佣。\n5、返佣逐笔实时计算，每小时返回到 Biconomy 账户。\n6、充提币手续费不参与手续费返佣。\n7、如被邀请人违反邀请返佣的相应风控规则，其手续费将不能返还给邀请人，同时，被邀请人的邀请状态变成【失效】并且产生的返佣记录状态变成【失效】。\n8、排行榜单每小时更新。";
    }else{
        text = @"1. After the friend accepts the invitation, each time a real exchange fee is generated, a corresponding proportion of cashback will be generated.\n2. Commission is recharged to your account in the form of BTC, and the referral rates is 30%.\n3. The amount of cashback = exchange volume * trading fee * referral rates.\n4. The inviter enjoys the time limit for the friend to return the commission, and the time is calculated by the time when the invitee actually registers. After the effective time (90 days), you will not be entitled to the commission.\n5. The cashback is calculated in real time and returned to the Biconomy account every hour.\n6. The deposit and withdrawal of the coin is not involved in the commission fee.\n7. If the invitee violates the risk control rules , the commission fee will not be returned to the inviter. At the same time, the invitation status of the invitee becomes [disabled] and the status of the generated cashback record becomes [disabled].\n8. The Top Referrers is updated every hour.";
    }
    return text;
}
-(NSString*)getNotice
{
    NSString * text = @"";
    if ([BICDeviceManager languageIsChinese]) {
        text = @"由于市场环境的改变，欺诈风险的存在等原因，Biconomy 保留随时对返佣规则作出调整的最终解释权";
    }else{
        text = @"Biconomy reserves the right to change the terms of the referral program at any time due to changing market conditions, risk of fraud, or any other factors we deem relevant";
    }
    return text;
}
@end

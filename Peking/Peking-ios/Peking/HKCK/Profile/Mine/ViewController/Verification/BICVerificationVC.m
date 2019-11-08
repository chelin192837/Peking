//
//  BICVerificationVC.m
//  Biconome
//
//  Created by a on 2019/10/5.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "BICVerificationVC.h"
#import "BICVerificationHeaderView.h"
#import "BICMineVerCell.h"
#import "BICBasicInfoViewController.h"
#import "BICAddressInfoViewController.h"
#import "BICAddBasicInfoViewController.h"
#import "BICAddAddressInfoViewController.h"
#import "BICAddIdentifyInfoViewController.h"
#import "BICIdentifyInfoViewController.h"
#import "BICPhotoIdentifyVC.h"

@interface BICVerificationVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)BICVerificationHeaderView *headerView;
@property(nonatomic,strong)NSArray*dataArray;

@end

@implementation BICVerificationVC
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if(self.backReloadOperationBlock){
        self.backReloadOperationBlock();
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBICHistoryCellBGColor;
    
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];

    [self initNavigationTitleViewLabelWithTitle:LAN(@"身份认证") titleColor:kNVABICSYSTEMTitleColor IfBelongTabbar:NO];
    [self.view addSubview:self.tableView];
//    [self.tableView reloadData];
    [self requestAuthInfo];
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-kNavBar_Height) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
//        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 73, 0);
        _tableView.backgroundColor=kBICHistoryCellBGColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.tableHeaderView = self.headerView;
    }
    return _tableView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    //315
    return 315;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BICMineVerCell *cell=[BICMineVerCell cellWithTableView:tableView];
    cell.ishaveTop=YES;
    cell.ishaveBottom=YES;
    cell.titleTexLab.text=[self.dataArray objectAtIndex:indexPath.row];
    if(indexPath.row==0){
        if(self.response.data.gender && ![self.response.data.gender isEqualToString:@""]){
             cell.detailLabel.text=@"";
        }else{
            cell.detailLabel.text=LAN(@"未提交");
        }
    }
    if(indexPath.row==1){
        if(self.response.data.country && ![self.response.data.country isEqualToString:@""]){
             cell.detailLabel.text=@"";
        }else{
            cell.detailLabel.text=LAN(@"未提交");
        }
    }
    if(indexPath.row==2){
        if(self.response.data.idNumber && ![self.response.data.idNumber isEqualToString:@""]){
             cell.detailLabel.text=@"";
        }else{
            cell.detailLabel.text=LAN(@"未提交");
        }
    }
    if(indexPath.row==3){
         if(self.response.data.fileUrl1 && ![self.response.data.fileUrl1 isEqualToString:@""]){
               cell.detailLabel.text=@"";
           }else{
               cell.detailLabel.text=LAN(@"未提交");
           }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WEAK_SELF
    if(indexPath.row==0){
        if(!self.response.data.age || [self.response.data.age isEqualToString:@""] || [self.response.data.status isEqualToString:@"N"]){
            BICAddBasicInfoViewController *vc=[[BICAddBasicInfoViewController alloc] init];
            vc.response=self.response;
            vc.backReloadOperationBlock = ^{
                [weakSelf requestAuthInfo];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            BICBasicInfoViewController *vc=[[BICBasicInfoViewController alloc] init];
            vc.response=self.response;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if(indexPath.row==1){
        if(!self.response.data.country || [self.response.data.country isEqualToString:@""] || [self.response.data.status isEqualToString:@"N"]){
            BICAddAddressInfoViewController *vc=[[BICAddAddressInfoViewController alloc] init];
            vc.response=self.response;
            vc.backReloadOperationBlock = ^{
                [weakSelf requestAuthInfo];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            BICAddressInfoViewController *vc=[[BICAddressInfoViewController alloc] init];
            vc.response=self.response;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if(indexPath.row==2){
        if(!self.response.data.idNumber || [self.response.data.idNumber isEqualToString:@""]|| [self.response.data.status isEqualToString:@"N"]){
            BICAddIdentifyInfoViewController *vc=[[BICAddIdentifyInfoViewController alloc] init];
            vc.response=self.response;
            vc.backReloadOperationBlock = ^{
                [weakSelf requestAuthInfo];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            BICIdentifyInfoViewController *vc=[[BICIdentifyInfoViewController alloc] init];
            vc.response=self.response;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
//        if(self.response.data.cardType){
            BICPhotoIdentifyVC *vc=[[BICPhotoIdentifyVC alloc] init];
            vc.cardType=[self.response.data.cardType integerValue];
            vc.response=self.response;
            vc.backReloadOperationBlock = ^{
                [weakSelf requestAuthInfo];
            };
            [self.navigationController pushViewController:vc animated:YES];
//        }else{
//            [BICDeviceManager AlertShowTip:LAN(@"请先选择证件类型")];
//        }
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 68;
}
-(BICVerificationHeaderView *)headerView{
    if(!_headerView){
        _headerView=[[BICVerificationHeaderView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 315)];
        if([self.response.data.status isEqualToString:@"W"]){
            _headerView.imgView.image=[UIImage imageNamed:@"icon_defautl_in_audit"];
            _headerView.titleLabel.text=LAN(@"审核中");
            _headerView.contentLabel.text=LAN(@"身份认证信息已提交审核..");
        }else if([self.response.data.status isEqualToString:@"Y"]){
            _headerView.imgView.image=[UIImage imageNamed:@"icon_defautl_have_passed"];
            _headerView.titleLabel.text=LAN(@"已通过");
            _headerView.contentLabel.text=LAN(@"身份认证已通过");
        }else if([self.response.data.status isEqualToString:@"N"]){
            _headerView.imgView.image=[UIImage imageNamed:@"icon_defautl_not_pass"];
            _headerView.titleLabel.text=LAN(@"审核未通过");
            _headerView.contentLabel.text=self.response.data.remark;
        }else{
            _headerView.imgView.image=[UIImage imageNamed:@"icon_defautl_uncertified"];
            _headerView.titleLabel.text=LAN(@"未认证");
        }
    }
    return _headerView;
}
-(NSArray *)dataArray{
    if(!_dataArray){
        _dataArray=[NSArray arrayWithObjects:LAN(@"基本信息"),LAN(@"住宅信息"),LAN(@"身份信息"),LAN(@"证件照片"), nil];
    }
    return _dataArray;
}
-(void)updateHeaderView{
    if([self.response.data.status isEqualToString:@"W"]){
        _headerView.imgView.image=[UIImage imageNamed:@"icon_defautl_in_audit"];
        _headerView.titleLabel.text=LAN(@"审核中");
        _headerView.contentLabel.text=LAN(@"身份认证信息已提交审核..");
    }else if([self.response.data.status isEqualToString:@"Y"]){
        _headerView.imgView.image=[UIImage imageNamed:@"icon_defautl_have_passed"];
        _headerView.titleLabel.text=LAN(@"已通过");
        _headerView.contentLabel.text=LAN(@"身份认证已通过");
    }else if([self.response.data.status isEqualToString:@"N"]){
        _headerView.imgView.image=[UIImage imageNamed:@"icon_defautl_not_pass"];
        _headerView.titleLabel.text=LAN(@"审核未通过");
        _headerView.contentLabel.text=self.response.data.remark;
    }else{
        _headerView.imgView.image=[UIImage imageNamed:@"icon_defautl_uncertified"];
        _headerView.titleLabel.text=LAN(@"未认证");
    }
}
-(void)requestAuthInfo{
    WEAK_SELF
    BICBaseRequest *request = [[BICBaseRequest alloc] init];
    [[BICProfileService sharedInstance] analyticalAuthInfo:request serverSuccessResultHandler:^(id response) {
           weakSelf.response = (BICAuthInfoResponse*)response;
            if(weakSelf.response.code==200){
                [weakSelf updateHeaderView];
                [weakSelf.tableView reloadData];
            }
       } failedResultHandler:^(id response) {
        
       } requestErrorHandler:^(id error) {
        
       }];
}
@end

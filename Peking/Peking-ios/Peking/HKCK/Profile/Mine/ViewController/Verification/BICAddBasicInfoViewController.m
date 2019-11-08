//
//  BICBasicInfoViewController.m
//  Biconome
//
//  Created by a on 2019/10/5.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "BICAddBasicInfoViewController.h"
#import "BICAddBasicInfoView.h"
//#import "WMCustomDatePicker.h"
#import "VPickView.h"
@interface BICAddBasicInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)BICAddBasicInfoView *infoView;
@property (strong, nonatomic) VPickView *picker;
@property(nonatomic,strong)UITableView*tableView;
@end

@implementation BICAddBasicInfoViewController
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if(self.backReloadOperationBlock){
        self.backReloadOperationBlock();
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];
    [self initNavigationTitleViewLabelWithTitle:LAN(@"基本信息") titleColor:kNVABICSYSTEMTitleColor IfBelongTabbar:NO];
    
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
    [self.view addSubview:self.picker];
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-kNavBar_Height) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 80, 0);
        _tableView.backgroundColor=[UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.tableHeaderView = self.infoView;
    }
    return _tableView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 660;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc] init];
    return cell;
}

-(void)setResponse:(BICAuthInfoResponse *)response{
    _response=response;
    self.infoView.response=response;
}
-(BICAddBasicInfoView *)infoView{
    if(!_infoView){
        _infoView=[[BICAddBasicInfoView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-kNavBar_Height)];
        
        WEAK_SELF
        _infoView.dataSelectItemOperationBlock = ^{
            [weakSelf selectData];
        };
    }
    return _infoView;
}

-(void)selectData{
    WEAK_SELF
    CGRect f=weakSelf.picker.frame;
    CGRect f2=weakSelf.tableView.frame;
    if(KScreenHeight-kNavBar_Height==f.origin.y){
        f.origin.y-=180;
        f2.origin.y-=180;
    }else{
        f.origin.y+=180;
        f2.origin.y+=180;
    }
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.picker.frame=f;
        weakSelf.tableView.frame=f2;
    }];
}
 -(VPickView *)picker{
     if(!_picker){
         _picker=[[VPickView alloc] initWithFrame:CGRectMake(0, KScreenHeight-kNavBar_Height, KScreenWidth, 180)];
         WEAK_SELF
         _picker.selectedItemOperationBlock = ^(NSString * _Nonnull str) {
              weakSelf.infoView.birthtextField.textField.text=str;
         };
     }
     return _picker;
 }


//-(void)finishDidSelectDatePicker:(WMCustomDatePicker *)datePicker date:(NSDate *)date{
//    //用于格式化NSDate对象
//    NSDateFormatter*dateFormatter=[[NSDateFormatter alloc]init];
//    //设置格式：zzz表示时区
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    self.infoView.birthtextField.textField.text=[dateFormatter stringFromDate:date];
//}
@end

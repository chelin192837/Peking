//
//  RSDCLSelectPage.m
//  Agent
//
//  Created by jj on 2018/1/19.
//  Copyright © 2018年 七扇门. All rights reserved.
//

#import "RSDCLSelectPage.h"



#import "RSDCLSelectPageCell.h"




@interface RSDCLSelectPage ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView* list;



@end

@implementation RSDCLSelectPage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];
    
    [self initNavigationTitleViewLabelWithTitle:self.titleStr titleColor:kNVABICSYSTEMTitleColor IfBelongTabbar:NO];
    
    if (_selIndex == nil) {
        _selIndex = [NSIndexPath indexPathForRow:_editSelIndex inSection:0];
    }

    [self.view addSubview:self.list];
    
    self.view.backgroundColor = kBICMainListBGColor ;
}

-(void)setSelectPageType:(SelectPage_Type)selectPageType
{
    _selectPageType = selectPageType;
    
    if (selectPageType==SelectPage_Type_Language) {
        
        if ([BICDeviceManager languageIsChinese]) { //中文
            
            self.selIndex = [NSIndexPath indexPathForRow:0 inSection:0];
            
        }else{ //英文
            self.selIndex = [NSIndexPath indexPathForRow:1 inSection:0];
        }
        
    }
    
    if (selectPageType==SelectPage_Type_Rate) {
        
        if ([[BICDeviceManager getCurrentRate] isEqualToString:@"CNY"]) { //中文
            
            self.selIndex = [NSIndexPath indexPathForRow:0 inSection:0];
            
        }else{ //英文
            self.selIndex = [NSIndexPath indexPathForRow:1 inSection:0];
        }
        
    }
    
    if (selectPageType==SelectPage_Type_Sex) {
           
           if ([[BICDeviceManager getCurrentSex] isEqualToString:LAN(@"男")]) { //中文
               
               self.selIndex = [NSIndexPath indexPathForRow:0 inSection:0];
               
           }else{ //英文
               self.selIndex = [NSIndexPath indexPathForRow:1 inSection:0];
           }
           
       }
    
    if (selectPageType==SelectPage_Type_CardType) {
        if ([[BICDeviceManager getCurrentCardType] isEqualToString:LAN(@"身份证")]) {
            self.selIndex = [NSIndexPath indexPathForRow:0 inSection:0];
        }else if([[BICDeviceManager getCurrentCardType] isEqualToString:LAN(@"护照")]){
            self.selIndex = [NSIndexPath indexPathForRow:1 inSection:0];
        }else{
            self.selIndex = [NSIndexPath indexPathForRow:2 inSection:0];
        }
        
    }


}

//懒加载
-(UITableView *)list
{
    if (!_list) {
        _list = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
        _list.dataSource = self;
        _list.delegate = self;
        _list.backgroundColor = [UIColor clearColor];
        _list.separatorStyle = UITableViewCellSeparatorStyleNone ;
        [self.view addSubview:_list];
    }
    return _list;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dateItemArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RSDCLSelectPageCell  *cell = [RSDCLSelectPageCell cellWithTableView:tableView];
    cell.selectLabel.text = _dateItemArray[indexPath.row];
    //当上下拉动的时候，因为cell的复用性，我们需要重新判断一下哪一行是打勾的
    if (_selIndex == indexPath) {
        cell.selectRadio.image=[UIImage imageNamed:@"selected"];
    }else {
        cell.selectRadio.image=[UIImage yq_imageWithColor:[UIColor clearColor]];
    }
  
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //之前选中的，取消选择
    RSDCLSelectPageCell *celled = [tableView cellForRowAtIndexPath:_selIndex];
    celled.selectRadio.image=[UIImage yq_imageWithColor:[UIColor clearColor]];
    //记录当前选中的位置索引
    _selIndex = indexPath;
    //当前选择的打勾
    RSDCLSelectPageCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectRadio.image=[UIImage imageNamed:@"selected"];
    
    if (_selectPageType==SelectPage_Type_Language) {
        if (indexPath.row==0) { //中文
            [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hans" forKey:@"language_type"];
        }
        if (indexPath.row==1) { //英文
            [[NSUserDefaults standardUserDefaults] setObject:@"en" forKey:@"language_type"];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:KUpdate_Language object:nil];

        [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenterUpdateUI object:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });


        return;
    }
    
    if (_selectPageType==SelectPage_Type_Rate) {
        if (indexPath.row==0) { //CNY
            [[NSUserDefaults standardUserDefaults] setObject:@"CNY" forKey:BICRateConfigType];
        }
        if (indexPath.row==1) { //USD
            [[NSUserDefaults standardUserDefaults] setObject:@"USD" forKey:BICRateConfigType];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenterBICRateConfig object:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });

        return;
    }
    
    if (_selectPageType==SelectPage_Type_Sex) {
        [[NSUserDefaults standardUserDefaults] setObject:_dateItemArray[indexPath.row] forKey:BICSexConfigType];
        
    }
    
    if (_selectPageType==SelectPage_Type_CardType) {
        SDUserDefaultsSET(_dateItemArray[indexPath.row], BICCardConfigType);
    }

    if (self.typeBlock) {
        self.typeBlock(_dateItemArray[indexPath.row],_selIndex);
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}




@end






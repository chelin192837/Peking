//
//  HKCKViewController.m
//  Biconome
//
//  Created by 车林 on 2019/8/3.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "HKCKViewController.h"
#import "BICMainService.h"
#import "AAChartKit.h"
#import "BICRegisterVC.h"
#import "BTStockChartViewController.h"
#import "XHVerticalScrollview.h"
#import "BICLoginVC.h"
//#import "BICUpatePasswordVC.h"

#import "KDGoalBar.h"
#import "BICMineOrderDeleVC.h"
#import "BICHistoryDeleVC.h"
#import "BICOrderDealVC.h"
static int kNum = 5;

@interface HKCKViewController ()

@property(nonatomic,strong)AAChartView * aaChartView;

@end

@implementation HKCKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    KDGoalBar*firstGoalBar = [[KDGoalBar alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 200)];
//    [firstGoalBar setPercent:50 animated:NO];
//    [self.view addSubview:firstGoalBar];
//
    [self setupUI];
}

-(void)setupUI
{
    CGFloat btnWidth = (kScreenWidth-28-(kNum-1)*10)/kNum;
    
    NSArray* arr = @[@"英语",@"中文",@"清空",@"socket",@"layer"];
    
    for (int i=0; i<5; i++) {
        UIButton * button = [[UIButton alloc] init];
        button.tag = 100 + i ;

        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor yellowColor];
        [button addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(btnWidth));
            make.height.equalTo(@50);
            make.left.equalTo(self.view).offset(14+i*(btnWidth+10));
            make.bottom.equalTo(self.view).offset(-10-44-50);
        }];
    }
    
    CGFloat btnWidthBom = (kScreenWidth-28-(3-1)*10)/3;

    NSArray* arrDelegate = @[@"当前委托",@"历史委托",@"成交"];
    
    for (int i=0; i<arrDelegate.count; i++) {
        UIButton * button = [[UIButton alloc] init];
        button.tag = 1000 + i ;
        
        [button setTitle:arrDelegate[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor yellowColor];
        [button addTarget:self action:@selector(btnBom:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(btnWidthBom));
            make.height.equalTo(@50);
            make.left.equalTo(self.view).offset(14+i*(btnWidthBom+10));
            make.bottom.equalTo(self.view).offset(-10-44-50-70);
        }];
    }


}
-(void)btnBom:(UIButton*)sender
{
    if (sender.tag==1000) {
        
        BICMineOrderDeleVC * vc = [[BICMineOrderDeleVC alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if(sender.tag==1001){
        BICHistoryDeleVC * vc = [[BICHistoryDeleVC alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
       
        
    }else if(sender.tag==1002)
    {
        
         BICOrderDealVC * vc = [[BICOrderDealVC alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

-(void)btn:(UIButton*)button
{
    if (button.tag==100) {
        [[NSUserDefaults standardUserDefaults] setObject:@"en" forKey:@"language_type"];
        [BICDeviceManager AlertShowTip:@"设置英文文成功"];
    }else if(button.tag==101){
        [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hans" forKey:@"language_type"];
        [BICDeviceManager AlertShowTip:@"设置中文成功"];
    }else if(button.tag==102)
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"language_type"];
    }else if(button.tag==103)
    {
        BTStockChartViewController * BTStockVC = [[BTStockChartViewController alloc] init];
        [self.navigationController pushViewController:BTStockVC animated:YES];
        
    }else if(button.tag==104)
    {
        
       
        
    }

    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenterUpdateUI object:nil];
}

@end

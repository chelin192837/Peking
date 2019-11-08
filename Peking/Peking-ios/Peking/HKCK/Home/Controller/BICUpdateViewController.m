//
//  BICBasicInfoViewController.m
//  Biconome
//
//  Created by a on 2019/10/5.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "BICUpdateViewController.h"
#import "BICUpdateView.h"
 
@interface BICUpdateViewController ()
@property(nonatomic,strong)BICUpdateView *infoView;
 
@end

@implementation BICUpdateViewController
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
 
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.infoView];
}
-(void)setResponse:(BICAppStoreResponse *)response{
    _response=response;
    self.infoView.response=response;
}
-(BICUpdateView *)infoView{
    if(!_infoView){
        _infoView=[[BICUpdateView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    }
    return _infoView;
}

@end

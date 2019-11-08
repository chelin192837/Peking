//
//  BICMineOrderDeleVC.m
//  Biconome
//
//  Created by 车林 on 2019/8/23.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICMineOrderDeleVC.h"
#import "BICCancelView.h"
#import "BICEXCMainCell.h"
#import "BICListUserRequest.h"
#import "BICListUserResponse.h"
#import "BICEXCMainStopCell.h"

@interface BICMineOrderDeleVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableView;

@property(nonatomic,strong)BICListUserRequest* request;

@property(nonatomic,strong)BICListUserResponse* response;

@property(nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation BICMineOrderDeleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WEAK_SELF
    self.view.backgroundColor = kBICHistoryCellBGColor;
    
    [self initNavigationLeftBtnWithTitle:nil isNeedImage:YES andImageName:@"fanhuiHei" titleColor:nil];

    [self initNavigationTitleViewLabelWithTitle:LAN(@"当前委托") titleColor:kNVABICSYSTEMTitleColor IfBelongTabbar:NO];
 
        
    [self initNavigationRightButtonWithTitle:LAN(@"全部取消") titileColor:kNVABICSYSTEMTitleColor];
 

    self.navigationRightBtn.hidden = YES;
    
    CGFloat width = [NSString sizeWithString:LAN(@"当前委托") andMaxSize:CGSizeMake(kScreenWidth, 44) andFont:[UIFont systemFontOfSize:20]].width;
    
    self.navigationTitleLabel.x = (SCREEN_WIDTH-width)/2;
    
    
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).offset(kBICMargin);
    }];
    
    
    CustomGifHeader * header = [CustomGifHeader headerWithRefreshingBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            weakSelf.request.pageNum=1;
           
            [weakSelf setupData:weakSelf.request];
        });
        
    }];
    self.tableView.mj_header = header;
    
    MJRefreshAutoNormalFooter*footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        weakSelf.request.pageNum++;
        
        [weakSelf setupData:weakSelf.request];
    }];
    
    self.tableView.mj_footer = footer;
    
    self.tableView.mj_footer.hidden = YES;

//    [self.tableView.mj_header beginRefreshing];
    
    [self setupRounteHUD];
    
    //添加 当前委托通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CurrentEntrustNotify:) name:NSNotificationCenterCurrentEntrust object:nil];
}

//当前委托通知
//-(void)CurrentEntrustNotify:(NSNotification*)notify{
//    ListUserRowsResponse *rowRes = notify.object;
//
//        //更新数据
//        for(int j=0;j<self.dataArray.count;j++){
//            ListUserRowsResponse *currentRowRes=[self.dataArray objectAtIndex:j];
//            if([currentRowRes.id isEqualToString:rowRes.id]){
//                NSMutableArray *mutabArray=[self.dataArray mutableCopy];
//                if([rowRes.lastNum doubleValue]==0){
//                    [mutabArray removeObjectAtIndex:j];
//                }else{
//                    [mutabArray replaceObjectAtIndex:j withObject:rowRes];
//                }
//                self.dataArray=mutabArray;
//                break;
//            }
//        }
//        //更新cell
//        for(int t=0;t<self.tableView.visibleCells.count;t++){
//            UITableViewCell *cell=[self.tableView.visibleCells objectAtIndex:t];
//            if([cell isKindOfClass:[BICEXCMainStopCell class]]){
//                BICEXCMainStopCell *exccell=(BICEXCMainStopCell *)cell;
//                if([exccell.response.id isEqualToString:rowRes.id]){
//                    if([rowRes.lastNum doubleValue]==0){
//                        [self.tableView deleteRowsAtIndexPaths:@[[self.tableView indexPathForCell:cell]] withRowAnimation:UITableViewRowAnimationLeft];
//                    }else{
//                        exccell.response=rowRes;
//                    }
//                    break;
//                }
//            }
//            if([cell isKindOfClass:[BICEXCMainCell class]]){
//               BICEXCMainCell *exccell=(BICEXCMainCell *)cell;
//               if([exccell.response.id isEqualToString:rowRes.id]){
//                   if([rowRes.lastNum doubleValue]==0){
//                       [self.tableView deleteRowsAtIndexPaths:@[[self.tableView indexPathForCell:cell]] withRowAnimation:UITableViewRowAnimationLeft];
//                   }else{
//                       exccell.response=rowRes;
//                   }
//                   break;
//               }
//            }
//    }
//}

-(void)setupRounteHUD
{
    [ODAlertViewFactory showLoadingViewWithView:self.view];
    self.request.pageNum=1;
    [self setupData:self.request];
}
-(NSMutableArray*)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(void)doRightBtnAction
{
    BICCancelView *view=[[BICCancelView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) title:LAN(@"提示") content:LAN(@"确认取消全部委托?") left:LAN(@"再想想") right:LAN(@"确认取消")];
    WEAK_SELF
    view.clickRightItemOperationBlock = ^{
        BICOrderCancelRequest*request =[[BICOrderCancelRequest alloc] init];
        [[BICExchangeService sharedInstance] analyticalOrderCancelAllData:request serverSuccessResultHandler:^(id response) {
            BICBaseResponse * responseM = (BICBaseResponse*)response;
            if (responseM.code==200) {
                [BICDeviceManager AlertShowTip:LAN(@"取消成功")];
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:ISNeedUpdateExchangeView];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [weakSelf.dataArray removeAllObjects];
                   weakSelf.dataArray.count == 0 ? [weakSelf setupNoDataOfSearch:weakSelf.tableView] : [weakSelf hideNoDataOfSearch];
                             weakSelf.dataArray.count == 0 ? [weakSelf.tableView.mj_footer setHidden:YES] : [weakSelf.tableView.mj_footer setHidden:NO];
                if (weakSelf.dataArray.count == 0) {
                      weakSelf.navigationRightBtn.hidden = YES;
                  }else{
                      weakSelf.navigationRightBtn.hidden = NO;

                  }
                [weakSelf.tableView reloadData];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenterCurrentDelegateNotify object:nil];
            }else{
                [BICDeviceManager AlertShowTip:responseM.msg];
            }
        } failedResultHandler:^(id response) {
            
        } requestErrorHandler:^(id error) {
            
        }];
    };
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}

-(void)setupData:(BICListUserRequest*)request
{
    WEAK_SELF
    [[BICExchangeService sharedInstance] analyticalPCListUserOrderData:request serverSuccessResultHandler:^(id response) {
        weakSelf.response = (BICListUserResponse*)response;
        if (request.pageNum==1) {
            [weakSelf.dataArray removeAllObjects];
        }
        if (weakSelf.response.data) {
            [weakSelf.dataArray addObjectsFromArray:weakSelf.response.data.rows];
        }
        weakSelf.dataArray.count == 0 ? [weakSelf setupNoDataOfSearch:weakSelf.tableView] : [weakSelf hideNoDataOfSearch];
             weakSelf.dataArray.count == 0 ? [weakSelf.tableView.mj_footer setHidden:YES] : [weakSelf.tableView.mj_footer setHidden:NO];
        if (weakSelf.dataArray.count == 0) {
            weakSelf.navigationRightBtn.hidden = YES;
        }else{
            [weakSelf initNavigationRightButtonWithTitle:LAN(@"全部取消") titileColor:kNVABICSYSTEMTitleColor];
            weakSelf.navigationRightBtn.hidden = NO;
        }
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
        if(weakSelf.response.data.rows.count==0){
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [weakSelf.tableView.mj_footer endRefreshing];
        }
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } failedResultHandler:^(id response) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } requestErrorHandler:^(id error) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    }];
}

-(BICListUserRequest*)request
{
    if (!_request) {
        _request = [[BICListUserRequest alloc] init];
    }
    return _request;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=kBICHistoryCellBGColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    ListUserRowsResponse * responseM =self.dataArray[indexPath.row];

    if ([responseM.publishType isEqualToString:@"STOP"]) {
         BICEXCMainStopCell * cell = [BICEXCMainStopCell exitWithTableView:tableView];
                cell.response = self.dataArray[indexPath.row];
            WEAK_SELF
            cell.cancelBlock = ^(ListUserRowsResponse * _Nonnull response) {
                [weakSelf.dataArray removeObject:response];
                self.dataArray.count == 0 ? [self setupNoDataOfSearch:self.tableView] : [self hideNoDataOfSearch];
                self.dataArray.count == 0 ? [self.tableView.mj_footer setHidden:YES] : [self.tableView.mj_footer setHidden:NO];
                if (self.dataArray.count == 0) {
                      self.navigationRightBtn.hidden = YES;
                  }else{
                      self.navigationRightBtn.hidden = NO;
                  }
                [weakSelf.tableView reloadData];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenterCurrentDelegateNotify object:nil];
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:ISNeedUpdateExchangeView];
                [[NSUserDefaults standardUserDefaults] synchronize];
            };
                return cell;
    }

        BICEXCMainCell * cell = [BICEXCMainCell exitWithTableView:tableView];
        cell.response = self.dataArray[indexPath.row];
        WEAK_SELF
        cell.cancelBlock = ^(ListUserRowsResponse * _Nonnull response) {
        [weakSelf.dataArray removeObject:response];
        self.dataArray.count == 0 ? [self setupNoDataOfSearch:self.tableView] : [self hideNoDataOfSearch];
        self.dataArray.count == 0 ? [self.tableView.mj_footer setHidden:YES] : [self.tableView.mj_footer setHidden:NO];
        if (self.dataArray.count == 0) {
              self.navigationRightBtn.hidden = YES;
          }else{
              self.navigationRightBtn.hidden = NO;
          }
        [weakSelf.tableView reloadData];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenterCurrentDelegateNotify object:nil];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:ISNeedUpdateExchangeView];
        [[NSUserDefaults standardUserDefaults] synchronize];
    };
        return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListUserRowsResponse * responseM =self.dataArray[indexPath.row];

    if ([responseM.publishType isEqualToString:@"STOP"]) {
        return 143.f;
    }
    return 123.f;
}


@end

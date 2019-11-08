//
//  BICVerificationVC.m
//  Biconome
//
//  Created by a on 2019/10/5.
//  Copyright © 2019 qsm. All rights reserved.
//

#import "BICPhotoIdentifyVC.h"
#import "BICPhotoViewCell.h"
#import "BICPhotoWithTextViewCell.h"
#import "BICPhotoButtonCell.h"
#import "SelectPhotoManager.h"
#import "BICImageManager.h"
#import "NSString+LW.h"
@interface BICPhotoIdentifyVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)SelectPhotoManager *photoManager;
@property(nonatomic,strong)NSMutableArray *cacheDataArray;
@end

@implementation BICPhotoIdentifyVC

-(NSMutableArray *)cacheDataArray{
    if(!_cacheDataArray){
        _cacheDataArray=[NSMutableArray array];
        if(![self.response.data.status isEqualToString:@"N"]){
            NSArray *t=[NSArray arrayWithContentsOfFile:[CACHEPHOTOFILESPLIST docDir]];
            for(int i=0;i<t.count;i++){
                [_cacheDataArray addObject: [BICImageManager coverStringToImage:[t objectAtIndex:i]]];
            }
        }
    }
    return _cacheDataArray;
}
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
    [self initNavigationTitleViewLabelWithTitle:LAN(@"证件照片") titleColor:kNVABICSYSTEMTitleColor IfBelongTabbar:NO];
    [self.view addSubview:self.tableView];
    //已经上传图片，为防止图片链接过期，重新请求一次
    if(self.response.data.fileUrl1){
        [self requestAuthInfo];
    }
    [self.tableView reloadData];
}

-(void)requestAuthInfo{
    WEAK_SELF
    BICBaseRequest *request = [[BICBaseRequest alloc] init];
    [[BICProfileService sharedInstance] analyticalAuthInfo:request serverSuccessResultHandler:^(id response) {
           weakSelf.response = (BICAuthInfoResponse*)response;
            if(weakSelf.response.code==200){
                if([weakSelf.response.data.status isEqualToString:@"N"]){
                    self.cacheDataArray=nil;
                }
                [weakSelf.tableView reloadData];
            }
       } failedResultHandler:^(id response) {
        
       } requestErrorHandler:^(id error) {
        
       }];
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
    }
    return _tableView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WEAK_SELF
    if(self.cardType==BICCardType_IdentifyCard){
        if(indexPath.row==2){
            BICPhotoWithTextViewCell *cell=[BICPhotoWithTextViewCell cellWithTableView:tableView];
            cell.titleLabel.text=LAN(@"手持证件照");
            cell.desLabel.text=LAN(@"上传包含biconomy.com和当日日期的手写纸条");
            //删除按钮功能
            cell.delClickItemOperationBlock = ^{
                [weakSelf removeClick:indexPath];
            };
            //新增 编辑
            if([[self.dataArray objectAtIndex:indexPath.row] isKindOfClass:[UIImage class]] || [self.response.data.status isEqualToString:@"N"]){
                if(![[self.dataArray objectAtIndex:indexPath.row] isKindOfClass:[UIImage class]]){
                    [self commonSetImage4:cell];
                    if(![self.cacheDataArray objectAtIndex:indexPath.row] && !self.response.data.fileUrl3){
                           cell.delImgView.hidden=YES;
                    }else{
                           cell.delImgView.hidden=NO;
                    }
                }else{
                    cell.bgImgView.image=[self.dataArray objectAtIndex:indexPath.row];
                    cell.delImgView.hidden=NO;
                }
                
            }else{
                //展示时
                cell.delImgView.hidden=YES;
                [self commonSetImage4:cell];
            }
            return cell;
        }else if(indexPath.row==3){
            BICPhotoButtonCell *cell=[BICPhotoButtonCell cellWithTableView:tableView];
            return cell;
        }else{
            BICPhotoViewCell *cell=[BICPhotoViewCell cellWithTableView:tableView];
            if(indexPath.row==0){
                cell.titleLabel.text=LAN(@"身份证正面");
            }else{
                cell.titleLabel.text=LAN(@"身份证背面");
            }
            cell.delClickItemOperationBlock = ^{
                [weakSelf removeClick:indexPath];
            };
            //add update
            if([[self.dataArray objectAtIndex:indexPath.row] isKindOfClass:[UIImage class]] || [self.response.data.status isEqualToString:@"N"]){
                if(![[self.dataArray objectAtIndex:indexPath.row] isKindOfClass:[UIImage class]]){
                    [self commonSetImage3:cell indexPath:indexPath];
                    if(indexPath.row==1){
                        if(![self.cacheDataArray objectAtIndex:indexPath.row] && !self.response.data.fileUrl2){
                            cell.delImgView.hidden=YES;
                        }else{
                            cell.delImgView.hidden=NO;
                        }
                    }else{
                        if(![self.cacheDataArray objectAtIndex:indexPath.row] && !self.response.data.fileUrl1){
                            cell.delImgView.hidden=YES;
                        }else{
                            cell.delImgView.hidden=NO;
                        }
                    }
                }else{
                    cell.bgImgView.image=[self.dataArray objectAtIndex:indexPath.row];
                    cell.delImgView.hidden=NO;
                }
                
           }else{
               cell.delImgView.hidden=YES;
               [self commonSetImage3:cell indexPath:indexPath];
           }
            return cell;
        }
    }else{
        if(indexPath.row==1){
             BICPhotoWithTextViewCell *cell=[BICPhotoWithTextViewCell cellWithTableView:tableView];
             cell.titleLabel.text=LAN(@"手持证件照");
             cell.desLabel.text=LAN(@"上传包含biconomy.com和当日日期的手写纸条");
            cell.delClickItemOperationBlock = ^{
                [weakSelf removeClick:indexPath];
            };
            //add update
            if([[self.dataArray objectAtIndex:indexPath.row] isKindOfClass:[UIImage class]] || [self.response.data.status isEqualToString:@"N"]){
                if(![[self.dataArray objectAtIndex:indexPath.row] isKindOfClass:[UIImage class]]){
                    [self commonSetImage2:cell];
                    if(![self.cacheDataArray objectAtIndex:1] && !self.response.data.fileUrl2){
                        cell.delImgView.hidden=YES;
                    }else{
                        cell.delImgView.hidden=NO;
                    }
                }else{
                    cell.bgImgView.image=[self.dataArray objectAtIndex:indexPath.row];
                    cell.delImgView.hidden=NO;
                }
                
            }else{
                
                cell.delImgView.hidden=YES;
                [self commonSetImage2:cell];
                 
            }
             return cell;
        }else if(indexPath.row==2){
            BICPhotoButtonCell *cell=[BICPhotoButtonCell cellWithTableView:tableView];
            return cell;
        }else{
            BICPhotoViewCell *cell=[BICPhotoViewCell cellWithTableView:tableView];
            if(self.cardType==BICCardType_DriverLicense){
                cell.titleLabel.text=LAN(@"驾照照片页");
            }else{
                cell.titleLabel.text=LAN(@"护照照片页");
            }
            cell.delClickItemOperationBlock = ^{
                [weakSelf removeClick:indexPath];
            };
            //add update
            if([[self.dataArray objectAtIndex:indexPath.row] isKindOfClass:[UIImage class]] || [self.response.data.status isEqualToString:@"N"]){
                if(![[self.dataArray objectAtIndex:indexPath.row] isKindOfClass:[UIImage class]]){
                    [self commonSetImage:cell];
                    if(![self.cacheDataArray objectAtIndex:0] && !self.response.data.fileUrl1){
                        cell.delImgView.hidden=YES;
                    }else{
                        cell.delImgView.hidden=NO;
                    }
                }else{
                    cell.bgImgView.image=[self.dataArray objectAtIndex:indexPath.row];
                    cell.delImgView.hidden=NO;
                }
                
            }else{
                cell.delImgView.hidden=YES;
                [self commonSetImage:cell];
            }
            return cell;
        }
    }
}
-(void)removeClick:(NSIndexPath *)indexPath{
    self.dataArray[indexPath.row]=@"";
    self.cacheDataArray=nil;
    if(indexPath.row==0){
        self.response.data.fileUrl1=nil;
    }else if(indexPath.row==1){
        self.response.data.fileUrl2=nil;
    }else if(indexPath.row==2){
        self.response.data.fileUrl3=nil;
    }
    UITableViewCell *cell=[self.tableView cellForRowAtIndexPath:indexPath];
    if([cell isKindOfClass:[BICPhotoViewCell class]]){
        BICPhotoViewCell * cell=(BICPhotoViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        cell.delImgView.hidden=YES;
    }else{
        BICPhotoWithTextViewCell * cell=(BICPhotoWithTextViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        cell.delImgView.hidden=YES;
    }
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)commonSetImage4:(BICPhotoWithTextViewCell *)cell{
    if([self.cacheDataArray objectAtIndex:2]){
        cell.bgImgView.image=[self.cacheDataArray objectAtIndex:2];
    }else{
        [cell.bgImgView sd_setImageWithURL:[NSURL URLWithString:self.response.data.fileUrl3] placeholderImage:[UIImage imageNamed:@"bitmap_handheld_example"]];
    }
}
-(void)commonSetImage3:(BICPhotoViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
         if([self.cacheDataArray objectAtIndex:0]){
                 cell.bgImgView.image=[self.cacheDataArray objectAtIndex:0];
         }else{
                 [cell.bgImgView sd_setImageWithURL:[NSURL URLWithString:self.response.data.fileUrl1] placeholderImage:[UIImage imageNamed:@"bitmap_identity_front_example"]];
         }
    }else{
        if([self.cacheDataArray objectAtIndex:1]){
                cell.bgImgView.image=[self.cacheDataArray objectAtIndex:1];
        }else{
            [cell.bgImgView sd_setImageWithURL:[NSURL URLWithString:self.response.data.fileUrl2] placeholderImage:[UIImage imageNamed:@"bitmap_identity_front_example"]];
        }
    }
}
-(void)commonSetImage2:(BICPhotoWithTextViewCell *)cell{
    if([self.cacheDataArray objectAtIndex:1]){
        cell.bgImgView.image=[self.cacheDataArray objectAtIndex:1];
    }else{
        [cell.bgImgView sd_setImageWithURL:[NSURL URLWithString:self.response.data.fileUrl2] placeholderImage:[UIImage imageNamed:@"bitmap_handheld_example"]];
    }
}
-(void)commonSetImage:(BICPhotoViewCell *)cell{
    if(self.cardType==BICCardType_DriverLicense){

            if([self.cacheDataArray objectAtIndex:0]){
                    cell.bgImgView.image=[self.cacheDataArray objectAtIndex:0];
            }else{
                [cell.bgImgView sd_setImageWithURL:[NSURL URLWithString:self.response.data.fileUrl1] placeholderImage:[UIImage imageNamed:@"bitmap_driverlicense_front_example"]];
            }
        
    }else{

            if([self.cacheDataArray objectAtIndex:0]){
                    cell.bgImgView.image=[self.cacheDataArray objectAtIndex:0];
            }else{
                [cell.bgImgView sd_setImageWithURL:[NSURL URLWithString:self.response.data.fileUrl1] placeholderImage:[UIImage imageNamed:@"bitmap_passport_front_example"]];
            }
        
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(self.cardType==BICCardType_IdentifyCard){
        if(indexPath.row==3){
            //提交逻辑
            [self requestAddCardInfo];
        }else{
            if(!self.response.data.fileUrl1 || [self.response.data.status isEqualToString:@"N"]){
                //图片上传
                [self selectPhoto:indexPath];
            }
        }
    }else{
        if(indexPath.row==2){
            //提交逻辑
            [self requestAddCardInfo];
        }else{
            if(!self.response.data.fileUrl1 || [self.response.data.status isEqualToString:@"N"]){
                //图片上传
                [self selectPhoto:indexPath];
            }
        }
    }
}

-(void)requestAddCardInfo{
    if(self.cardType==BICCardType_IdentifyCard){
        if([[self.dataArray objectAtIndex:0] isKindOfClass:[NSString class]]){
            [BICDeviceManager AlertShowTip:LAN(@"请上传身份证正面")];
            return;
        }
        if([[self.dataArray objectAtIndex:1] isKindOfClass:[NSString class]]){
            [BICDeviceManager AlertShowTip:LAN(@"请上传身份证背面")];
            return;
        }
        if([[self.dataArray objectAtIndex:2] isKindOfClass:[NSString class]]){
            [BICDeviceManager AlertShowTip:LAN(@"请上传您的手持证件照")];
            return;
        }
    }
    
    if(self.cardType==BICCardType_Passport){
        if([[self.dataArray objectAtIndex:0] isKindOfClass:[NSString class]]){
           [BICDeviceManager AlertShowTip:LAN(@"请上传护照照片页")];
           return;
       }
        if([[self.dataArray objectAtIndex:1] isKindOfClass:[NSString class]]){
           [BICDeviceManager AlertShowTip:LAN(@"请上传您的手持证件照")];
           return;
        }
    }
    
    if(self.cardType==BICCardType_DriverLicense){
        if([[self.dataArray objectAtIndex:0] isKindOfClass:[NSString class]]){
           [BICDeviceManager AlertShowTip:LAN(@"请上传驾驶证照片页")];
           return;
       }
        if([[self.dataArray objectAtIndex:1] isKindOfClass:[NSString class]]){
           [BICDeviceManager AlertShowTip:LAN(@"请上传您的手持证件照")];
           return;
        }
    }
    
    BICAuthInfoRequest *request=[[BICAuthInfoRequest alloc] init];
    NSArray *imageArray;
    if(self.cardType==BICCardType_IdentifyCard){
        imageArray=[NSArray arrayWithObjects:[self.dataArray objectAtIndex:0],[self.dataArray objectAtIndex:1],[self.dataArray objectAtIndex:2], nil];
        
    }else{
        imageArray=[NSArray arrayWithObjects:[self.dataArray objectAtIndex:0],[self.dataArray objectAtIndex:1], nil];
    }
    request.files=imageArray;
    [self cacheToDoc:imageArray];
    [ODAlertViewFactory showLoadingViewWithView:self.view];
    WEAK_SELF
    [[BICProfileService sharedInstance] analyticaladdAuthCardImageInfo:request serverSuccessResultHandler:^(id response) {
        BICBaseResponse  *responseM = (BICBaseResponse*)response;
        if (responseM.code==200) {
            [[UtilsManager getCurrentVC].navigationController popViewControllerAnimated:YES];
        }else{
            [BICDeviceManager AlertShowTip:responseM.msg];
        }
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } failedResultHandler:^(id response) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    } requestErrorHandler:^(id error) {
        [ODAlertViewFactory hideAllHud:weakSelf.view];
    }];
}

-(void)cacheToDoc:(NSArray *)array{
    NSMutableArray *cachearray=[NSMutableArray array];
    for(int i=0;i<array.count;i++){
        NSString *base64=[BICImageManager coverImageToString:[array objectAtIndex:i]];
        [cachearray addObject:base64];
    }
    if([cachearray writeToFile:[CACHEPHOTOFILESPLIST docDir] atomically:YES]){
        RSDLog(@"保存成功");
    }
    
}

-(void)selectPhoto:(NSIndexPath *)indexPath{
  //选取照片成功
   WEAK_SELF
   self.photoManager.successHandle=^(SelectPhotoManager *manager,NSDictionary *info){
       NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
       // 判断获取类型：图片
       if ([mediaType isEqualToString:( NSString *)kUTTypeImage]){
           UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
           if (image == nil) {
               image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
           }
//         NSData *data=[BICImageManager zipNSDataWithImage:image];
           weakSelf.dataArray[indexPath.row]=image;
       }
       [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
   };
   [self.photoManager startSelectPhotoWithImageName:@""];
}

-(SelectPhotoManager *)photoManager{
    if(_photoManager==nil){
        NSString *requiredMediaType = ( NSString *)kUTTypeImage;
        NSArray *array=[NSArray arrayWithObjects:requiredMediaType,nil];
        _photoManager =[SelectPhotoManager initWithMediaTypeArray:array];
    }
    return _photoManager;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.cardType==BICCardType_IdentifyCard){
        if(!self.response.data.fileUrl1 || [self.response.data.status isEqualToString:@"N"]){
            return 4;
        }else{
            return 3;
        }
    }else{
        if(!self.response.data.fileUrl1 || [self.response.data.status isEqualToString:@"N"]){
            return 3;
        }else{
            return 2;
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.cardType==BICCardType_IdentifyCard){
        if(indexPath.row==2){
            return 296+16;
        }else if(indexPath.row==3){
            return 84+16;
        }else{
            return 268+16;
        }
    }else{
        if(indexPath.row==1){
            return 296+16;
        }else if(indexPath.row==2){
            return 84+16;
        }else{
            return 268+16;
        }
    }
}
-(NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray=[NSMutableArray arrayWithObjects:@"",@"",@"",@"", nil];
    }
    return _dataArray;
}
@end

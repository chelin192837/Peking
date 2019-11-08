//
//  BICVerificationVC.h
//  Biconome
//
//  Created by a on 2019/10/5.
//  Copyright © 2019 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BICAuthInfoResponse.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,BICCardType)
{
    BICCardType_IdentifyCard=1,//身份证
    BICCardType_Passport=2, //护照
    BICCardType_DriverLicense=3 //驾照
};
@interface BICPhotoIdentifyVC : BaseViewController
@property(nonatomic,assign)BICCardType cardType;
@property(nonatomic,strong)BICAuthInfoResponse *response;
@property (nonatomic, copy) void (^backReloadOperationBlock)(void);
@end

NS_ASSUME_NONNULL_END

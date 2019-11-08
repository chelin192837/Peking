//
//  BICBasicInfoViewController.h
//  Biconome
//
//  Created by a on 2019/10/5.
//  Copyright © 2019 qsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BICAppStoreResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface BICUpdateViewController : BaseViewController
@property (strong, nonatomic)BICAppStoreResponse * response;
@end

NS_ASSUME_NONNULL_END

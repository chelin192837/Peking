//
//  RSDBaseRequest.h
//  Agent
//
//  Created by wangliang on 2017/8/24.
//  Copyright © 2017年 七扇门. All rights reserved.
//

#import "JSONModel.h"

@interface RSDBaseRequest : JSONModel

@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSString *app_version;

@end

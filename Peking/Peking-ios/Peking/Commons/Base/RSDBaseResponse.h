//
//  RSDBaseResponse.h
//  Agent
//
//  Created by wangliang on 2017/8/24.
//  Copyright © 2017年 七扇门. All rights reserved.
//

#import "JSONModel.h"

@interface RSDBaseResponse : JSONModel
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSString  *msg;
@property (nonatomic, assign) NSInteger status;//100000 成功 其他失败
@property (nonatomic, strong) NSString  *extra;
@property (nonatomic, strong) NSString  *error;

@end

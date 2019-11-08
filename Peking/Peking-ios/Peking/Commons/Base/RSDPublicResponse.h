//
//  RSDPublicResponse.h
//  Agent
//
//  Created by wangliang on 2017/10/12.
//  Copyright © 2017年 七扇门. All rights reserved.
//

#import "RSDBaseResponse.h"

@interface RSDPublicResponse : RSDBaseResponse
///
@property (nonatomic,assign) NSInteger data;
@end

@interface RSDPublicDicResponse : RSDBaseResponse
///
@property (nonatomic,strong) NSDictionary *data;
@end

@interface RSDPublicArrayResponse : RSDBaseResponse
///
@property (nonatomic,strong) NSArray *data;
@end

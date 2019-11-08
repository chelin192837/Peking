//
//  BICHisCollectCell.m
//  Biconome
//
//  Created by 车林 on 2019/8/21.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICHisCollectCell.h"

@implementation BICHisCollectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleBGView.layer.cornerRadius = 8.f;
    self.titleBGView.layer.masksToBounds = YES;
    
    self.titleBGView.backgroundColor = kBICHomeBGColor;
    
}

@end

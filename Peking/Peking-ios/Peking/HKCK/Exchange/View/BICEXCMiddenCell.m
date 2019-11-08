//
//  BICEXCMiddenCell.m
//  Biconome
//
//  Created by 车林 on 2019/8/23.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICEXCMiddenCell.h"
#import "BICMineOrderDeleVC.h"

@interface BICEXCMiddenCell()
@property (weak, nonatomic) IBOutlet UILabel *currentDelLab;
@property (weak, nonatomic) IBOutlet UIButton *allBtnClick;



@end
@implementation BICEXCMiddenCell

- (IBAction)allBtn:(id)sender {
    
//    BICMineOrderDeleVC * deleVC = [[BICMineOrderDeleVC alloc] init];
//    
//    [self.yq_viewController.navigationController pushViewController:deleVC animated:YES];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.currentDelLab.text = LAN(@"当前委托");
    [self.allBtnClick setTitle:LAN(@"全部") forState:UIControlStateNormal];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

+(instancetype)exitWithTableView:(UITableView*)tableView
{
    NSString* cellId = @"BICEXCMiddenCell";
    BICEXCMiddenCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

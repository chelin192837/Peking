//
//  BICEXCHorLine.m
//  Biconome
//
//  Created by 车林 on 2019/8/24.
//  Copyright © 2019年 qsm. All rights reserved.
//

#import "BICEXCHorLine.h"
#import "BICEXCRightLine.h"
#import "BICEXCLeftLine.h"
#import "BICEXCMiddenLine.h"
@interface BICEXCHorLine()

@end
@implementation BICEXCHorLine

-(instancetype)initWithFrame:(CGRect)frame With:(HorLineType)type
{
    if (self=[super initWithFrame:frame]) {
        [self setupUI:frame With:type];
    }
    return self;
}
-(instancetype)initWithLeftFrame:(CGRect)frame With:(HorLineType)type
{
    if (self=[super initWithFrame:frame]) {
        [self setupUILeft:frame With:type];
    }
    return self;
}
-(instancetype)initWithMiddenFrame:(CGRect)frame With:(HorLineType)type
{
    if (self=[super initWithFrame:frame]) {
        [self setupUIMidden:frame With:type];
    }
    return self;
}
-(void)setupUI:(CGRect)frame With:(HorLineType)type
{
    self.type=type;
    for (int i=0; i<5; i++) {
        BICEXCRightLine *line = [[BICEXCRightLine alloc] initWithNibWith:type];
        line.frame= CGRectMake(0,i * 28, frame.size.width, 28);
        [self addSubview:line];
    }
}

-(void)setupUILeft:(CGRect)frame With:(HorLineType)type
{
    self.type=type;
    for (int i=0; i<5; i++) {
        BICEXCLeftLine *line = [[BICEXCLeftLine alloc] initWithNibWith:type];
        line.frame= CGRectMake(0,i * 28, frame.size.width, 28);
        [self addSubview:line];
    }
}

-(void)setupUIMidden:(CGRect)frame With:(HorLineType)type
{
    self.type=type;
    for (int i=0; i<6; i++) {
        BICEXCMiddenLine *line = [[BICEXCMiddenLine alloc] initWithNibWith:type];
        line.frame= CGRectMake(0,i * 28, frame.size.width, 28);
        [self addSubview:line];
    }
}

-(void)setArr:(NSArray *)arr
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    NSUInteger count = 0 ;
    if (arr.count>5) {
        count = 5;
    }else{
        count = arr.count;
    }
    
    
    if (self.type == HorLineType_Green) {
        for (int i=0; i<count; i++) {
            BICEXCRightLine *line = [[BICEXCRightLine alloc] initWithNibWith:self.type];
            line.frame= CGRectMake(0,i * 28, self.frame.size.width, 28);
            if(self.isRever){
                [line setModelRever:arr[i]];
                [line setupUIRever:self.type];
            }else{
                line.model = arr[i];
                [line setupUI:self.type];
            }
            
            [self addSubview:line];
        }
    }
    
    if (self.type==HorLineType_red) {
        for (int i=0; i<count; i++) {
            BICEXCRightLine *line = [[BICEXCRightLine alloc] initWithNibWith:self.type];
            line.frame= CGRectMake(0,(5-i-1) * 28, self.frame.size.width, 28);
            if(self.isRever){
                 [line setModelRever:arr[i]];
                [line setupUIRever:self.type];
            }else{
                line.model = arr[i];
                [line setupUI:self.type];
            }
            
            [self addSubview:line];
        }
    }

}

-(void)setArrLeft:(NSArray *)arrLeft
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSUInteger count = 0 ;
    if (arrLeft.count>5) {
        count = 5;
    }else{
        count = arrLeft.count;
    }
    for (int i=0; i<count; i++) {
        BICEXCLeftLine *line = [[BICEXCLeftLine alloc] initWithNibWith:self.type];
        line.frame= CGRectMake(0,i * 28, self.frame.size.width, 28);
        line.model = arrLeft[i];
        [line setupUI:self.type];
        [self addSubview:line];
    }
    
}

-(void)setArrMidArr:(NSArray *)arrMidArr
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSUInteger count = 0 ;
    if (arrMidArr.count>30) {
        count = 30;
    }else{
        count = arrMidArr.count;
    }
    for (int i=0; i<count; i++) {
        BICEXCMiddenLine *line = [[BICEXCMiddenLine alloc] initWithNibWith:self.type];
        line.frame= CGRectMake(0,i * 28, self.frame.size.width, 28);
        line.model = arrMidArr[i];
        [line setupUI:self.type];
        [self addSubview:line];
    }
}
-(void)setType:(HorLineType)type
{
    _type = type;
}

@end

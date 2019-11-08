//
//  VPickView.m
//  AICity
//
//  Created by wei.z on 2019/8/1.
//  Copyright © 2019 wei.z. All rights reserved.
//

#import "VPickView.h"
@interface VPickView()<UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic,strong)UIPickerView *pickerView;
@property(nonatomic,strong)NSMutableArray *dataSouce;
@end
@implementation VPickView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        [self addSubview:self.pickerView];
        self.backgroundColor=[UIColor grayColor];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyyMMddHHmm"];
        NSString *dateString = [formatter stringFromDate:[NSDate date]];
        NSInteger month   = [[dateString substringWithRange:NSMakeRange(4, 2)] integerValue];
        NSInteger day     = [[dateString substringWithRange:NSMakeRange(6, 2)] integerValue];
        [self.pickerView selectRow:200 inComponent:0 animated:YES];
        [self.pickerView selectRow:month-1 inComponent:1 animated:YES];
        [self.pickerView selectRow:day-1 inComponent:2 animated:YES];
    }
    return self;
}
- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 180)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        //_pickerView.showsSelectionIndicator = YES;
    }
    return _pickerView;
    
}
- (NSMutableArray *)dataSouce {
    if (!_dataSouce) {
        NSMutableArray *arrayY=[NSMutableArray array];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyyMMddHHmm"];
        NSString *dateString = [formatter stringFromDate:[NSDate date]];
        int year = [[dateString substringWithRange:NSMakeRange(0, 4)] intValue];
        for(int i=year-200;i<year+200;i++){
            NSString *str=[NSString stringWithFormat:@"%d",i];
            [arrayY addObject:str];
        }
        NSMutableArray *arrayM=[NSMutableArray array];
        for(int i=1;i<13;i++){
            NSString *str=[NSString stringWithFormat:@"%d",i];
            [arrayM addObject:str];
        }
        _dataSouce=[NSMutableArray array];
        [_dataSouce addObject:arrayY];
        [_dataSouce addObject:arrayM];
    }
    return _dataSouce;
}


- (id)initWithDate:(NSDate *)date
{
    self = [super init];
    if (self) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyyMMddHHmm"];
        NSString *dateString = [formatter stringFromDate:date];
//        self.year     = [dateString substringWithRange:NSMakeRange(0, 4)];
//        self.month    = [dateString substringWithRange:NSMakeRange(4, 2)];
//        self.day      = [dateString substringWithRange:NSMakeRange(6, 2)];
//        self.hour     = [dateString substringWithRange:NSMakeRange(8, 2)];
//        self.minute   = [dateString substringWithRange:NSMakeRange(10, 2)];
    }
    return self;
}
- (NSInteger)DaysfromYear:(NSInteger)year andMonth:(NSInteger)month
{
    NSInteger num_year  = year;
    NSInteger num_month = month;
    
    BOOL isrunNian = num_year%4==0 ? (num_year%100==0? (num_year%400==0?YES:NO):YES):NO;
    switch (num_month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:{
 
            return 31;
        }
            break;
        case 4:
        case 6:
        case 9:
        case 11:{
           
            return 30;
        }
            break;
        case 2:{
            if (isrunNian) {
               
                return 29;
            }else{
                
                return 28;
            }
        }
            break;
        default:
            break;
    }
    return 0;
}

#pragma mark - dataSouce

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    //普通状态的颜色
    UILabel* norLabel = (UILabel*)view;
    if (!norLabel){
        norLabel = [[UILabel alloc] init];
        norLabel.textColor = [UIColor whiteColor];
        norLabel.adjustsFontSizeToFitWidth = YES;
        [norLabel setTextAlignment:NSTextAlignmentCenter];
        [norLabel setFont:[UIFont systemFontOfSize:13]];
    }
    norLabel.text = [self pickerView:pickerView
                         titleForRow:row
                        forComponent:component];
    
    //设置分割线
    for (UIView *line in pickerView.subviews) {
        if (line.frame.size.height < 1) {//0.6667
            line.backgroundColor = [UIColor whiteColor];
        }
    }
    return norLabel;
}

// Components
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
    
}
//Rows
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (0 == component) {
        NSArray *array=(NSArray *)[self.dataSouce objectAtIndex:0];
        return array.count;
    }else if(component ==1){
        NSArray *array=(NSArray *)[self.dataSouce objectAtIndex:1];
        return array.count;
    }else if(component ==2){
        //选中的row在Component中
        NSInteger selectRowY = [pickerView selectedRowInComponent:0];
        NSArray *arrayY=(NSArray *)[self.dataSouce objectAtIndex:0];
        NSInteger y=[[arrayY objectAtIndex:selectRowY] integerValue];
        NSInteger selectRowM = [pickerView selectedRowInComponent:1];
        NSArray *arrayM=(NSArray *)[self.dataSouce objectAtIndex:1];
        NSInteger m=[[arrayM objectAtIndex:selectRowM] integerValue];
        return [self DaysfromYear:y andMonth:m];
    }
    return 0;
}
//title
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (0 == component) {
        NSArray *array=(NSArray *)[self.dataSouce objectAtIndex:0];
        return [array objectAtIndex:row];
    }else if (1 == component) {
           NSArray *array=(NSArray *)[self.dataSouce objectAtIndex:1];
           return [array objectAtIndex:row];
    }
    else if(2 == component) {
        return [NSString stringWithFormat:@"%ld",row+1];
    }
    return @"";
}
#pragma mark - delegate
//Select
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        [pickerView reloadComponent:2];
//        [pickerView selectRow:0 inComponent:2 animated:YES];
    }
    if (component == 1) {
        [pickerView reloadComponent:2];
    }
    //  return  select Row In Compone
    NSInteger selectRowY = [pickerView selectedRowInComponent:0];
    NSArray *arrayY=(NSArray *)[self.dataSouce objectAtIndex:0];
    NSInteger y=[[arrayY objectAtIndex:selectRowY] integerValue];
    NSInteger selectRowM = [pickerView selectedRowInComponent:1];
    NSArray *arrayM=(NSArray *)[self.dataSouce objectAtIndex:1];
    NSInteger m=[[arrayM objectAtIndex:selectRowM] integerValue];
    NSInteger d = [pickerView selectedRowInComponent:2];
    NSLog(@"%ld-%02ld-%02ld",y,m,d+1);
    NSString *str=[NSString stringWithFormat:@"%ld-%02ld-%02ld",y,m,d+1];
    if(self.selectedItemOperationBlock){
        self.selectedItemOperationBlock(str);
    }
   
}
@end

//
//  NSDate+Pretty.m
//  Agent
//
//  Created by qsm on 2018/5/19.
//  Copyright © 2018年 七扇门. All rights reserved.
//

#import "NSDate+Pretty.h"

@implementation NSDate (Pretty)

- (NSString *)prettyDateWithReference:(NSDate *)reference {
    NSString *suffix = @"前";
    
    float different = [reference timeIntervalSinceDate:self];
    if (different < 0) {
        different = -different;
        suffix = @"前";
    }
    
    // days = different / (24 * 60 * 60), take the floor value
    float dayDifferent = floor(different / 86400);
    
    int days   = (int)dayDifferent;
//    int weeks  = (int)ceil(dayDifferent / 7);
//    int months = (int)ceil(dayDifferent / 30);
//    int years  = (int)ceil(dayDifferent / 365);
    
    // It belongs to today
    if (dayDifferent <= 0) {
        return @"一天之内"; //一天之内的都显示一天之内
        // lower than 60 seconds
//        if (different < 60) {
//            return @"just now";
//        }
//
//        // lower than 120 seconds => one minute and lower than 60 seconds
//        if (different < 120) {
//            return [NSString stringWithFormat:@"1 minute %@", suffix];
//        }
//
//        // lower than 60 minutes
//        if (different < 660 * 60) {
//            return [NSString stringWithFormat:@"%d minutes %@", (int)floor(different / 60), suffix];
//        }
//
//        // lower than 60 * 2 minutes => one hour and lower than 60 minutes
//        if (different < 7200) {
//            return [NSString stringWithFormat:@"1 hour %@", suffix];
//        }
//
//        // lower than one day
//        if (different < 86400) {
//            return [NSString stringWithFormat:@"%d hours %@", (int)floor(different / 3600), suffix];
//        }
    }
    // lower than one week
    else if (days < 3) {
        NSString* dayStr ;
        switch (days) {
            case 1:
                {
                dayStr = @"一" ;
                }
                break;
            case 2:
            {
                dayStr = @"两" ;

            }
                break;
                
            default:
                break;
        }
        return [NSString stringWithFormat:@"%@天%@", dayStr, suffix];
    }else
    {
        return @"三天前";
    }
    // lager than one week but lower than a month
//    else if (weeks < 4) {
//        return [NSString stringWithFormat:@"%d week%@ %@", weeks, weeks == 1 ? @"" : @"s", suffix];
//    }
//    // lager than a month and lower than a year
//    else if (months < 12) {
//        return [NSString stringWithFormat:@"%d month%@ %@", months, months == 1 ? @"" : @"s", suffix];
//    }
//    // lager than a year
//    else {
//        return [NSString stringWithFormat:@"%d year%@ %@", years, years == 1 ? @"" : @"s", suffix];
//    }
    
    return self.description;
}
- (NSString *)prettyDateWithReferenceOfTwo:(NSDate *)reference {
    NSString *suffix = @"近";

    float different = [reference timeIntervalSinceDate:self];
    if (different < 0) {
        different = -different;
        suffix = @"近";
    }
    
    float dayDifferent = floor(different / 86400);
    
    int days   = (int)dayDifferent;
    
    // It belongs to today
    if (dayDifferent <= 0) {
        return @"近三天"; //一天之内的都显示一天之内
    }
    // lower than one week
    else if (days < 3) {
        return @"近三天";
    }else
    {
        return @"三天前";
    }
    return self.description;
}
@end

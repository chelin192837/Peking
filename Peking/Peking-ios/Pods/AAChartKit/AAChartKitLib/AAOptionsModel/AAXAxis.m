//
//  AAXAxis.m
//  AAChartKit
//
//  Created by An An on 17/1/5.
//  Copyright © 2017年 An An. All rights reserved.
//*************** ...... SOURCE CODE ...... ***************
//***...................................................***
//*** https://github.com/AAChartModel/AAChartKit        ***
//*** https://github.com/AAChartModel/AAChartKit-Swift  ***
//***...................................................***
//*************** ...... SOURCE CODE ...... ***************

/*
 
 * -------------------------------------------------------------------------------
 *
 * 🌕 🌖 🌗 🌘  ❀❀❀   WARM TIPS!!!   ❀❀❀ 🌑 🌒 🌓 🌔
 *
 * Please contact me on GitHub,if there are any problems encountered in use.
 * GitHub Issues : https://github.com/AAChartModel/AAChartKit/issues
 * -------------------------------------------------------------------------------
 * And if you want to contribute for this project, please contact me as well
 * GitHub        : https://github.com/AAChartModel
 * StackOverflow : https://stackoverflow.com/users/7842508/codeforu
 * JianShu       : https://www.jianshu.com/u/f1e6753d4254
 * SegmentFault  : https://segmentfault.com/u/huanghunbieguan
 *
 * -------------------------------------------------------------------------------
 
 */
#import "AAXAxis.h"

@implementation AAXAxis

- (instancetype)init {
    self = [super init];
    if (self) {
        _visible = true;
        _tickmarkPlacement = @"on";//本参数只对分类轴有效。 当值为 on 时刻度线将在分类上方显示；当值为 between 时，刻度线将在两个分类中间显示。当 tickInterval 为 1 时，highcharts官方默认是 between,我这里手动将其改为 on
    }
    return self;
}

AAPropSetFuncImplementation(AAXAxis, NSArray  *, plotBands)
AAPropSetFuncImplementation(AAXAxis, NSArray  *, plotLines)
AAPropSetFuncImplementation(AAXAxis, NSArray  *, categories) 
AAPropSetFuncImplementation(AAXAxis, BOOL ,      reversed) 
AAPropSetFuncImplementation(AAXAxis, NSNumber *, lineWidth) //x轴轴线宽度
AAPropSetFuncImplementation(AAXAxis, NSString *, lineColor) //x轴轴线线颜色
AAPropSetFuncImplementation(AAXAxis, NSNumber *, max)  //x轴最大值
AAPropSetFuncImplementation(AAXAxis, NSNumber *, min)  //x轴最小值（设置为0就不会有负数）
AAPropSetFuncImplementation(AAXAxis, NSNumber *, gridLineWidth) //x轴网格线宽度
AAPropSetFuncImplementation(AAXAxis, NSString *, gridLineColor) //x轴网格线颜色
AAPropSetFuncImplementation(AAXAxis, NSString *, gridLineDashStyle) //x轴网格线样式
AAPropSetFuncImplementation(AAXAxis, NSNumber *, offset) //x轴垂直偏移
AAPropSetFuncImplementation(AAXAxis, AALabels *, labels) 
AAPropSetFuncImplementation(AAXAxis, BOOL ,      visible)
AAPropSetFuncImplementation(AAXAxis, BOOL ,      startOnTick) //Whether to force the axis to start on a tick. Use this option with the minPadding option to control the axis start. 默认是：false.
AAPropSetFuncImplementation(AAXAxis, AACrosshair*, crosshair)  //准星线样式设置
AAPropSetFuncImplementation(AAXAxis, NSString *, tickColor) //x轴轴线下方刻度线颜色
AAPropSetFuncImplementation(AAXAxis, NSNumber *, tickInterval) //x轴刻度点间隔数(设置每隔几个点显示一个 X轴的内容)
AAPropSetFuncImplementation(AAXAxis, NSString *, tickmarkPlacement) //本参数只对分类轴有效。 当值为 on 时刻度线将在分类上方显示；当值为 between 时，刻度线将在两个分类中间显示。当 tickInterval 为 1 时，默认是 between，其他情况默认是 on。 默认是：null.
AAPropSetFuncImplementation(AAXAxis, NSNumber *, tickWidth) //坐标轴刻度线的宽度，设置为 0 时则不显示刻度线
AAPropSetFuncImplementation(AAXAxis, NSNumber *, tickLength)//坐标轴刻度线的长度。 默认是：10.
AAPropSetFuncImplementation(AAXAxis, NSString *, tickPosition) //刻度线相对于轴线的位置，可用的值有 inside 和 outside，分别表示在轴线的内部和外部。 默认是：outside.


@end

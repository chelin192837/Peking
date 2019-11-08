//
//  AALegend.h
//  AAChartKit
//
//  Created by An An on 17/1/6.
//  Copyright © 2017年 An An. All rights reserved.
//
//*************** ...... SOURCE CODE ...... ***************
//***...................................................***
//***    https://github.com/AAChartModel/AAChartKit     ***
//***...................................................***
//*************** ...... SOURCE CODE ...... ***************
//

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

#import <Foundation/Foundation.h>
@class AAItemStyle;

typedef NSString *AALegendLayoutType;
typedef NSString *AALegendAlignType;
typedef NSString *AALegendVerticalAlignType;

extern AALegendLayoutType const AALegendLayoutTypeHorizontal;
extern AALegendLayoutType const AALegendLayoutTypeVertical;

extern AALegendAlignType const AALegendAlignTypeLeft;
extern AALegendAlignType const AALegendAlignTypeCenter;
extern AALegendAlignType const AALegendAlignTypeRight;

extern AALegendVerticalAlignType const AALegendVerticalAlignTypeTop;
extern AALegendVerticalAlignType const AALegendVerticalAlignTypeMiddle;
extern AALegendVerticalAlignType const AALegendVerticalAlignTypeBottom;

@interface AALegend : NSObject

AAPropStatementAndPropSetFuncStatement(copy,   AALegend, AALegendLayoutType,        layout) //图例数据项的布局。布局类型： "horizontal" 或 "vertical" 即水平布局和垂直布局 默认是：horizontal.
AAPropStatementAndPropSetFuncStatement(copy,   AALegend, AALegendAlignType,         align) //设定图例在图表区中的水平对齐方式，合法值有left，center 和 right。
AAPropStatementAndPropSetFuncStatement(copy,   AALegend, AALegendVerticalAlignType, verticalAlign) //设定图例在图表区中的垂直对齐方式，合法值有 top，middle 和 bottom。垂直位置可以通过 y 选项做进一步设定。
AAPropStatementAndPropSetFuncStatement(assign, AALegend, BOOL,          enabled) 
AAPropStatementAndPropSetFuncStatement(copy,   AALegend, NSString    *, borderColor) 
AAPropStatementAndPropSetFuncStatement(strong, AALegend, NSNumber    *, borderWidth) 
AAPropStatementAndPropSetFuncStatement(strong, AALegend, NSNumber    *, itemMarginTop) //图例的每一项的顶部外边距，单位px。 默认是：0.
AAPropStatementAndPropSetFuncStatement(strong, AALegend, NSNumber    *, itemMarginBottom)//图例项底边距 默认是：0.
AAPropStatementAndPropSetFuncStatement(strong, AALegend, AAItemStyle *, itemStyle)
AAPropStatementAndPropSetFuncStatement(strong, AALegend, NSNumber    *, symbolHeight)//标志高度
AAPropStatementAndPropSetFuncStatement(strong, AALegend, NSNumber    *, symbolPadding)//标志后距
AAPropStatementAndPropSetFuncStatement(strong, AALegend, NSNumber    *, symbolRadius)//图标圆角
AAPropStatementAndPropSetFuncStatement(strong, AALegend, NSNumber    *, symbolWidth)//图标宽度
AAPropStatementAndPropSetFuncStatement(strong, AALegend, NSNumber    *, x) 
AAPropStatementAndPropSetFuncStatement(strong, AALegend, NSNumber    *, y)

@end



@interface AAItemStyle : NSObject

AAPropStatementAndPropSetFuncStatement(copy, AAItemStyle, NSString *, color)
AAPropStatementAndPropSetFuncStatement(copy, AAItemStyle, NSString *, cursor)
AAPropStatementAndPropSetFuncStatement(copy, AAItemStyle, NSString *, pointer)
AAPropStatementAndPropSetFuncStatement(copy, AAItemStyle, NSString *, fontSize)
AAPropStatementAndPropSetFuncStatement(copy, AAItemStyle, NSString *, fontWeight)

@end

//
//  RSDConfig.h
//  Agent
//
//  Created by wangliang on 2017/8/24.
//  Copyright © 2017年 七扇门. All rights reserved.
//

#ifndef RSDConfig_h
#define RSDConfig_h

//
#define kPersonPlaceholderImage @"首页我的客户"
/// 更新用户当前位置
#define kUpdate_UserLocation  @"kUpdate_UserLocation"
/// 是否弹出设置定位提示框
#define kAlertDialogShowOrNo  @"kAlertDialogShowOrNo"
/// 提示框存入偏好设置的标志
#define firstLoadOpenLocationYesOrNo  @"firstLoadOpenLocationYesOrNo"
/// 用户当前位置信息
#define kUser_LocationModel  @"kUser_LocationModel"
/// 消息免打扰
#define kCloseMessageAlert @"kCloseMessageAlert"
// 更改城市
#define kChange_Selected_City @"kChange_Selected_City"
// 更改地铁
#define kChange_Selected_Subway @"kChange_Selected_Subway"
//更改标题导航栏
#define kChange_Title_Item @"kChange_Title_Item"
//启动引导页
#define kNSBOOT_PAGE_HOME @"kNSBOOT_PAGE_HOME"

// 当前选择城市的下级区域
#define kSelected_City_Area @"kSelected_City_Area"
//更新token
#define KUpdate_Token         @"updateToken"
#define KUpdate_Language         @"KUpdate_Language"

//网络状态发送变化
#define KUpdate_NetworkStatus  @"update_NetworkStatus"
//客户状态发生改变
#define kUpdateTaskListData  @"kUpdateTaskListData"
/// 定位页数据发生变化
#define klocationManagerChange  @"klocationManagerChange"


/// 首页筛选属性
#define kHomePageScreeningProperty_File  @"kHomePageScreeningProperty_File"
/// 装修版首页筛选属性
#define DEC_ScreeningProperty_File  @"DEC_ScreeningProperty_File"
///装修版首页header显示字段
#define DEC_Screening_HeaderStr @"DEC_Screening_HeaderStr"
#define DEC_Screening_RefreshNotification @"DEC_Screening_RefreshNotification"

/// 见客笔记筛选属性
#define kNoteScreeningProperty_File  @"kNoteScreeningProperty_File"
/// 见客笔记推荐筛选属性
#define kNoteRecommendScreeningProperty_File  @"kNoteRecommendScreeningProperty_File"
/// 发现模块的筛选
#define kDiscoverScreeningProperty_File  @"kDiscoverScreeningProperty_File"
/// 发现模块的搜索值
#define kDiscoverStr  @"kDiscoverStr"
///见客笔记历史记录
#define kNoteSearchLocationFile @"kNoteSearchLocationFile"
///发现搜索历史记录
#define kDiscoverSearchLocationFile @"kDiscoverSearchLocationFile"
/// 首页区域筛选属性
#define kHomePageScreeningAreaProperty_File  @"kHomePageScreeningAreaProperty_File"
/// 客户状态筛选属性
#define kHomePageEmployeeProperty_File  @"kHomePageEmployeeProperty_File"

#define kHotCityLocationFile @"kHotCityLocationFile"  //热门城市文件
#define kDomesticLocationFile @"kDomesticLocationFile"  //国内文件
// 当前选择的城市
#define kCurrentSelectedCityModelData @"kCurrentSelectedCityModelData"
#define KNotify_ChangeCity_Name @"KNotify_ChangeCity_Name"
#define KNotify_Update_MyTaskStatus @"KNotify_Update_MyTaskStatus"

//切换身份
#define KNotify_Switch_DecoOrAgent @"KNotify_Switch_DecoOrAgent"

//小喇叭消息类型
#define BARRAGETYPE @"house-index-broadcast"
// 小广播 定义
#define SMALLBROADCAST @"broadcast"
// 环信消息上传阿里云状态
#define MESSAGEOSSUPLOADSTATE @"ossMessageUpLoadState"




///  黑底
#define kBlackBacground [UIColor colorWithHexColorString:@"2b2b2b"]
///  白底
#define kwhiteBacground [UIColor colorWithHexColorString:@"ffffff"]
///  灰底
#define kGrayBacground [UIColor colorWithHexColorString:@"f2f2f2"]
///  灰底
#define kGrayZanBacground [UIColor colorWithHexColorString:@"999999"]
#define kGrayBacground_New rgb(238, 238, 238)

///  黑字
#define kBlackWord [UIColor colorWithHexColorString:@"333333"]
///  灰字
#define kGrayWord [UIColor colorWithHexColorString:@"666666"]
///  橙字
#define kOrangeWord [UIColor colorWithHexColorString:@"ff7711"]
///  白字
#define kWhiteWord [UIColor colorWithHexColorString:@"ffffff"]
///  亮黄
#define kYellowWord [UIColor colorWithHexColorString:@"ffc86a"]

///  导航栏字体颜色
#define kGrayWord_Nav [UIColor colorWithHexColorString:@"5c6368"]
///  透明
#define kClearBacground [UIColor clearColor]
///  随机色
#define kRandomColor [UIColor colorWithRed:(arc4random() % 256)/255.0 green:(arc4random() % 256)/255.0 blue:(arc4random() % 256)/255.0 alpha:1]


///分割线颜色
#define kSegmentingLineColor rgb(237, 237, 237)
///微黑
#define kSmallBlockWord [UIColor colorWithHexColorString:@"666666"]


///v442新占位图
#define kHomePageCarousel_Placeholder  [UIImage imageNamed:@"bannerPicNowifi"]


//微头条长图
#define kMicroHeadLongImage_Placeholder  [UIImage imageNamed:@"picVideo1"]
//楼盘详情长图
#define kBuildingLongImage_Placeholder  [UIImage imageNamed:@"home_buildingDetails"]
//正方形长图
#define kSquareImage_Placeholder  [UIImage imageNamed:@"SquareImage"]


/// cell 楼盘占位图
#define kBuilding_Placeholder  [UIImage imageNamed:@"picBuiliding"]
/// cell 广告主占位图
#define kAdvert_Placeholder  [UIImage imageNamed:@"picNowifi"]
/// 楼盘详情 大占位图
#define kBuildingDetails_Placeholder  [UIImage imageNamed:@"home_buildingDetails"]

/// 人头像占位图
#define kPerson_Placeholder  [UIImage imageNamed:@"myMorentouxiangIcon"]
/// 三人头像占位图
#define kThreePerson_Placeholder  [UIImage imageNamed:@"myMorentouxiangIcon"]

/// 更新圈子列表
#define kUpdate_Circle_Member  @"kUpdate_Circle_Member"
//更新圈子聊天页面的权限
#define kUpdate_Circle_GroupOnwer @"kUpdate_Circle_GroupOnwer"
/// 圈子聊天时更新圈子列表
#define kUpdate_ChatCircle_List  @"kUpdate_ChatCircle_List"
/// 更新圈子详情
#define kUpdate_Circle_Member_Detils  @"kUpdate_Circle_Member_Detils"
/// 更新圈子的未读数量
#define kUpdate_Circle_unread_Num  @"kUpdate_Circle_unread_Num"
/// 更新我的任务的未读数量
#define kUpdate_MyTask_unread_Num  @"kUpdate_MyTask_unread_Num"
/// 多设备登录
#define kLoginFromOtherDevice  @"kLoginFromOtherDevice"
/// 更改圈子名称
#define kUpdate_Circle_Name  @"kUpdate_Circle_Name"

///更新圈子成员数量
#define KUpdate_Circle_Member_count @"kUpdate_Add_Del_CircleMembers"
/// 更改我在圈子的昵称
#define kUpdate_Circle_NikeName  @"kUpdate_Circle_NikeName"

#endif /* RSDConfig_h */






























































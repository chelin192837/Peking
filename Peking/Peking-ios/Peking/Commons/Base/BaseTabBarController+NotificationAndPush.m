//
//  BaseTabBarController+NotificationAndPush.m
//  Agent
//
//  Created by wangliang on 2017/9/12.
//  Copyright © 2017年 七扇门. All rights reserved.
//
//#import "JPUSHService.h"
#import "BaseTabBar.h"
#import "BaseTabBarController+NotificationAndPush.h"
//#import "SDAddFriendsModel.h"
//两次提示的默认间隔
//static const CGFloat kDefaultPlaySoundInterval = 1.0;
static NSString *kMessageType = @"MessageType";
static NSString *kConversationChatter = @"ConversationChatter";
static NSString *kGroupName = @"GroupName";

@interface BaseTabBarController ()


@end

@implementation BaseTabBarController (NotificationAndPush)

//- (void)setupNotificationAndPush{
//
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUnreadMessageCount) name:@"setupUnreadMessageCount" object:nil];
////    [self setupUnreadMessageCount];
//    [self setupJpushNotifications];
//    [self analyticalPersonInfoData];
//}


#pragma mark - 设置环信推送通知事件

// #MARK: - 统计未读消息数
//-(void)setupUnreadMessageCount
//{
//    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
//
//    /// 环信未读消息数
//    NSInteger unreadTotalCount = 0;
//    /// 单聊未读消息数
//    NSInteger unreadChatCount = 0;
//    /// 群组聊天未读消息数
//    NSInteger unreadGroupCount = 0;
//
//    for (EMConversation *conversation in conversations) {
//        if (![conversation.conversationId isEqualToString:SMALLBROADCAST]) {
//            unreadTotalCount += conversation.unreadMessagesCount;
//        }
//        if (conversation.type == EMConversationTypeChat) {
//            if ([conversation.conversationId isEqualToString:SMALLBROADCAST]) {
//                continue;
//            }
//            unreadChatCount += conversation.unreadMessagesCount;
//        }
//        if (conversation.type == EMConversationTypeGroupChat) {
//            if ([[ChatDemoHelper shareHelper] getNewMessageNotificationStatus:conversation.conversationId chatType:EMChatTypeGroupChat]) {
//                unreadGroupCount += conversation.unreadMessagesCount;
//            }
//        }
//    }
//    self.unreadGroupCount = unreadGroupCount;
////    //消息显示未读总数 单聊加群聊
//    /// 设置单聊未读消息数
//    BaseTabBar *tempTabbar = (id)self.tabBar;
//    if (unreadTotalCount > 0) {//unreadTotalCount unreadChatCount
//        tempTabbar.messageRedPoint.hidden = NO;
//        if (unreadTotalCount > 99) {//unreadTotalCount unreadChatCount
//            tempTabbar.messageRedPoint.text = @"99";
//            tempTabbar.messageRedPoint.frame = CGRectMake(Kscale*267, 5, 22, 14);
//        }else{
////            tempTabbar.messageRedPoint.text = [NSString stringWithFormat:@"%zd",unreadChatCount];
//            tempTabbar.messageRedPoint.text = [NSString stringWithFormat:@"%zd",unreadTotalCount];
//            if (tempTabbar.messageRedPoint.text.length > 1) {
//                tempTabbar.messageRedPoint.frame = CGRectMake(Kscale*267, 5, 18, 14);
//            }else{
//                tempTabbar.messageRedPoint.frame = CGRectMake(Kscale*267, 5, 14, 14);
//            }
//        }
//    }else{
//        tempTabbar.messageRedPoint.hidden = YES;
//    }
//
//    /// 设置群组聊天未读消息数
//    if (unreadGroupCount > 0) {
//        if (unreadGroupCount > 99) {
//            [[NSNotificationCenter defaultCenter] postNotificationName:kUpdate_Circle_unread_Num object:@"99+"];
//        }else{
//            [[NSNotificationCenter defaultCenter] postNotificationName:kUpdate_Circle_unread_Num object:[NSString stringWithFormat:@"%zd",unreadGroupCount]];
//        }
//    }else{
//        [[NSNotificationCenter defaultCenter] postNotificationName:kUpdate_Circle_unread_Num object:@"0"];
//    }
//    if (unreadTotalCount > 99) {//unreadTotalCount unreadChatCount
//        unreadTotalCount = 99;//unreadTotalCount unreadChatCount
//    }
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:unreadTotalCount];//unreadTotalCount unreadChatCount
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"myGroupChat" object:nil];
//}
//
//- (void)playSoundAndVibration{
//    NSTimeInterval timeInterval = [[NSDate date]
//                                   timeIntervalSinceDate:self.lastPlaySoundDate];
//    if (timeInterval < kDefaultPlaySoundInterval) {
//        //如果距离上次响铃和震动时间太短, 则跳过响铃
//        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
//        return;
//    }
//    //保存最后一次响铃时间
//    self.lastPlaySoundDate = [NSDate date];
//    // 收到消息时，播放音频
//    [[EMCDDeviceManager sharedInstance] playNewMessageSound];
//    // 收到消息时，震动
//    [[EMCDDeviceManager sharedInstance] playVibration];
//}

//- (void)showNotificationWithMessage:(EMMessage *)message
//{
//    EMPushOptions *options = [[EMClient sharedClient] pushOptions];
//    options.displayStyle = EMPushDisplayStyleMessageSummary;
//
//    if (options.displayStyle == EMPushDisplayStyleMessageSummary) {
//        EMMessageBody *messageBody = message.body;
//        NSString *messageStr = nil;
//        switch (messageBody.type) {
//            case EMMessageBodyTypeText:
//            {
//                NSString *text = ((EMTextMessageBody *)messageBody).text;
//                if ([message.ext objectForKey:@"s_type"]) {
//                    messageStr =  @"发来了一个红包";
//                }else if ([text containsString:@"[七扇门红包]"]){//打招呼红包
//                    messageStr =  text;
//                }else if ([text rangeOfString:@"["].location != NSNotFound && [text rangeOfString:@"]"].location != NSNotFound) {
//                    messageStr =  @"发来了一个表情";
//                } else {
//                    messageStr = text.length > 20 ? [text substringToIndex:20] : text;
//                }
//            }
//                break;
//            case EMMessageBodyTypeImage:
//            {
//                messageStr = @"发来了一个图片";
//            }
//                break;
//            case EMMessageBodyTypeLocation:
//            {
//                messageStr = @"发来了一个位置";
//            }
//                break;
//            case EMMessageBodyTypeVoice:
//            {
//                messageStr = @"发来了一段语音";
//            }
//                break;
//            case EMMessageBodyTypeVideo:{
//                messageStr = @"发来了一段视频";
//            }
//                break;
//            case EMMessageBodyTypeFile:{
//                messageStr = @"发来了一个文件";
//            }
//                break;
//            default:
//                break;
//        }
////        do {
////            NSString *title = [[UserProfileManager sharedInstance] getNickNameWithUsername:message.from];
////            if (message.chatType == EMChatTypeGroupChat) {
////                NSDictionary *ext = message.ext;
////                if (ext && ext[kGroupMessageAtList]) {
////                    id target = ext[kGroupMessageAtList];
////                    if ([target isKindOfClass:[NSString class]]) {
////                        if ([kGroupMessageAtAll compare:target options:NSCaseInsensitiveSearch] == NSOrderedSame) {
////                            self.alertBody = [NSString stringWithFormat:@"%@%@", title, NSLocalizedString(@"group.atPushTitle", @" @ me in the group")];
////                            break;
////                        }
////                    }
////                    else if ([target isKindOfClass:[NSArray class]]) {
////                        NSArray *atTargets = (NSArray*)target;
////                        if ([atTargets containsObject:[EMClient sharedClient].currentUsername]) {
////                            self.alertBody = [NSString stringWithFormat:@"%@%@", title, NSLocalizedString(@"group.atPushTitle", @" @ me in the group")];
////                            break;
////                        }
////                    }
////                }
////                NSArray *groupArray = [[EMClient sharedClient].groupManager getJoinedGroups];
////                for (EMGroup *group in groupArray) {
////                    if ([group.groupId isEqualToString:message.conversationId]) {
////                        title = [NSString stringWithFormat:@"%@(%@)", message.from, group.subject];
////                        break;
////                    }
////                }
////            }
////            else if (message.chatType == EMChatTypeChatRoom)
////            {
////                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
////                NSString *key = [NSString stringWithFormat:@"OnceJoinedChatrooms_%@", [[EMClient sharedClient] currentUsername]];
////                NSMutableDictionary *chatrooms = [NSMutableDictionary dictionaryWithDictionary:[ud objectForKey:key]];
////                NSString *chatroomName = [chatrooms objectForKey:message.conversationId];
////                if (chatroomName)
////                {
////                    title = [NSString stringWithFormat:@"%@(%@)", message.from, chatroomName];
////                }
////            }
////
////            self.alertBody = [NSString stringWithFormat:@"%@:%@", title, messageStr];
////        } while (0);
//
//        if (message.chatType == EMChatTypeGroupChat) {
//            NSArray *groupArray = [[EMClient sharedClient].groupManager getJoinedGroups];
//            for (EMGroup *group in groupArray) {
//                if ([group.groupId isEqualToString:message.conversationId]) {
//                    break;
//                }
//            }
//        }
//        else if (message.chatType == EMChatTypeChatRoom)
//        {
//            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//            NSString *key = [NSString stringWithFormat:@"OnceJoinedChatrooms_%@", [[EMClient sharedClient] currentUsername]];
//            NSMutableDictionary *chatrooms = [NSMutableDictionary dictionaryWithDictionary:[ud objectForKey:key]];
//            NSString *chatroomName = [chatrooms objectForKey:message.conversationId];
//            if (chatroomName)
//            {
//                //  title = [NSString stringWithFormat:@"%@(%@)", message.from, chatroomName];
//            }
//        }
//
//        if ([message.from isEqualToString:@"admin"]) {
//            self.alertBody = [NSString stringWithFormat:@"系统通知消息:%@", messageStr];
//        }
//        if ([message.from isEqualToString:@"friend"]) {
//            self.alertBody = [NSString stringWithFormat:@"好友验证消息:%@", messageStr];
//        }
//        if ([message.from isEqualToString:@"comment"]) {
//            self.alertBody = [NSString stringWithFormat:@"新的动态:%@", messageStr];
//        }
//        if ([message.from isEqualToString:@"greet"]) {
//            self.alertBody = [NSString stringWithFormat:@"打招呼:%@", messageStr];
//        }
////        WEAK_SELF
////        [SDAddFriendsModel getModelFromFMDBWithPhone:message.from andCompleteBlock:^(SDAddFriendsModel *model) {
////            weakSelf.alertBody = [NSString stringWithFormat:@"%@:%@", model.stage_name, messageStr];
////        }];
//
//    }else{
//        self.alertBody = @"您有一条新消息";
////        if (![message.from isEqualToString:SMALLBROADCAST]) {
////            [self setupLocalNotification:message];
////        }
//    }
//    // 小广播远程推送不显示
//    if (![message.from isEqualToString:SMALLBROADCAST]) {
//        [self setupLocalNotification:message];
//    }
//}

//- (void)setupLocalNotification:(EMMessage *)message{
//    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.lastPlaySoundDate];
//    BOOL playSound = NO;
//    if (!self.lastPlaySoundDate || timeInterval >= kDefaultPlaySoundInterval) {
//        self.lastPlaySoundDate = [NSDate date];
//        playSound = YES;
//    }
//    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
//    [userInfo setObject:[NSNumber numberWithInt:message.chatType] forKey:kMessageType];
//    [userInfo setObject:message.conversationId forKey:kConversationChatter];
//    //发送本地推送
//    if (NSClassFromString(@"UNUserNotificationCenter")) {
//        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:0.01 repeats:NO];
//        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
//        if (playSound) {
//            content.sound = [UNNotificationSound defaultSound];
//        }
//        content.body = self.alertBody;
//        content.userInfo = userInfo;
//        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:message.messageId content:content trigger:trigger];
//        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:nil];
//    } else {
//        UILocalNotification *notification = [[UILocalNotification alloc] init];
//        notification.fireDate = [NSDate date]; //触发通知的时间
//        notification.alertBody = self.alertBody;
//        notification.alertAction = NSLocalizedString(@"open", @"Open");
//        notification.timeZone = [NSTimeZone defaultTimeZone];
//        if (playSound) {
//            notification.soundName = UILocalNotificationDefaultSoundName;
//        }
//        notification.userInfo = userInfo;
//        //发送通知
//        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
//    }
//}
// #MARK: - 设置极光推送通知事件
//- (void) setupJpushNotifications
//{
//    NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
//    NSString *app_uid = [standard objectForKey:APPID];
////    NSString *alias = [NSString stringWithFormat:@"%@", app_uid];
//
//    //***** 设置用户Tag和Alias ******
//    if (app_uid) {
//        NSSet *tags = [NSSet setWithObject:JPUSHTAG];
////        NSSet *nilTags = [[NSSet alloc]init];
//        //        [JPUSHService setTags:nilTags aliasInbackground:@""];
//        //        [JPUSHService setTags:tags aliasInbackground:alias];
////        [JPUSHService setTags:tags completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
////            NSLog(@"iResCode:%ld", (long)iResCode);
////        } seq:app_uid.integerValue];
//    }

//    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
//    [defaultCenter addObserver:self
//                      selector:@selector(networkDidSetup:)
//                          name:kJPFNetworkDidSetupNotification
//                        object:nil];
//    [defaultCenter addObserver:self
//                      selector:@selector(networkDidClose:)
//                          name:kJPFNetworkDidCloseNotification
//                        object:nil];
//    [defaultCenter addObserver:self
//                      selector:@selector(networkDidRegister:)
//                          name:kJPFNetworkDidRegisterNotification
//                        object:nil];
//    [defaultCenter addObserver:self
//                      selector:@selector(networkDidLogin:)
//                          name:kJPFNetworkDidLoginNotification
//                        object:nil];
//    [defaultCenter addObserver:self
//                      selector:@selector(networkDidReceiveMessage:)
//                          name:kJPFNetworkDidReceiveMessageNotification
//                        object:nil];
//    [defaultCenter addObserver:self
//                      selector:@selector(serviceError:)
//                          name:kJPFServiceErrorNotification
//                        object:nil];
//}

//// #MARK: - 极光推送事件回调
//- (void)networkDidSetup:(NSNotification *)notification {
//    NSLog(@"已连接JPSH");
//}
//
//- (void)networkDidClose:(NSNotification *)notification {
//    NSLog(@"未连接JPUSH");
//}
//
//- (void)networkDidRegister:(NSNotification *)notification {
//    NSLog(@"%@", [notification userInfo]);
//    NSLog(@"已注册JPUSH");
//}
//
//- (void)networkDidLogin:(NSNotification *)notification {
//    NSLog(@"已登录JPUSH");
//}
//
//// #MARK: -
//- (void)networkDidReceiveMessage:(NSNotification *)notification {
//    NSDictionary *userInfo = [notification userInfo];
//    NSString *title = [userInfo valueForKey:@"title"];
//    NSString *content = [userInfo valueForKey:@"content"];
////    NSString *content_type = [userInfo valueForKey:@"content_type"];
//    NSDictionary *extra = [userInfo valueForKey:@"extras"];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//
//    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
//
//    NSString *timeString = [extra[@"timestamp"] stringValue];
//
//    NSString *currentContent = [NSString
//                                stringWithFormat:
//                                @"JPUSH收到自定义消息:%@\ntitle:%@\ncontent:%@\nextra:%@\n",
//                                [NSDateFormatter localizedStringFromDate:[NSDate date]
//                                                               dateStyle:NSDateFormatterNoStyle
//                                                               timeStyle:NSDateFormatterMediumStyle],
//                                title, content, extra];
////    NSLog(@"[JPUSH] %@", currentContent);
////    NSLog(@"[JPUSH time] %@", timeString);
//    if ([[extra objectForKey:@"type"] isEqualToString:BARRAGETYPE]) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:BARRAGETYPE object:userInfo];
//    }
//
//}
// #MARK: - 移除极光推送通知事件
//- (void) unObserveAllNotifications
//{
//    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
//    [defaultCenter removeObserver:self
//                             name:kJPFNetworkDidSetupNotification
//                           object:nil];
//    [defaultCenter removeObserver:self
//                             name:kJPFNetworkDidCloseNotification
//                           object:nil];
//    [defaultCenter removeObserver:self
//                             name:kJPFNetworkDidRegisterNotification
//                           object:nil];
//    [defaultCenter removeObserver:self
//                             name:kJPFNetworkDidLoginNotification
//                           object:nil];
//    [defaultCenter removeObserver:self
//                             name:kJPFNetworkDidReceiveMessageNotification
//                           object:nil];
//    [defaultCenter removeObserver:self
//                             name:kJPFServiceErrorNotification
//                           object:nil];
//}

- (void)dealloc {
//    [self unObserveAllNotifications];
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark -- 个人信息页面-1020
//#MARK: 个人信息页面-1020
- (void)analyticalPersonInfoData
{
//    [[RSDMineInterfaceService sharedInstance] analyticalMineData_1020:nil serverSuccessResultHandler:^(id response) {
//        SDPersonalInfoResponse *responseModel = (SDPersonalInfoResponse *)response;
//        SDPersonalModel *dataModel = responseModel.data;
//        [[NSUserDefaults standardUserDefaults] setObject:dataModel.status forKey:STATUS];
//        [[NSUserDefaults standardUserDefaults] setObject:dataModel.bind_status forKey:STATUSCARD];
//        [[NSUserDefaults standardUserDefaults] setObject:dataModel.decorator_status forKey:DECORATOR_STATUS];
//        [[NSUserDefaults standardUserDefaults] setObject:dataModel.decorator_identity forKey:DECORATOR_IDENTITY];
//        [[NSUserDefaults standardUserDefaults] setObject:dataModel.decorator_company_id forKey:DEC_MYCOMPANY_ID];
//        [[NSUserDefaults standardUserDefaults] setObject:dataModel.decorator_company_name forKey:DEC_MYCOMPANY_NAME];
//        [[NSUserDefaults standardUserDefaults] setObject:dataModel.is_counselor forKey:ISCONSULTANT];
//        [[NSUserDefaults standardUserDefaults] setObject:dataModel.favicon forKey:FAVICON];
//        [[NSUserDefaults standardUserDefaults] setObject:dataModel.is_show_task forKey:ISSHOWTASK];
//        [[NSUserDefaults standardUserDefaults] setObject:dataModel.is_show_ad forKey:ISSHOW_AD_BUYER];
//        [[NSUserDefaults standardUserDefaults] setObject:dataModel.is_show_ad_message forKey:ISSHOW_INVITEAGENT];
//        [[NSUserDefaults standardUserDefaults] setObject:dataModel.is_show_ad_dec forKey:ISSHOW_INVITEAGENT_DES];
//        [[NSUserDefaults standardUserDefaults] setObject:dataModel.stage_name forKey:STAGENAME];
//        [[NSUserDefaults standardUserDefaults] setObject:dataModel.level forKey:BROKELEVEL];
//        [[NSUserDefaults standardUserDefaults] setObject:dataModel.name forKey:REALNAME];
//        [[NSUserDefaults standardUserDefaults] setObject:dataModel.is_show_red forKey:SHOWMYTASKRED];
//        [[NSUserDefaults standardUserDefaults] setObject:dataModel.phone forKey:USERINFOPHONENUMBER];
//        [[NSUserDefaults standardUserDefaults] setObject:dataModel.self_invite forKey:INVITE];
//        [[NSUserDefaults standardUserDefaults] setObject:dataModel.phone forKey:BROKEPHONE];
//        //仅在此处传isShowAlert
//        [[NSNotificationCenter defaultCenter] postNotificationName:kNSBOOT_PAGE_HOME object:@"isShowAlert"];
////        [SDPersonalModel getModelFromFMDBWithPhone:dataModel.phone andCompleteBlock:^(SDPersonalModel *personalModel) {
////
////        }];
//        [SDPersonalModel updateModelFromFMDBWithPhone:dataModel.phone andCompleteBlock:^(SDPersonalModel *model) {
//        }];
//    } failedResultHandler:nil requestErrorHandler:nil];
}


@end





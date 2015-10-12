//
//  YouMiPointsManager.h
//  YouMiSDK
//
//  Created by ENZO YANG on 13-4-25.
//  Copyright (c) 2013年 YouMi Mobile Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

// !!!！重要!!!! Important !!!!
// [自动积分管理]及[手动积分管理]的概念请查看文档

// [自动积分管理][手动积分管理]通用
// 获得积分通知, userInfo 格式如下, 建议收到积分通知后打印userInfo观察一下里面的结构。
// @{ kYouMiPointsManagerFreshPointsKey: @210,
//    kYouMiPointsManagerPointInfosKey: @[
//      @{
//          kYouMiPointsManagerPointUserIDKey: @"user10086",
//          kYouMiPointsManagerPointAmountKey: @100,
//          kYouMiPointsManagerPointProductNameKey: @"WY新闻"
//      },
//      ...
//    ]
// }
extern NSString *const kYouMiPointsManagerRecivedPointsNotification;


// 使用下面这个 key 从 Notification userInfo 中获得积分 [适用于自动积分管理]
// 不要消耗从这个Key获取到的积分，如果使用自动积分管理请使用[YouMiPointsManager spendPoints:]来消耗积分
extern NSString *const kYouMiPointsManagerFreshPointsKey;

// 获得每一份积分的相关信息的列表 [适用于手动积分管理]
extern NSString *const kYouMiPointsManagerPointInfosKey;

// 获得获得积分的用户，对应[YouMiConfig setUserID:]
extern NSString *const kYouMiPointsManagerPointUserIDKey;

// 获得这一份积分的数量
extern NSString *const kYouMiPointsManagerPointAmountKey;

// 获得积分来源，比如下载安装了 WY新闻 则这份积分来自 WY新闻
extern NSString *const kYouMiPointsManagerPointProductNameKey;

@interface YouMiPointsManager : NSObject

/////////////// 自动积分管理 ///////////////

// 开启自动积分管理
// YouMiSDK从服务器接收到积分后会把积分存起来，开发者需要使用[YouMiPointsManager spendPoints:]来消耗积分，还有自动积分管理相关参数
+ (void)enable;

// [自动积分管理]使用积分, 积分不足时返回NO 
+ (BOOL)spendPoints:(NSUInteger)points;

// [自动积分管理]奖励积分, 不会发送 Notification, 如果整型越界则返回NO 
+ (BOOL)rewardPoints:(NSUInteger)points;

// [自动积分管理]剩余积分
///调用了这个函数后记得free()一下返回值的指针
+ (int *)pointsRemained;


/////////////// 手动积分管理 ///////////////

// 开启手动积分管理。
+ (void)enableManually;

//[手动查询积分] 查询积分。使用手动查询积分依然需要监听kYouMiPointsManagerRecivedPointsNotification，在这个nitification中拿积分
+ (void)checkPoints;

//如果要手动查询积分，传YES。
//自动查询积分，传NO。
//不设置，默认是自动查询积分
+ (void)setManualCheck:(BOOL)manualCheck;
@end

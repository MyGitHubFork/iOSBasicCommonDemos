//
//  YouMiFeaturedAppModel.h
//  YouMiSDK
//
//  Created by Layne on 12-01-05.
//  Copyright (c) 2012年 YouMi Mobile Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YouMiWallAppModel : NSObject<NSCopying>

/*
 * 以下id类型属性的值保证不为nil，有可能为@""
 */

// 该开放源应用的标示
@property(nonatomic, retain, readonly)    NSString    *storeID;

// 应用名称
@property(nonatomic, retain, readonly)    NSString    *name;

// 应用的类别
@property(nonatomic, retain, readonly)    NSString    *category;

// 应用的详细描述
@property(nonatomic, retain, readonly)    NSString    *desc;

// 应用版权所有者
@property(nonatomic, retain, readonly)    NSString    *author;

// 应用的大小
@property(nonatomic, retain, readonly)    NSString    *size;

// 应用的小图标
@property(nonatomic, retain, readonly)    NSString    *smallIconURL;

// 应用的大图标
@property(nonatomic, retain, readonly)    NSString    *largeIconURL;

// 简短广告词
@property(nonatomic, retain, readonly)    NSString    *adText;

//提示语（例如：首次安装并创建新角色获取积分）
@property(nonatomic, retain, readonly)     NSString   *task_brief;

//步骤提示（例如：打开游戏创建新角色并体验3分钟 回到本应用即可获取{积分单位}）
@property(nonatomic, retain, readonly)     NSString   *task_steps;

// 过期时间
@property(nonatomic, retain, readonly)    NSDate      *expiredDate;

// 积分值[该值对有积分应用有效，无积分应用默认为0]。。已经完成的任务，points也会为0
@property(nonatomic, assign, readonly)    NSInteger   points;

//appStoreID
@property(nonatomic, assign, readonly)     NSInteger    appStoreID;

//appStoreURL
@property(nonatomic, retain, readonly)     NSString    *linkURL;
@end

//
//  YouMiConfig.h
//  YouMiSDK
//
//  Created by Layne on 12-5-2.
//  Copyright (c) 2012年 YouMi Mobile Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YouMiConfig : NSObject

+ (void)launchWithAppID:(NSString *)appid appSecret:(NSString *)secret;
// 应用ID
//
// 详解:
//      前往有米主页:http://www.youmi.net/ 注册一个开发者帐户，同时注册一个应用，获取对应应用的ID
//
+ (void)setAppID:(NSString *)appid;
+ (NSString *)appID;

// 安全密钥
//
// 详解:
//      前往有米主页:http://www.youmi.net/ 注册一个开发者帐户，同时注册一个应用，获取对应应用的安全密钥
//
+ (void)setAppSecret:(NSString *)secret;
+ (NSString *)appSecret;

//对于在线参数的请求，我们采用的是同步请求的方式
//设置在线参数请到http://www.youmi.net/ 网站上。广告设置->在线参数设置
+ (id)onlineValueForKey:(NSString *)key;

/*! 设置全屏广告显示在的window [建议设置]
 *
 *! 使用原生ObjectiveC代码的APP, 可以在[AppDelegate application:didFinishLaunchingWithOptions:]里[self.window makeKeyAndVisible];后设置[YouMiConfi setFullScreenWindow:self.window];
 *
 *! Unity3D的window代码比较隐藏得比较深，可以不设置
 *
 *! Cocos2d-x 可以在[AppController application:didFinishLaunchingWithOptions:]里[window makeKeyAndVisible];后设置[YouMiConfi setFullScreenWindow:window];
 *
 * \params window APP的主window，一般情况下每个APP有且只有一个window，在APP启动完成后生成，覆盖整个屏幕，所有视图都放在它里面.
 */
+ (void)setFullScreenWindow:(UIWindow *)window;

// 设置应用发布的渠道号
//
// 详解:
//      该参数主要用于标识应用发布的渠道
//
// 补充:
//      如果你发布到App Store可以设置[YouMiConfig setChannelID:100 description:@"App Store"]
//
+ (void)setChannelID:(NSInteger)channel description:(NSString *)desc;
+ (NSInteger)channelID;
+ (NSString *)channelDesc;

// 设置UserID
//
// 详解:
//      可用于服务器对接获取积分
//      详情请看：http://wiki.youmi.net/%E5%AF%B9%E5%BC%80%E5%8F%91%E8%80%85%E7%9A%84%E7%A7%AF%E5%88%86%E5%8F%8D%E9%A6%88%E6%8E%A5%E5%8F%A3
//
+ (void)setUserID:(NSString *)userID;
+ (NSString *)userID;

// 请求模式
//
// 详解:
//     默认->模拟器@YES 真机器@NO
//
// 备注:
//     如果YES  Banner 将显示测试广告
//
+ (void)setIsTesting:(BOOL)flag;
+ (BOOL)isTesting;

// 统计定位请求
// Default:
//      @YES
// 详解:
//      返回是否允许使用GPS定位用户所在的坐标，目前开参数主要用于帮助推送消息的时候选择地区推送
//
+ (void)setShouldGetLocation:(BOOL)flag;
+ (BOOL)shouldGetLocation;

// 是否在iOS6设备上使用iOS6新特性 SKStoreProductViewController 来安装APP
// Default:
//      @YES
// 详解:
//      如果YES，则在APP没通过 appstore 发布之前没法从 SKStoreProductViewController 中下载安装APP.
//      可以在测试期间设置为 NO, 上传到 appstore 前设置为 YES.
//
+ (void)setUseInAppStore:(BOOL)flag;
+ (BOOL)useInAppStore;


//设置货币单位，默认是金币
+ (void)setUnitName:(NSString *)name;
@end

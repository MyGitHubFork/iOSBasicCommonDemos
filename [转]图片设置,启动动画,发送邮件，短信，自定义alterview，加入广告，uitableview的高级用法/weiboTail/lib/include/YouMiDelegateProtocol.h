//
//  YouMiDelegateProtocol.h
//  YouMiSDK
//
//  Created by Layne on 10-8-31.
//  Copyright 2010 YouMi Mobile Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YouMiView;

@protocol YouMiDelegate <NSObject>

@optional

#pragma mark Ad Request Notification Methods

// Send after successfully receive ad data from server
// p.s. send after the first successful request
//
// 请求广告条数据成功后调用 
// 
// 详解:
//      当接收服务器返回的广告数据成功后调用该方法
// 补充:
//      第一次返回成功数据后调用
//
- (void)didReceiveAd:(YouMiView *)adView;

// Send after fail to receive ad data from server
// p.s. send after the first failed request and every following failed request
//
// 请求广告条数据失败后调用
// 
// 详解:
//      当接收服务器返回的广告数据失败后调用该方法
// 补充:
//      第一次和接下来每次如果请求失败都会调用该方法
// 
- (void)didFailToReceiveAd:(YouMiView *)adView  error:(NSError *)error;

#pragma mark Click-Time Notifications Methods

// Send before presenting the full screen view
//
// 将要显示全屏广告前调用
// 
// 详解:
//      将要显示一次全屏广告内容前调用该方法
// 
- (void)willPresentScreen:(YouMiView *)adView;

// Send after presenting the full screen view
//
// 显示全屏广告成功后调用
// 
// 详解:
//      显示一次全屏广告内容后调用该方法
// 
- (void)didPresentScreen:(YouMiView *)adView;

// Send before dismiss the full screen view
//
// 将要关闭全屏广告前调用
// 
// 详解:
//      全屏广告将要关闭前调用该方法
// 
- (void)willDismissScreen:(YouMiView *)adView;

// Send after sucessful dismiss the full screen view
//
// 成功关闭全屏广告后调用
// 
// 详解:
//      全屏广告显示完成，关闭全屏广告后调用该方法
// 
- (void)didDismissScreen:(YouMiView *)adView;

@end

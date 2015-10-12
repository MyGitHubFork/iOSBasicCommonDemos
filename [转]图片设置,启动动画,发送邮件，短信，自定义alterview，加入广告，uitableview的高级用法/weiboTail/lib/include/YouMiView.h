//
//  YouMiView.h
//  YouMiSDK
//
//  Created by Layne on 10-8-31.
//  Copyright 2010 YouMi Mobile Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "YouMiDelegateProtocol.h"
#import "YouMiConfig.h"


typedef enum {
    YouMiBannerContentSizeIdentifier320x50     = 1, // iPhone and iPod Touch ad size
    YouMiBannerContentSizeIdentifier200x200    = 2, // Minimum Rectangle size for the iPad
    YouMiBannerContentSizeIdentifier300x250    = 3, // Medium Rectangle size for the iPad (especially in a UISplitView's left pane
    YouMiBannerContentSizeIdentifier468x60     = 4, // Full Banner size for the iPad (especially in a UIPopoverController or in UIModalPresentationFormSheet)
    YouMiBannerContentSizeIdentifier728x90     = 5, // Leaderboard size for the iPad
} YouMiBannerContentSizeIdentifier;


@protocol YouMiDelegate;


@interface YouMiView : UIView

+ (YouMiView *)adViewWithContentSizeIdentifier:(YouMiBannerContentSizeIdentifier)contentSizeIdentifier delegate:(id<YouMiDelegate>)delegate;

- (id)initWithContentSizeIdentifier:(YouMiBannerContentSizeIdentifier)contentSizeIdentifier delegate:(id<YouMiDelegate>)delegate;

// Start requesting banner ad
// 开始请求广告
//
// 详解:
//      若想停用定位请求
//      则在开始广告请求前请先调用 YouMiConfig 的 + (void)setShouldGetLocation:(BOOL)flag 
//
- (void)start;

// The size of banner
// YouMiBannerContentSizeIdentifier320x50   --> CGSizeMake(320, 50)
// YouMiBannerContentSizeIdentifier200x200  --> CGSizeMake(200, 200)
// YouMiBannerContentSizeIdentifier300x250  --> CGSizeMake(300, 250)
// YouMiBannerContentSizeIdentifier468x60   --> CGSizeMake(468, 60)
// YouMiBannerContentSizeIdentifier728x90   --> CGSizeMake(728, 90)
// 
// 广告条的尺寸 
//
@property(nonatomic, assign, readonly)          YouMiBannerContentSizeIdentifier contentSizeIdentifier;

// Delegate
//
// 委托
//
@property(nonatomic, assign)                                id<YouMiDelegate> delegate;

// Indicate banner border
// @YES
// YES->banner with white frame
// No->Banner without white frame
//
// 广告条边框
// Default:
//      @YES
// 详解:
//      YES->广告条将会显示白色边框
//      NO->广告条去掉默认白色边框
//
@property(nonatomic, assign, getter=isIndicateBorder)       BOOL indicateBorder;

// Indicate banner trasparency
// @YES
// YES->banner with trasparency effect
// No->banner without transparency effect
// 
// 广告条透明效果
// Default:
//      @YES
// 详解:
//      YES->广告条显示透明效果
//      NO->广告条取消默认透明效果
//
@property(nonatomic, assign, getter=isIndicateTranslucency) BOOL indicateTranslucency;

// Indicate banner round corner
// @YES
// YES-> banner with round corner effect
// NO->banner without round corner effect
//
// 广告条圆角
// Default:
//      @YES
// 详解:
//      YES->广告条显示圆角效果
//      NO->广告条无圆角
// 
@property(nonatomic, assign, getter=isIndicateRounded)      BOOL indicateRounded;

// Background color of text banner ad
// @{64/255.0, 118/255.0, 170/255.0, 1.0}
// 
// 背景颜色
// 详解:
//      文字广告广告条的背景颜色
// 
@property(nonatomic, retain) UIColor *indicateBackgroundColor;

// Title color of text banner ad
// @{255/255.0, 255/255.0, 255/255.0, 1.0}
//
// 主标题颜色
// 详解:
//      文字广告主标题的颜色
// 
@property(nonatomic, retain) UIColor *textColor;

// Sub-title color of text banner ad
// @{255/255.0, 255/255.0, 255/255.0, 1.0}
//
// 副标题颜色
// 详解:
//      文字广告的副标题的颜色
// 
@property(nonatomic, retain) UIColor *subTextColor;

// Key words
// to match with ad data, encourge users to review ads
// 
// 添加关键字
// 
// 详解:
//      用于精准匹配广告数据，增强用户点击广告的概念
// 
- (void)addKeyword:(NSString *)keyword;

@end

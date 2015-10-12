//
//  AppDelegate.h
//  URLSession
//
//  Created by Kenshin Cui on 14-03-23.
//  Copyright (c) 2014年 Kenshin Cui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (copy, nonatomic) void (^backgroundSessionCompletionHandler)();

@end


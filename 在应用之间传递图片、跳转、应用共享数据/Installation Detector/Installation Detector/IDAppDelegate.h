//
//  IDAppDelegate.h
//  Installation Detector
//
//  Copyright (c) 2012 John Szumski. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IDViewController;

@interface IDAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) IDViewController *viewController;

@end
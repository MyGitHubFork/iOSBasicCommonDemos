//
//  ZLibDemoAppDelegate.h
//  ZLibDemo
//
//  Created by  JM on 11-1-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZLibDemoViewController;

@interface ZLibDemoAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ZLibDemoViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ZLibDemoViewController *viewController;

@end


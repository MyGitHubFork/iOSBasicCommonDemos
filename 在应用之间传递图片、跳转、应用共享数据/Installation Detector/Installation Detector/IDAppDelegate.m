//
//  IDAppDelegate.m
//  Installation Detector
//
//  Copyright (c) 2012 John Szumski. All rights reserved.
//

#import "IDAppDelegate.h"
#import "IDViewController.h"

@implementation IDAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

	self.viewController = [[IDViewController alloc] initWithNibName:@"IDViewController" bundle:nil];
	self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
	
    return YES;
}

@end
//
//  IAAppDelegate.m
//  Employee Records Image Adder
//
//  Copyright (c) 2012 John Szumski. All rights reserved.
//

#import "IAAppDelegate.h"

#import "IAViewController.h"

@implementation IAAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

	self.viewController = [[IAViewController alloc] initWithNibName:@"IAViewController" bundle:nil];
	self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
	
    return YES;
}

@end
//
//  EDAppDelegate.m
//  Employee Directory
//
//  Copyright (c) 2012 John Szumski. All rights reserved.
//

#import "EDAppDelegate.h"
#import "EDDirectoryViewController.h"
#import "EDEmployeeViewController.h"
#import "EDEmployee.h"
#import "EDEmployeeManager.h"
#import "SSOUtils.h"
#import "EDLoginViewController.h"

@interface EDAppDelegate()

- (BOOL)canHandleURL:(NSURL*)url fromSourceApplication:(NSString*)sourceApplication withAnnotation:(id)annotation;
- (NSInteger)employeeNumberFromURL:(NSURL*)url;

@end


@implementation EDAppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

	// create our nav controller and root view
	EDDirectoryViewController *directoryVC = [[EDDirectoryViewController alloc] initWithNibName:@"EDDirectoryViewController" bundle:nil];
	self.navigationController = [[UINavigationController alloc] initWithRootViewController:directoryVC];
	[self.navigationController setToolbarHidden:NO];
	self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
	
	// fetch the URL, source application, and annotation that launched us, if any
	NSURL *url = [launchOptions objectForKey:UIApplicationLaunchOptionsURLKey];
	NSString *sourceApplication = [launchOptions objectForKey:UIApplicationLaunchOptionsSourceApplicationKey];
	id annotation = [launchOptions objectForKey:UIApplicationLaunchOptionsAnnotationKey];
	
    return [self canHandleURL:url fromSourceApplication:sourceApplication withAnnotation:annotation];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	// check for an SSO token
	if ([SSOUtils credentialsAreValid] == NO) {
		EDLoginViewController *loginVC = [[EDLoginViewController alloc] init];
		[self.navigationController presentModalViewController:[[UINavigationController alloc] initWithRootViewController:loginVC] animated:YES];
	}
}
			
			
#pragma mark - URL Handling

- (NSInteger)employeeNumberFromURL:(NSURL*)url {
	NSArray *pathComponents = [url pathComponents];
	
	// return if we got a URL that was too short
	if ([pathComponents count] < 2) {
		return 0;
	}
	
	// the 0th component is the leading "/", the employee number is the 1st component
	NSString *employeeNumberComponent = [[pathComponents objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	return [employeeNumberComponent intValue];
}

- (BOOL)canHandleURL:(NSURL *)url fromSourceApplication:(NSString *)sourceApplication withAnnotation:(id)annotation {
	// we're only requiring a URL, but we could also check sourceApplication or annotation if necessary
	if (url == nil) {
		return NO;
	}
	
	NSLog(@"Determining if we can handle URL '%@' requested by '%@' with data '%@'", url, sourceApplication, annotation);
	
	// we'll only respond to URLs of the pattern "acme-directory://employee/{integer}"
	if ([[url scheme] isEqualToString:@"acme-directory"]) {
		
		NSString *viewIdentifier = [url host];
		
		// there is only one view identifier we'll accept
		if ([viewIdentifier isEqualToString:@"employee"]) {
			
			NSInteger employeeNumber = [self employeeNumberFromURL:url];
			EDEmployee *employee = [[EDEmployeeManager sharedManager] employeeForId:employeeNumber];
			
			// if we got an employee, then accept the URL
			if (employee != nil) {
				return YES;
			}
		}
	}
	
	return NO;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {	
	// determine if we can handle this URL
	// note: this was already done in application:didFinishLaunchingWithOptions:, but if the app was backgrounded when the URL request came in it would have skipped that check
	if ([self canHandleURL:url fromSourceApplication:sourceApplication withAnnotation:annotation] == NO) {
		return NO;
	}
	
	NSLog(@"Handling URL '%@' requested by '%@'", url, sourceApplication);
	
	NSInteger employeeNumber = [self employeeNumberFromURL:url];
	
	// if we are already showing a detail view, just change the record
	if ([self.navigationController.visibleViewController isKindOfClass:[EDEmployeeViewController class]]) {
		EDEmployeeViewController *detailVC = (EDEmployeeViewController*)self.navigationController.visibleViewController;
		detailVC.employee = [[EDEmployeeManager sharedManager] employeeForId:employeeNumber];
		
	// if we aren't showing a detail view, create one
	} else {
		EDEmployeeViewController *detailVC = [[EDEmployeeViewController alloc] initWithNibName:@"EDEmployeeViewController" bundle:nil];
		detailVC.employee = [[EDEmployeeManager sharedManager] employeeForId:employeeNumber];
		
		[self.navigationController pushViewController:detailVC animated:NO];
	}
	
	return YES;
}

@end
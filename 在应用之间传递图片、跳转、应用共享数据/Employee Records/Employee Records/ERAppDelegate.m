//
//  ERAppDelegate.m
//  Employee Records
//
//  Copyright (c) 2012 John Szumski. All rights reserved.
//

#import "ERAppDelegate.h"
#import "ERRecordsViewController.h"
#import "EREmployeeViewController.h"
#import "ERRecord.h"
#import "SSOUtils.h"
#import "ERLoginViewController.h"
#import "ERRecordsManager.h"
#import "NSData+Base64.h"
#import "ERUtils.h"

@implementation ERAppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	// create our nav controller and root view
	ERRecordsViewController *recordsVC = [[ERRecordsViewController alloc] initWithNibName:@"ERRecordsViewController" bundle:nil];
	self.navigationController = [[UINavigationController alloc] initWithRootViewController:recordsVC];
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
		ERLoginViewController *loginVC = [[ERLoginViewController alloc] init];
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

- (NSData*)imageDataFromURL:(NSURL*)url {
	NSArray *pathComponents = [url pathComponents];
	
	// return if we got a URL that was too short
	if ([pathComponents count] < 2) {
		return nil;
	}
		
	// the image data is in the query string
	NSString *imageDataComponent = [url query];

	// to get the original data, we must url-decode the query and then base64-decode that result
	return [NSData dataWithBase64EncodedString:[ERUtils decodeURL:imageDataComponent]];
}

- (BOOL)canHandleURL:(NSURL *)url fromSourceApplication:(NSString *)sourceApplication withAnnotation:(id)annotation {
	// we're only requiring a URL, but we could also check sourceApplication or annotation if necessary
	if (url == nil) {
		return NO;
	}
	
	NSLog(@"Determining if we can handle URL '%@' requested by '%@' with data '%@'", url, sourceApplication, annotation);
	
	// we'll only respond to URLs of two similar patterns:
	//		"acme-records://employee/{integer}"
	//		"acme-records://addimage/{integer}/{encoded image data}
	if ([[url scheme] isEqualToString:@"acme-records"]) {
		NSString *viewIdentifier = [url host];
		
		// there is only one view identifier we'll accept
		if ([viewIdentifier isEqualToString:@"employee"] || [viewIdentifier isEqualToString:@"addimage"]) {
			NSInteger employeeNumber = [self employeeNumberFromURL:url];
			NSData *imageData = [self imageDataFromURL:url];
	
			ERRecord *record = [[ERRecordsManager sharedManager] recordForId:employeeNumber];
			
			// if "employee" and we got a record, then accept the URL
			if ([viewIdentifier isEqualToString:@"employee"] && record != nil) {
				return YES;
			
			// if "addimage" and we got a record + image data, then accept the URL
			} else if ([viewIdentifier isEqualToString:@"addimage"] && record != nil && imageData != nil) {
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
	
	NSString *viewIdentifier = [url host];
	NSInteger employeeNumber = [self employeeNumberFromURL:url];
	ERRecord *record = [[ERRecordsManager sharedManager] recordForId:employeeNumber];
	
	// if we are adding an image, decode it and then add to the record
	if ([viewIdentifier isEqualToString:@"addimage"]) {
		NSData *imageData = [self imageDataFromURL:url];
		record.image = [UIImage imageWithData:imageData];
	}
	
	// if we are already showing a detail view, just change the record
	if ([self.navigationController.visibleViewController isKindOfClass:[EREmployeeViewController class]]) {
		EREmployeeViewController *detailVC = (EREmployeeViewController*)self.navigationController.visibleViewController;
		detailVC.record = record;

	// if we aren't showing a detail view, create one
	} else {
		EREmployeeViewController *detailVC = [[EREmployeeViewController alloc] initWithNibName:@"EREmployeeViewController" bundle:nil];
		detailVC.record = record;
		
		[self.navigationController pushViewController:detailVC animated:NO];
	}
	
	return YES;
}

@end
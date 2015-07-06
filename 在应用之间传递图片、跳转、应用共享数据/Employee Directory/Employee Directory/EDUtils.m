//
//  EDUtils.m
//  Employee Directory
//
//  Copyright (c) 2012 John Szumskic. All rights reserved.
//

#import "EDUtils.h"

@implementation EDUtils

+ (NSDictionary*)dictionaryOfInstalledCompanionApps {
	NSMutableDictionary *companionApps = [[NSMutableDictionary alloc] init];
	
	// employee records
	if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"acme-records://"]]) {
		[companionApps setValue:@"acme-records://employee/" forKey:@"Employee Records"];
	}
	
	return companionApps;
}

@end
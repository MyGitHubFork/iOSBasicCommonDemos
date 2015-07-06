//
//  ERUtils.m
//  Employee Records
//
//  Copyright (c) 2012 John Szumski. All rights reserved.
//

#import "ERUtils.h"

@implementation ERUtils

+ (NSDictionary*)dictionaryOfInstalledCompanionApps {
	NSMutableDictionary *companionApps = [NSMutableDictionary dictionary];
	
	// employee records
	if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"acme-directory://"]]) {
		[companionApps setValue:@"acme-directory://employee/" forKey:@"Employee Directory"];
	}
	
	return companionApps;
}

+ (NSString*)decodeURL:(NSString*)string {
	NSString *newString = NSMakeCollectable([(NSString *)CFURLCreateStringByReplacingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, CFSTR("")) autorelease]);
    
	if (newString) {
        return newString;
    }
	
    return @"";
}

@end
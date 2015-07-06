//
//  ERUtils.h
//  Employee Records
//
//  Copyright (c) 2012 John Szumski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ERUtils : NSObject

+ (NSDictionary*)dictionaryOfInstalledCompanionApps;
+ (NSString*)decodeURL:(NSString*)string;

@end
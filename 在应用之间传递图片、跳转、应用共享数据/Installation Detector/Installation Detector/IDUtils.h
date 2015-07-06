//
//  IDUtils.h
//  Installation Detector
//
//  Copyright (c) 2012 John Szumski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDUtils : NSObject

+ (NSString *)savedBirthday;
+ (BOOL)saveNewBirthday:(NSString*)birthday;

+ (BOOL)isFirstLaunch;

@end
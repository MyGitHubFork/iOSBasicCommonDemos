//
//  IDUtils.m
//  Installation Detector
//
//  Copyright (c) 2012 John Szumski. All rights reserved.
//

#import "IDUtils.h"
#import <Security/Security.h>

#define kDefaultsHasBeenLaunchedKey	@"IDHasBeenLaunchedKey"
#define kKeychainBirthdayKey		@"IDBirthday"


@interface IDUtils()

+ (NSMutableDictionary *)keychainSearch:(NSString *)identifier;
+ (NSString *)getValueForIdentifier:(NSString *)identifer;
+ (BOOL)setValue:(NSString *)value forIdentifier:(NSString *)identifier;

@end


@implementation IDUtils

+ (NSString *)savedBirthday {
	return [self getValueForIdentifier:kKeychainBirthdayKey];
}

+ (BOOL)saveNewBirthday:(NSString*)birthday {
	return [self setValue:birthday forIdentifier:kKeychainBirthdayKey];
}

+ (BOOL)isFirstLaunch {
	BOOL hasBeenLaunched = [[NSUserDefaults standardUserDefaults] boolForKey:kDefaultsHasBeenLaunchedKey];
	
	if (hasBeenLaunched == NO) {
		// this is the first launch, so set a defaults value saying that we were launched at least once
		[[NSUserDefaults standardUserDefaults] setBool:YES forKey:kDefaultsHasBeenLaunchedKey];
		[[NSUserDefaults standardUserDefaults] synchronize];
		
		return YES;
	}
	
	return NO;
}


#pragma mark - Keychain Manipulation

+ (NSMutableDictionary*)keychainSearch:(NSString*)identifier {
	NSData *encodedIdentifier = [identifier dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *keychainSearch = [[[NSMutableDictionary alloc] init] autorelease];
	
	// set the type to generic password
    [keychainSearch setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
	
	// set the identifier
    [keychainSearch setObject:encodedIdentifier forKey:(id)kSecAttrGeneric];
    [keychainSearch setObject:encodedIdentifier forKey:(id)kSecAttrAccount];
	
    return keychainSearch;
}

+ (NSString*)getValueForIdentifier:(NSString*)identifier {
    NSMutableDictionary *search = [self keychainSearch:identifier];
	
	// limit to the first result
    [search setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
	
	// return data vs a dictionary of attributes
    [search setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
	
	// perform the search
    NSData *value = nil;
    OSStatus status = SecItemCopyMatching((CFDictionaryRef)search,
                                          (CFTypeRef *)&value);
	
    if (status == noErr && [value length] > 0) {
        return [NSString stringWithUTF8String:[value bytes]];
    }
    
    return nil;
}

+ (BOOL)setValue:(NSString*)value forIdentifier:(NSString*)identifier {
    NSString *existingValue = [self getValueForIdentifier:identifier];
	
	// check if value exists
    if (existingValue) {
		
		// update if the new value is different
        if (![existingValue isEqualToString:value]) {
            NSMutableDictionary *search = [self keychainSearch:identifier];
            
            NSData *valueData = [value dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *update = [NSMutableDictionary dictionaryWithObjectsAndKeys:valueData, (id)kSecValueData, nil];
            
            OSStatus status = SecItemUpdate((CFDictionaryRef)search,
                                            (CFDictionaryRef)update);
            
            if (status == errSecSuccess) {
                return YES;
            }
			
            return NO;
        }
        
	// if no value exists, create a new entry
    } else {
        NSMutableDictionary *add = [self keychainSearch:identifier];
        
        NSData *valueData = [value dataUsingEncoding:NSUTF8StringEncoding];
        [add setObject:valueData forKey:(id)kSecValueData];
        
        OSStatus status = SecItemAdd((CFDictionaryRef)add,NULL);
        
        if (status == errSecSuccess) {
            return YES;
        }
		
        return NO;
    }
    
    return YES;
}

@end
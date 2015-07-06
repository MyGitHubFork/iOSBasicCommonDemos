//
//  SSOUtils.m
//  Employee Records
//
//  Copyright (c) 2012 John Szumski. All rights reserved.
//

#import "SSOUtils.h"
#import <Security/Security.h>

// replace "BUSUJW9XLQ" with your own bundle seed ID
#define kKeychainSSOGroup			@"BUSUJW9XLQ.com.acme.sso"
#define kCredentialTokenKey			@"SSOAuthenticationToken"
#define kCredentialUsernameKey		@"SSOAuthenticationUsername"


@interface SSOUtils(Private)

+ (NSMutableDictionary*)keychainSearch:(NSString*)identifier;
+ (NSString*)getValueForIdentifier:(NSString*)identifer;
+ (BOOL)setValue:(NSString *)value forIdentifier:(NSString*)identifier;
+ (void)deleteValueForIdentifier:(NSString*)identifier;

@end


@implementation SSOUtils

+ (BOOL)authenticateWithUsername:(NSString *)username andPassword:(NSString *)password {
	// you should do a check of the given credentials here
	// this dummy application will always return a successful login
	BOOL loginResult = YES;
	
	if (loginResult == YES) {
		// set SSO username
		[self setValue:username	forIdentifier:kCredentialUsernameKey];
		
		// set SSO token
		[self setValue:@"SSOValidToken" forIdentifier:kCredentialTokenKey];
	}
	
    return loginResult;
}

+ (void)logout {
    // destroy the saved token
    [self deleteValueForIdentifier:kCredentialTokenKey];
}

+ (BOOL)credentialsAreValid {
    NSString *token = [self credentialToken];
    
	if (token == nil) {
		return NO;
	}
    
    // you should do a secure check of the token here
	// we'll do a dummy check to make sure it matches our secret value 'SSOValidToken'
    return [token isEqualToString:@"SSOValidToken"];
}

+ (NSString*)credentialToken {
    return [self getValueForIdentifier:kCredentialTokenKey];
}

+ (NSString *)credentialUsername {
	return [self getValueForIdentifier:kCredentialUsernameKey];
}


#pragma mark - Keychain Manipulation

+ (NSMutableDictionary*)keychainSearch:(NSString*)identifier {
	NSData *encodedIdentifier = [identifier dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *keychainSearch = [[[NSMutableDictionary alloc] init] autorelease];
    
	// set the type to generic password
    [keychainSearch setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
	
	// set the item's identifier
    [keychainSearch setObject:encodedIdentifier forKey:(id)kSecAttrGeneric];
    [keychainSearch setObject:encodedIdentifier forKey:(id)kSecAttrAccount];
	
	// use the shared keychain
	// note: not supported in the simulator and will cause all keychain calls to fail
	#if !(TARGET_IPHONE_SIMULATOR)
		[keychainSearch setObject:kKeychainSSOGroup forKey:(id)kSecAttrAccessGroup];
	#endif
	
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
	
    if (status == noErr) {
        return [NSString stringWithUTF8String:[value bytes]];;
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

+ (void)deleteValueForIdentifier:(NSString*)identifier {
    NSMutableDictionary *search = [self keychainSearch:identifier];
    SecItemDelete((CFDictionaryRef)search);
}

@end
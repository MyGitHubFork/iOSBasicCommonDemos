//
//  IAUtils.m
//  Employee Records Image Adder
//
//  Copyright (c) 2012 John Szumski. All rights reserved.
//

#import "IAUtils.h"

@implementation IAUtils

+ (NSString*)encodeURL:(NSString *)string {
    NSString *newString = NSMakeCollectable([(NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)) autorelease]);
    
	if (newString) {
        return newString;
    }
	
    return @"";
}

@end
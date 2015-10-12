//
//  NSDataEx.h
//  iX3.0
//
//  Created by Feng Huajun on 09-4-16.
//  Copyright 2009 Infothinker. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSData (NSDataBase64Additions)
+ (NSData *) dataWithBase64EncodedString:(NSString *) string;
- (id) initWithBase64EncodedString:(NSString *) string;

- (NSString *) base64Encoding;
- (NSString *) base64EncodingWithLineLength:(unsigned int) lineLength;
//- (NSString*) urlEncodedString;

@end
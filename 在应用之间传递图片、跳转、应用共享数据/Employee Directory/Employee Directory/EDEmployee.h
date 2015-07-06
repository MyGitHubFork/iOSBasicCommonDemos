//
//  EDEmployee.h
//  Employee Directory
//
//  Copyright (c) 2012 John Szumski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDEmployee : NSObject

@property(nonatomic, retain) NSString	*name;
@property(nonatomic, assign) NSInteger	idNumber;

- (id)initWithName:(NSString*)name idNumber:(NSInteger)idNumber;

@end
//
//  EDEmployee.m
//  Employee Directory
//
//  Copyright (c) 2012 John Szumski. All rights reserved.
//

#import "EDEmployee.h"

@implementation EDEmployee

@synthesize name, idNumber;

- (id)initWithName:(NSString*)newName idNumber:(NSInteger)newIdNumber {
	self = [super init];
	
	if (self != nil) {
		self.name = newName;
		self.idNumber = newIdNumber;
	}
	
	return self;
}

@end
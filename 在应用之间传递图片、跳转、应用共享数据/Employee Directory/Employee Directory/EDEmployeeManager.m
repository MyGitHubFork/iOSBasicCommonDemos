//
//  EDEmployeeManager.m
//  Employee Directory
//
//  Copyright (c) 2012 John Szumski. All rights reserved.
//

#import "EDEmployeeManager.h"

static EDEmployeeManager *_sharedManager;

@interface EDEmployeeManager() {
@private
    NSArray *_employees;
}
@end

@implementation EDEmployeeManager

+ (EDEmployeeManager*) sharedManager {
	if (_sharedManager == nil) {
		_sharedManager = [[EDEmployeeManager alloc] init];
	}
	
	return _sharedManager;
}

- (id)init {
	self = [super init];
	
	if (self != nil) {
		// add our employees
		EDEmployee *johnny = [[EDEmployee alloc] initWithName:@"Johnny Appleseed" idNumber:1];
		EDEmployee *stephanie = [[EDEmployee alloc] initWithName:@"Stephanie Cruz" idNumber:2];
		EDEmployee *billy = [[EDEmployee alloc] initWithName:@"Billy McRory" idNumber:3];
		EDEmployee *daniel = [[EDEmployee alloc] initWithName:@"Daniel James" idNumber:4];
		EDEmployee *jane = [[EDEmployee alloc] initWithName:@"Jane Doe" idNumber:5];
		
		_employees = [NSArray arrayWithObjects:johnny, stephanie, billy, daniel, jane, nil];
	}
	
	return self;
}

- (EDEmployee*)employeeForId:(NSInteger)idNumber {
	for (EDEmployee *e in _employees) {
		if (e.idNumber == idNumber) {
			return e;
		}
	}
	
	return nil;
}

- (NSArray*)allEmployees {
	return _employees;
}

@end
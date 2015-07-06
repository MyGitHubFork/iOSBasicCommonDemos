//
//  ERRecordsManager.m
//  Employee Records
//
//  Copyright (c) 2012 John Szumski. All rights reserved.
//

#import "ERRecordsManager.h"

static ERRecordsManager *_sharedManager;

@interface ERRecordsManager() {
@private
    NSArray *_records;
}
@end

@implementation ERRecordsManager

+ (ERRecordsManager*) sharedManager {
	if (_sharedManager == nil) {
		_sharedManager = [[ERRecordsManager alloc] init];
	}
	
	return _sharedManager;
}

- (id)init {
	self = [super init];
	
	if (self != nil) {
		// add our employees
		ERRecord *johnny = [[ERRecord alloc] init];
		johnny.employeeName = @"Johnny Appleseed";
		johnny.idNumber = 1;
		johnny.salary = 45000;
		johnny.socialSecurityNumber = @"111223333";
		
		ERRecord *stephanie = [[ERRecord alloc] init];
		stephanie.employeeName = @"Stephanie Cruz";
		stephanie.idNumber = 2;
		stephanie.salary = 85000;
		stephanie.socialSecurityNumber = @"222334444";
		
		ERRecord *billy = [[ERRecord alloc] init];
		billy.employeeName = @"Billy McRory";
		billy.idNumber = 3;
		billy.salary = 60000;
		billy.socialSecurityNumber = @"333445555";
		
		ERRecord *daniel = [[ERRecord alloc] init];
		daniel.employeeName = @"Daniel James";
		daniel.idNumber = 4;
		daniel.salary = 55000;
		daniel.socialSecurityNumber = @"444556666";
		
		ERRecord *jane = [[ERRecord alloc] init];
		jane.employeeName = @"Jane Doe";
		jane.idNumber = 5;
		jane.salary = 68000;
		jane.socialSecurityNumber = @"555667777";
		
		_records = [NSArray arrayWithObjects:johnny, stephanie, billy, daniel, jane, nil];
	}
	
	return self;
}

- (ERRecord*)recordForId:(NSInteger)idNumber {
	for (ERRecord *r in _records) {
		if (r.idNumber == idNumber) {
			return r;
		}
	}
	
	return nil;
}

- (NSArray*)allRecords {
	return _records;
}

@end
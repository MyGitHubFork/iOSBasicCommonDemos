//
//  EDEmployeeManager.h
//  Employee Directory
//
//  Copyright (c) 2012 John Szumski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDEmployee.h"

@interface EDEmployeeManager : NSObject

+ (EDEmployeeManager*)sharedManager;

- (EDEmployee*)employeeForId:(NSInteger)idNumber;
- (NSArray*)allEmployees; 

@end
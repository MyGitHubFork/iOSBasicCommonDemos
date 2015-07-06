//
//  ERRecordsManager.h
//  Employee Records
//
//  Copyright (c) 2012 John Szumski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ERRecord.h"

@interface ERRecordsManager : NSObject

+ (ERRecordsManager*)sharedManager;

- (ERRecord*)recordForId:(NSInteger)idNumber;
- (NSArray*)allRecords; 

@end
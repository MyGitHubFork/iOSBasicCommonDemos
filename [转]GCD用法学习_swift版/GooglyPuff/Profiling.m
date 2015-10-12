//
//  Profiling.m
//  GCDTutorial
//
//  Created by A Magical Unicorn on A Sunday Night.
//  Copyright (c) 2014 Derek Selander. All rights reserved.
//

#import "Profiling.h"

//*****************************************************************************/
#pragma mark - One shot Profiling
//*****************************************************************************/

static NSDate *getSharedStartDate(BOOL shouldReset)
{
    static NSDate *shareStartDate = nil;
    if (shouldReset) {
        shareStartDate = [NSDate date];
    }
    return shareStartDate;
}

void RWTStartTimeProfiling()
{
    getSharedStartDate(YES);
}

void RWTStopTimeProfiling()
{
    NSArray *frames = [NSThread callStackSymbols];
    NSTimeInterval totalTime = [[NSDate date] timeIntervalSinceDate:getSharedStartDate(NO)];
    NSLog(@"%@, \n**************************** total time: %@", frames[1], @(totalTime));
}

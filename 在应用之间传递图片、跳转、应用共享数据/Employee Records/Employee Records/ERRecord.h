//
//  ERRecord.h
//  Employee Records
//
//  Copyright (c) 2012 John Szumski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ERRecord : NSObject

@property(nonatomic, strong) NSString	*employeeName;
@property(nonatomic, assign) NSInteger	idNumber;
@property(nonatomic, assign) NSInteger	salary;
@property(nonatomic, strong) NSString	*socialSecurityNumber;
@property(nonatomic, strong) UIImage	*image;

@end
//
//  ERRecordsViewController.h
//  Employee Records
//
//  Copyright (c) 2012 John Szumski. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EREmployeeViewController;

@interface ERRecordsViewController : UITableViewController

@property (strong, nonatomic) EREmployeeViewController *detailViewController;

@end
//
//  EDDirectoryViewController.h
//  Employee Directory
//
//  Copyright (c) 2012 John Szumski. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EDEmployeeViewController;

@interface EDDirectoryViewController : UITableViewController

@property (strong, nonatomic) EDEmployeeViewController *detailViewController;

@end
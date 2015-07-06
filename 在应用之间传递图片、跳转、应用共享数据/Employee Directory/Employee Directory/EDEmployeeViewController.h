//
//  EDEmployeeViewController.h
//  Employee Directory
//
//  Copyright (c) 2012 John Szumski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDEmployee.h"

@interface EDEmployeeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic)			EDEmployee	*employee;
@property (strong, nonatomic) IBOutlet	UITableView *directoryTable;

@end
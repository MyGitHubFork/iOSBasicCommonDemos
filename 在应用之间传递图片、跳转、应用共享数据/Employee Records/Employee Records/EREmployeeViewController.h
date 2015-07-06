//
//  EREmployeeViewController.h
//  Employee Records
//
//  Copyright (c) 2012 John Szumski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ERRecord.h"

@interface EREmployeeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic)			ERRecord	*record;
@property (strong, nonatomic) IBOutlet	UITableView *recordTable;

@end
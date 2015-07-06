//
//  ERRecordsViewController.m
//  Employee Records
//
//  Copyright (c) 2012 John Szumski. All rights reserved.
//

#import "ERRecordsViewController.h"
#import "EREmployeeViewController.h"
#import "ERRecord.h"
#import "ERRecordsManager.h"
#import "SSOUtils.h"
#import "ERLoginViewController.h"


@interface ERRecordsViewController()

- (void)logoutTapped:(id)sender;

@end


@implementation ERRecordsViewController

@synthesize detailViewController = _detailViewController;


#pragma mark - View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
	if (self) {
		self.title = NSLocalizedString(@"Employee Records", @"Employee Records");
		
		// shorten the back button title
		self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Records" 
																				 style:UIBarButtonItemStylePlain 
																				target:nil 
																				action:nil];
    }
	
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
	// add a login button to the bottom bar
	self.toolbarItems = [NSArray arrayWithObjects:
						 [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace 
																	   target:nil 
																	   action:nil],
						 [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"Logout %@", [SSOUtils credentialUsername]]
														  style:UIBarButtonItemStyleBordered 
														 target:self 
														 action:@selector(logoutTapped:)],
						 [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
																	   target:nil
																	   action:nil],
						 nil];
}


#pragma mark - UI response

- (void)logoutTapped:(id)sender {
	// logout
	[SSOUtils logout];
	
	// show login view
	ERLoginViewController *loginVC = [[ERLoginViewController alloc] init];
	[self presentModalViewController:[[UINavigationController alloc] initWithRootViewController:loginVC] animated:YES];
}


#pragma mark - UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [[[ERRecordsManager sharedManager] allRecords] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"employeeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
	if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
	
	// display the employee's name
	ERRecord *record = [[[ERRecordsManager sharedManager] allRecords] objectAtIndex:indexPath.row];
	cell.textLabel.text = record.employeeName;
	
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
    if (!self.detailViewController) {
        self.detailViewController = [[EREmployeeViewController alloc] initWithNibName:@"EREmployeeViewController" bundle:nil];
    }
	
	// configure the detail view
	ERRecord *record = [[[ERRecordsManager sharedManager] allRecords] objectAtIndex:indexPath.row];
	self.detailViewController.record = record;
	
	// display the detail view
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}

@end
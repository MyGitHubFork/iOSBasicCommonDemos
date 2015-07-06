//
//  EDEmployeeViewController.m
//  Employee Directory
//
//  Copyright (c) 2012 John Szumski. All rights reserved.
//

#import "EDEmployeeViewController.h"
#import "EDUtils.h"
#import "SSOUtils.h"


@interface EDEmployeeViewController()

- (void)appBecameActive:(NSNotification*)notification;

@end


@implementation EDEmployeeViewController

@synthesize employee, directoryTable;


#pragma mark - View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
	if (self) {
		self.title = NSLocalizedString(@"Employee Details", @"Employee Details");
    }
	
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
	// ensure that we refresh if the app is active and the user uninstalls a companion app
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(appBecameActive:) 
												 name:UIApplicationDidBecomeActiveNotification 
											   object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
	// stop listening for the app becoming active
	[[NSNotificationCenter defaultCenter] removeObserver:self 
													name:UIApplicationDidBecomeActiveNotification 
												  object:nil];
}


#pragma mark - Model interaction

- (void)setEmployee:(EDEmployee *)newEmployee {
	if (employee != newEmployee) {
		employee = newEmployee;
		
		// update the UI
		[self.directoryTable reloadData];
	}
}


#pragma mark - Notifications

- (void)appBecameActive:(NSNotification*)notification {
	// update the UI
	[self.directoryTable reloadData];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// employee info
	if (section == 0) {
		return 2; 
		
	// links to other applications
	} else if (section == 1) {
		return [[EDUtils dictionaryOfInstalledCompanionApps] count];
	}

	return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (section == 0) {
		return NSLocalizedString(@"Employee Info",@"Employee Info");
	
	} else if (section == 1) {
		return NSLocalizedString(@"Companion Apps",@"Companion Apps");
	}
	
	return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
	if (section == 1 && [[EDUtils dictionaryOfInstalledCompanionApps] count] == 0) {
		return NSLocalizedString(@"No companion apps installed.",@"No companion apps installed.");
	}
	
	return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellIdentifier = @"directoryCell";

	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellIdentifier];
	}

	// employee info
	if (indexPath.section == 0) {
		
		// name
		if (indexPath.row == 0) {
			cell.textLabel.text = NSLocalizedString(@"Name", @"Name");
			cell.detailTextLabel.text = employee.name;
		
		// ID number
		} else if (indexPath.row == 1) {
			cell.textLabel.text = NSLocalizedString(@"ID Number", @"ID Number");
			cell.detailTextLabel.text = [NSString stringWithFormat:@"%i", employee.idNumber];
		}
	
	// links to other applications
	} else if (indexPath.section == 1) {
		NSDictionary *companionApps = [EDUtils dictionaryOfInstalledCompanionApps];
		NSString *appName = [[companionApps allKeys] objectAtIndex:indexPath.row];
		
		cell.detailTextLabel.text = appName;
	}

	return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSDictionary *companionApps = [EDUtils dictionaryOfInstalledCompanionApps];
	NSString *appName = [[companionApps allKeys] objectAtIndex:indexPath.row];
	NSString *urlScheme = [companionApps valueForKey:appName];

	// open the other application
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[urlScheme stringByAppendingFormat:@"%i",employee.idNumber]]];
}
							
@end
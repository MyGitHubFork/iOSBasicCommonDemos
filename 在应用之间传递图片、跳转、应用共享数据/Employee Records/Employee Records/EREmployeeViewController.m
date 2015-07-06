//
//  EREmployeeViewController.m
//  Employee Records
//
//  Copyright (c) 2012 John Szumski. All rights reserved.
//

#import "EREmployeeViewController.h"
#import "ERUtils.h"
#import "SSOUtils.h"


@interface EREmployeeViewController()

- (void)appBecameActive:(NSNotification*)notification;

@end


@implementation EREmployeeViewController

@synthesize record, recordTable;


#pragma mark - View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
	if (self) {
		self.title = NSLocalizedString(@"Record Details", @"Record Details");
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

- (void)setRecord:(ERRecord *)newRecord {
	if (record != newRecord) {
		record = newRecord;
		
		// update the UI
		[self.recordTable reloadData];
	}
}


#pragma mark - Notifications

- (void)appBecameActive:(NSNotification*)notification {
	// update the UI
	[self.recordTable reloadData];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// employee info
	if (section == 0) {
		return 4; 
		
	// links to other applications
	} else if (section == 1) {
		return [[ERUtils dictionaryOfInstalledCompanionApps] count];
	
	// image
	} else if (section == 2) {
		
		// only populate if we have a real image
		if (record.image == nil) {
			return 0;
			
		} else {
			return 1;
		}
	}
	
	return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (section == 0) {
		return NSLocalizedString(@"Record Info",@"Record Info");
		
	} else if (section == 1) {
		return NSLocalizedString(@"Companion Apps",@"Companion Apps");
	
	} else if (section == 2) {
		return NSLocalizedString(@"Images", @"Images");
	}
	
	return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
	if (section == 1 && [[ERUtils dictionaryOfInstalledCompanionApps] count] == 0) {
		return NSLocalizedString(@"No companion apps installed.",@"No companion apps installed.");
	}
	
	if (section == 2 && record.image == nil) {
		return NSLocalizedString(@"No images in record.", @"No images in record.");
	}
	
	return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *textCellIdentifier = @"recordCell";
	static NSString *imageCellIdentifier = @"imageCell";
	
	UITableViewCell *cell = nil;
	
	// text sections
	if (indexPath.section == 0 || indexPath.section == 1) {
		cell = [tableView dequeueReusableCellWithIdentifier:textCellIdentifier];
		if (cell == nil) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:textCellIdentifier];
		}
		
		// employee info
		if (indexPath.section == 0) {
			
			// name
			if (indexPath.row == 0) {
				cell.textLabel.text = NSLocalizedString(@"Name", @"Name");
				cell.detailTextLabel.text = record.employeeName;
				
			// ID number
			} else if (indexPath.row == 1) {
				cell.textLabel.text = NSLocalizedString(@"ID Number", @"ID Number");
				cell.detailTextLabel.text = [NSString stringWithFormat:@"%i", record.idNumber];
				
			// salary
			} else if (indexPath.row == 2) {
				NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
				[formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
				[formatter setLocale:[NSLocale currentLocale]];
				
				cell.textLabel.text = NSLocalizedString(@"Salary", @"Salary");
				cell.detailTextLabel.text = [formatter stringFromNumber:[NSNumber numberWithInt:record.salary]];
			
			// social security number
			} else if (indexPath.row == 3) {
				cell.textLabel.text = NSLocalizedString(@"SSN", @"SSN");
				cell.detailTextLabel.text = record.socialSecurityNumber;
			}
			
		// links to other applications
		} else if (indexPath.section == 1) {
			NSDictionary *companionApps = [ERUtils dictionaryOfInstalledCompanionApps];
			NSString *appName = [[companionApps allKeys] objectAtIndex:indexPath.row];
			
			cell.detailTextLabel.text = appName;
		}
	
	// images
	} else if (indexPath.section == 2) {
		cell = [tableView dequeueReusableCellWithIdentifier:imageCellIdentifier];
		if (cell == nil) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:imageCellIdentifier];
		}
		
		UIImageView *imageView = [[UIImageView alloc] initWithImage:record.image];
		imageView.contentMode = UIViewContentModeScaleAspectFit;
		imageView.frame = CGRectMake(cell.contentView.frame.size.width/2-200/2, 220/2-200/2, 200, 200);
		imageView.backgroundColor = [UIColor lightGrayColor];
		[cell.contentView addSubview:imageView];
		
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 2) {
		return 220.0f;
	}
	
	return 44.0f;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 1) {
		NSDictionary *companionApps = [ERUtils dictionaryOfInstalledCompanionApps];
		NSString *appName = [[companionApps allKeys] objectAtIndex:indexPath.row];
		NSString *urlScheme = [companionApps valueForKey:appName];
		
		// open the other application
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[urlScheme stringByAppendingFormat:@"%i",record.idNumber]]];
	}
}

@end
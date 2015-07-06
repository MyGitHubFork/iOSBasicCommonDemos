//
//  ERLoginViewController.m
//  Employee Records
//
//  Copyright (c) 2012 John Szumski. All rights reserved.
//

#import "ERLoginViewController.h"
#import "SSOUtils.h"

@interface ERLoginViewController () {
@private
	UITextField *usernameField;
	UITextField *passwordField;
}

@end

@implementation ERLoginViewController

- (id)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
	
    if (self) {
        self.title = NSLocalizedString(@"SSO Login", @"SSO Login");
    }
	
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
	// focus the username field
	[usernameField becomeFirstResponder];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3; // username + password + login button
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
	return NSLocalizedString(@"This dummy form will accept any username/password combination.",@"This dummy form will accept any username/password combination.");
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"authCell";
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
	}
	
	// username
	if (indexPath.row == 0) {
		if (usernameField == nil) {
			usernameField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width-30, 44)];
			usernameField.autocorrectionType = UITextAutocorrectionTypeNo;
			usernameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
			usernameField.placeholder = NSLocalizedString(@"Username", @"Username");
			usernameField.clearButtonMode = UITextFieldViewModeWhileEditing;
		}
		
		cell.textLabel.text = nil;
		cell.accessoryView = usernameField;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	// password
	} else if (indexPath.row == 1) {
		if (passwordField == nil) {
			passwordField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width-30, 44)];
			passwordField.secureTextEntry = YES;
			passwordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
			passwordField.placeholder = NSLocalizedString(@"Password", @"Password");
			passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
		}
		
		cell.textLabel.text = nil;
		cell.accessoryView = passwordField;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;	
	
	// login button
	} else if (indexPath.row == 2) {
		cell.textLabel.text = NSLocalizedString(@"Login", @"Login");
		cell.textLabel.textAlignment = UITextAlignmentCenter;
		cell.textLabel.font = [UIFont boldSystemFontOfSize:16.0];
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
	}
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];

	// login button
	if (indexPath.row == 2 && [usernameField.text length] > 0 && [passwordField.text length] > 0) {
		
		// try the given username/password combination
		if ([SSOUtils authenticateWithUsername:usernameField.text andPassword:passwordField.text]) {
			
			// the credentials were accepted, so hide the login form
			[self dismissModalViewControllerAnimated:YES];
		}
	}
}

@end
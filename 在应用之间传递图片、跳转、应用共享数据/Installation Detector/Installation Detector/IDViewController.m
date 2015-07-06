//
//  IDViewController.m
//  Installation Detector
//
//  Copyright (c) 2012 John Szumski. All rights reserved.
//

#import "IDViewController.h"
#import "IDUtils.h"

@implementation IDViewController

@synthesize birthdayField;

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	// check for a previous installation
	NSString *savedBirthday = [IDUtils savedBirthday];
	BOOL firstLaunch = [IDUtils isFirstLaunch];
	
	if (savedBirthday != nil && firstLaunch) {
		[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Previously Saved Birthday",@"Previously Saved Birthday") 
									message:NSLocalizedString(@"It appears you saved a birthday in a previous installation of this application.  Do you want to keep it?",@"It appears you saved a birthday in a previous installation of this application.  Do you want to keep it?") 
								   delegate:self 
						  cancelButtonTitle:NSLocalizedString(@"Discard", @"Discard") 
						  otherButtonTitles:NSLocalizedString(@"Keep", @"Keep"),nil] show];
	}
	
	// prepopulate the birthday field if this isn't the first launch
	if (firstLaunch == NO) {
		self.birthdayField.text = savedBirthday;
	}
	
	// focus the birthday field
	[self.birthdayField becomeFirstResponder];
}

- (void)saveButtonTapped:(id)sender {
	// make sure the user typed something
	if ([self.birthdayField.text length] > 0) {
		NSLog(@"%i",[IDUtils saveNewBirthday:self.birthdayField.text]);
	
	} else {
		[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Empty Birthday",@"Empty Birthday") 
									message:NSLocalizedString(@"Please enter a birthday to save.",@"Please enter a birthday to save.") 
								   delegate:nil 
						  cancelButtonTitle:NSLocalizedString(@"Okay", @"Okay") 
						  otherButtonTitles:nil] show];
	}
}


#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	// populate our field with the value from the previous installation
	if (buttonIndex != alertView.cancelButtonIndex) {
		self.birthdayField.text = [IDUtils savedBirthday];
	
	// overwrite the previous value
	} else {
		[IDUtils saveNewBirthday:@""];
		self.birthdayField.text = @"";
	}
}

@end
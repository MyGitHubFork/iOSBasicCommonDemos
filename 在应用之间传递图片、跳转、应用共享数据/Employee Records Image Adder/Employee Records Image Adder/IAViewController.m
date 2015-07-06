//
//  IAViewController.m
//  Employee Records Image Adder
//
//  Copyright (c) 2012 John Szumski. All rights reserved.
//

#import "IAViewController.h"
#import "NSData+Base64.h"
#import "IAUtils.h"

@interface IAViewController()

- (void)employeeNumberDidChange;

@end


@implementation IAViewController

@synthesize sendButton, imageView, employeeNumberField;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// focus the field by default
	[employeeNumberField becomeFirstResponder];
	
	// detect when an employee number is entered
	[employeeNumberField addTarget:self 
							action:@selector(employeeNumberDidChange) 
				  forControlEvents:UIControlEventEditingChanged];
}

- (void)employeeNumberDidChange {
	if ([employeeNumberField.text length] > 0) {
		sendButton.enabled = YES;
	} else {
		sendButton.enabled = NO;
	}
}

- (void)sendTapped:(id)sender {
	// encode the image as data
	NSData *imageData = UIImagePNGRepresentation(imageView.image);
		
	// turn the data into a string by base64-encoding it
	NSString *imageString = [imageData base64EncodingWithLineLength:0];
	
	// url-encode the base64 string
	NSString *encodedString = [IAUtils encodeURL:imageString];
		
	// create and open the URL
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"acme-records://addimage/%@/?%@",employeeNumberField.text,encodedString]];
	[[UIApplication sharedApplication] openURL:url];
}

@end
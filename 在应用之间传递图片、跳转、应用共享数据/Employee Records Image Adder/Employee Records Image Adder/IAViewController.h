//
//  IAViewController.h
//  Employee Records Image Adder
//
//  Copyright (c) 2012 John Szumski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IAViewController : UIViewController

@property(nonatomic, strong) IBOutlet UIBarButtonItem	*sendButton;
@property(nonatomic, strong) IBOutlet UIImageView		*imageView;
@property(nonatomic, strong) IBOutlet UITextField		*employeeNumberField;

- (IBAction)sendTapped:(id)sender;

@end
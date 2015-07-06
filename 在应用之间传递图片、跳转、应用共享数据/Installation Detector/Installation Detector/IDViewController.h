//
//  IDViewController.h
//  Installation Detector
//
//  Copyright (c) 2012 John Szumski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IDViewController : UIViewController <UIAlertViewDelegate>

@property(nonatomic,strong) IBOutlet UITextField *birthdayField;

- (IBAction)saveButtonTapped:(id)sender;

@end
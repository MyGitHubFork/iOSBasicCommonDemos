//
//  MKDetailsViewController.m
//  CollectionViewTest
//
//  Created by Mugunth on 4/9/12.
//  Copyright (c) 2012 Steinlogic Consulting and Training. All rights reserved.
//

#import "MKDetailsViewController.h"

@interface MKDetailsViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *textLabel;
@end

@implementation MKDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction) doneTapped:(id) sender {

  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
  self.textLabel.text =[[self.photoPath lastPathComponent] stringByDeletingPathExtension];
  
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
    
    UIImage *image = [UIImage imageWithContentsOfFile:self.photoPath];
    dispatch_async(dispatch_get_main_queue(), ^{
      
      self.imageView.image = image;
    });
  });

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end

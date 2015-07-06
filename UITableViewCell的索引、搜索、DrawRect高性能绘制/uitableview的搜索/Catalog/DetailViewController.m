//
//  DetailViewController.m
//  Catalog
//
//  Created by Patrick Alessi on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController


#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        Product* theProduct = (Product*) self.detailItem;

        //  Set the text of the labels to the values passed in the Product object
        [self.nameLabel setText:theProduct.name];
        [self.manufacturerLabel setText:theProduct.manufacturer];
        [self.detailsLabel setText:theProduct.details];
        [self.priceLabel setText:[NSString stringWithFormat:@"%.2f",theProduct.price]];
        [self.quantityLabel setText:[NSString stringWithFormat:@"%d",
                                 theProduct.quantity]];
        [self.countryLabel setText:theProduct.countryOfOrigin];
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    [self configureView];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Detail", @"Detail");
    }
    return self;
}


@end

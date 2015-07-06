//
//  DetailViewController.h
//  Catalog
//
//  Created by Patrick Alessi on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel* nameLabel;
@property (strong, nonatomic) IBOutlet UILabel* manufacturerLabel;
@property (strong, nonatomic) IBOutlet UILabel* detailsLabel;
@property (strong, nonatomic) IBOutlet UILabel* priceLabel;
@property (strong, nonatomic) IBOutlet UILabel* quantityLabel;
@property (strong, nonatomic) IBOutlet UILabel* countryLabel;

@property (strong, nonatomic) id detailItem;


@end

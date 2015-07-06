//
//  MasterViewController.m
//  Catalog
//
//  Created by Patrick Alessi on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Catalog", @"Catalog");
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //  Get the DBAccess object;
    DBAccess *dbAccess = [[DBAccess alloc] init];
    
    //  Get the products array from the database
    self.products = [dbAccess getAllProducts];
    
    //  Close the database because we are finished with it
    [dbAccess closeDatabase];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.products count];
}

// Customize the appearance of table view cells.
#define NAMELABEL_TAG 1
#define MANUFACTURERLABEL_TAG 2
#define PRICELABEL_TAG 3
#define PRODUCTIMAGE_TAG 4
#define FLAGIMAGE_TAG 5

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UILabel *nameLabel, *manufacturerLabel, *priceLabel;
    UIImageView *productImage, *flagImage;
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        // Create a new cell object since the dequeue failed
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:CellIdentifier];
        
        // Set the accessoryType to the grey disclosure arrow
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        // Configure the name label
        nameLabel = [[UILabel alloc]
                     initWithFrame:CGRectMake(45.0, 0.0, 120.0, 25.0)];
        
        nameLabel.tag = NAMELABEL_TAG;
        
        // Add the label to the cell's content view
        [cell.contentView addSubview:nameLabel];
        
        // Configure the manufacturer label
        manufacturerLabel = [[UILabel alloc]
                            initWithFrame:CGRectMake(45.0, 25.0, 120.0, 15.0)];
        manufacturerLabel.tag = MANUFACTURERLABEL_TAG;
        manufacturerLabel.font = [UIFont systemFontOfSize:12.0];
        manufacturerLabel.textColor = [UIColor darkGrayColor];
        
        // Add the label to the cell's content view
        [cell.contentView addSubview:manufacturerLabel];
        
        // Configure the price label
        priceLabel = [[UILabel alloc]
                       initWithFrame:CGRectMake(200.0, 10.0, 60.0, 25.0)];

        priceLabel.tag = PRICELABEL_TAG;
        
        // Add the label to the cell's content view
        [cell.contentView addSubview:priceLabel];
        
        // Configure the product Image
        productImage = [[UIImageView alloc]
                        initWithFrame:CGRectMake(0.0, 0.0, 40.0, 40.0)];

        productImage.tag = PRODUCTIMAGE_TAG;
        
        productImage.alpha = 0.9;
        
        // Add the Image to the cell's content view
        [cell.contentView addSubview:productImage];
        
        // Configure the flag Image
        flagImage = [[UIImageView alloc]
                     initWithFrame:CGRectMake(260.0, 10.0, 20.0, 20.0)];
        flagImage.tag = FLAGIMAGE_TAG;
        
        // Add the Image to the cell's content view
        [cell.contentView addSubview:flagImage];
    }
    else {
        nameLabel = (UILabel *)[cell.contentView
                                viewWithTag:NAMELABEL_TAG];
        manufacturerLabel = (UILabel *)[cell.contentView
                                        viewWithTag:MANUFACTURERLABEL_TAG];
        priceLabel = (UILabel *)[cell.contentView
                                 viewWithTag:PRICELABEL_TAG];
        productImage = (UIImageView *)[cell.contentView
                                       viewWithTag:PRODUCTIMAGE_TAG];
        flagImage = (UIImageView *)[cell.contentView
                                    viewWithTag:FLAGIMAGE_TAG];
    }
    
    // Configure the cell.
    // Get the Product object
    Product* product = [self.products objectAtIndex:[indexPath row]];
    
    nameLabel.text = product.name;
    manufacturerLabel.text = product.manufacturer;
    priceLabel.text = [[NSNumber numberWithFloat: product.price] stringValue];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:product.image
                                                         ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    productImage.image = image;
    
    filePath = [[NSBundle mainBundle] pathForResource:product.countryOfOrigin
                                               ofType:@"png"];
    image = [UIImage imageWithContentsOfFile:filePath];
    flagImage.image = image;
    
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.detailViewController) {
        self.detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    }

    self.detailViewController.detailItem = [self.products objectAtIndex:[indexPath row]];
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}

@end

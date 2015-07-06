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
							
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.products = [NSMutableArray arrayWithCapacity:1];
    
    NSMutableArray *productsTemp;
    
    //  Get the DBAccess object;
    DBAccess *dbAccess = [[DBAccess alloc] init];
    
    //  Get the products array from the database
    productsTemp = [dbAccess getAllProducts];
    
    //  Close the database because you are finished with it
    [dbAccess closeDatabase];
        
    UILocalizedIndexedCollation *indexedCollation =
    [UILocalizedIndexedCollation currentCollation];
    
    //  Iterate over the products, populating their section number
    for (Product *theProduct in productsTemp) {
        NSInteger section = [indexedCollation sectionForObject:theProduct
                                       collationStringSelector:@selector(name)];
        theProduct.section = section;
    }
    
    //  Get the count of the number of sections
    NSInteger sectionCount = [[indexedCollation sectionTitles] count];
    
    //  Create an array to hold the sub arrays
    NSMutableArray *sectionsArray = [NSMutableArray
                                     arrayWithCapacity:sectionCount];
    
    // Iterate over each section, creating each sub array
    for (int i=0; i<=sectionCount; i++) {
        NSMutableArray *singleSectionArray = [NSMutableArray
                                              arrayWithCapacity:1];
        [sectionsArray addObject:singleSectionArray];
    }
    
    // Iterate over the products putting each product into the correct sub-array
    for (Product *theProduct in productsTemp) {
        [(NSMutableArray *)[sectionsArray objectAtIndex:theProduct.section]
         addObject:theProduct];
    }
    
    // Iterate over each section array to sort the items in the section
    for (NSMutableArray *singleSectionArray in sectionsArray) {
        // Use the UILocalizedIndexedCollation sortedArrayFromArray: method to
        // sort each array
        NSArray *sortedSection = [indexedCollation
                                  sortedArrayFromArray:singleSectionArray
                                  
                                  collationStringSelector:@selector(name)];
        [self.products addObject:sortedSection];
    }
    
    // Create search bar
    self.searchBar = [[UISearchBar alloc] initWithFrame:
                       CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
    self.tableView.tableHeaderView = self.searchBar;

    // Create and configure the search controller
    self.searchController = [[UISearchDisplayController alloc]
                              initWithSearchBar:self.searchBar
                              contentsController:self];
    
    self.searchController.searchResultsDataSource = self;
    self.searchController.searchResultsDelegate = self;

    
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Is the request for numberOfRowsInSection for the regular table?
    if (tableView == self.tableView)
    {
        // Just return the count of the products like before
        return [self.products count];
        
    }
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    // Is the request for numberOfRowsInSection for the regular table?
    if (tableView == self.tableView)
    {
        // Just return the count of the products like before
        return [[self.products objectAtIndex:section] count];
        
    }
    
    // You need the count for the filtered table
    //  First, you have to flatten the array of arrays self.products
    NSMutableArray *flattenedArray = [[NSMutableArray alloc]
                                      initWithCapacity:1];
    for (NSMutableArray *theArray in self.products)
    {
        for (int i=0; i<[theArray count];i++)
        {
            [flattenedArray addObject:[theArray objectAtIndex:i]];
        }
    }
    
    // Set up an NSPredicate to filter the rows
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"name beginswith[c] %@", self.searchBar.text];
    self.filteredProducts = [flattenedArray
                             filteredArrayUsingPredicate:predicate];
        
    return self.filteredProducts.count;
}

// Customize the appearance of table view cells.
#define NAMELABEL_TAG 1
#define MANUFACTURERLABEL_TAG 2
#define PRICELABEL_TAG 3
#define PRODUCTIMAGE_TAG 4
#define FLAGIMAGE_TAG 5

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    CatalogTableViewCell *cell = (CatalogTableViewCell *)
    
    [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CatalogTableViewCell alloc]
                 initWithStyle:UITableViewCellStyleDefault
                 reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell.
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    // Is the request for cellForRowAtIndexPath for the regular table?
    if (tableView == self.tableView)
    {
        
        // Get the Product object
        Product* product = [[self.products
                             objectAtIndex:[indexPath section]]
                            objectAtIndex:[indexPath row]];
        
        // Set the product to be used to draw the cell
        [cell setProduct:product];
        
        return cell;
    }
    
    // Get the Product object
    Product* product = [self.filteredProducts objectAtIndex:[indexPath row]];
    
    // Set the product to be used to draw the cell
    [cell setProduct:product];
    
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

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section {
    // Make sure that the section will contain some data
    if ([[self.products objectAtIndex:section] count] > 0) {
        
        // If it does, get the section title from the
        // UILocalizedIndexedCollation object
        return [[[UILocalizedIndexedCollation currentCollation] sectionTitles]
                objectAtIndex:section];
    }
    return nil;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (tableView == self.tableView)
    {
        // Set up the index titles from the UILocalizedIndexedCollation
        return [[UILocalizedIndexedCollation currentCollation]
                sectionIndexTitles];
    }
    
    return nil;
}


- (NSInteger)tableView:(UITableView *)tableView
sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    // Link the sections to the labels in the index
    return [[UILocalizedIndexedCollation currentCollation]
            sectionForSectionIndexTitleAtIndex:index];
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

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Product* product;
    
    if (tableView == self.tableView)
    {
        // Get the product that corresponds with the touched cell
        product =  [[self.products objectAtIndex:[indexPath section]]
                    objectAtIndex:[indexPath row]];
    }
    
    else {
        product =  [self.filteredProducts objectAtIndex:[indexPath row]];
        
    }
    
    
    if (!self.detailViewController) {
        self.detailViewController = [[DetailViewController alloc]
                                     initWithNibName:@"DetailViewController"
                                     bundle:nil];
    }
    
    self.detailViewController.detailItem = product;
    
    [self.navigationController pushViewController:self.detailViewController
                                         animated:YES];
    
    
}

@end

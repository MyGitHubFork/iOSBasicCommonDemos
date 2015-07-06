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
    return [self.products count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.products objectAtIndex:section] count];
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
    
    // Get the Product object
    Product* product = [[self.products objectAtIndex:[indexPath section]]
                        objectAtIndex:[indexPath row]];
    
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
    if ([[self.products objectAtIndex:section] count] > 0) {
        //设置section的高度
        return [[[UILocalizedIndexedCollation currentCollation] sectionTitles]
                objectAtIndex:section];
    }
    return nil;
}
//返回最右边的标题列表
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
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
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.detailViewController) {
        self.detailViewController = [[DetailViewController alloc]
                                     initWithNibName:@"DetailViewController"
                                     bundle:nil];
    }

    self.detailViewController.detailItem =[[self.products
                                            objectAtIndex:[indexPath section]]
                                           objectAtIndex:[indexPath row]];
    [self.navigationController pushViewController:self.detailViewController
                                         animated:YES];
}

@end

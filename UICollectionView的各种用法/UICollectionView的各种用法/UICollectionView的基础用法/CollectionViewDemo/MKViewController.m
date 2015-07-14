//
//  MKViewController.m
//  CollectionViewTest
//
//  Created by Mugunth on 4/9/12.
//  Copyright (c) 2012 Steinlogic Consulting and Training. All rights reserved.
//

#import "MKViewController.h"

#import "MKPhotoCell.h"

#import "MKDetailsViewController.h"

enum PhotoOrientation {
  
  PhotoOrientationLandscape,
  PhotoOrientationPortrait
};

@interface MKViewController ()
@property (strong, nonatomic) NSArray *photosList;
@property (strong, nonatomic) NSMutableArray *photoOrientation;
@property (strong, nonatomic) NSMutableDictionary *photosCache;
@end

@implementation MKViewController

-(NSString*) photosDirectory {
  
  return [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Photos"];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
  NSIndexPath *selectedIndexPath = sender;
  NSString *photoName = [self.photosList objectAtIndex:selectedIndexPath.row];
  
  MKDetailsViewController *controller = segue.destinationViewController;
  controller.photoPath = [[self photosDirectory] stringByAppendingPathComponent:photoName];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  NSArray * photosArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self photosDirectory] error:nil];
  self.photosCache = [NSMutableDictionary dictionary];
  self.photoOrientation = [NSMutableArray array];
  self.photosList = nil;
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
    
    [photosArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
      
      NSString *path = [[self photosDirectory] stringByAppendingPathComponent:obj];
      CGSize size = [UIImage imageWithContentsOfFile:path].size;
      if(size.width > size.height)
        [self.photoOrientation addObject:[NSNumber numberWithInt:PhotoOrientationLandscape]];
      else
        [self.photoOrientation addObject:[NSNumber numberWithInt:PhotoOrientationPortrait]];
    }];
    
    dispatch_async(dispatch_get_main_queue(), ^{
      
      self.photosList = photosArray;
      [self.collectionView reloadData];
    });
  });
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  self.photosCache = [NSMutableDictionary dictionary];
  // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return YES;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  
  return [self.photosList count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *CellIdentifierLandscape = @"MKPhotoCellLandscape";
  static NSString *CellIdentifierPortrait = @"MKPhotoCellPortrait";
  
  NSInteger orientation = [[self.photoOrientation objectAtIndex:indexPath.row] integerValue];
  
  MKPhotoCell *cell = (MKPhotoCell*) [collectionView dequeueReusableCellWithReuseIdentifier:
                                      orientation == PhotoOrientationLandscape ? CellIdentifierLandscape:CellIdentifierPortrait
                                                                               forIndexPath:indexPath];
  
  NSString *photoName = [self.photosList objectAtIndex:indexPath.row];
  NSString *photoFilePath = [[self photosDirectory] stringByAppendingPathComponent:photoName];
  cell.nameLabel.text =[photoName stringByDeletingPathExtension];
  
  __block UIImage* thumbImage = [self.photosCache objectForKey:photoName];
  cell.photoView.image = thumbImage;
  
  if(!thumbImage) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
      
      UIImage *image = [UIImage imageWithContentsOfFile:photoFilePath];
      if(orientation == PhotoOrientationPortrait) {
        UIGraphicsBeginImageContext(CGSizeMake(180.0f, 120.0f));
        [image drawInRect:CGRectMake(0, 0, 180.0f, 120.0f)];
        thumbImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
      } else {
        
        UIGraphicsBeginImageContext(CGSizeMake(120.0f, 180.0f));
        [image drawInRect:CGRectMake(0, 0, 120.0f, 180.0f)];
        thumbImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
      }
      
      dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.photosCache setObject:thumbImage forKey:photoName];
        cell.photoView.image = thumbImage;
      });
    });
  }
  
  return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  
  return 1;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
  
  
  static NSString *SupplementaryViewIdentifier = @"SupplementaryViewIdentifier";
  
  return [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                            withReuseIdentifier:SupplementaryViewIdentifier
                                                   forIndexPath:indexPath];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
  
  return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  
  return YES;
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  
  [self performSegueWithIdentifier:@"MainSegue" sender:indexPath];
}

@end

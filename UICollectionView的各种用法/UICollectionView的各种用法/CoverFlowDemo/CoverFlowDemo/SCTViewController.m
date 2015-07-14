//
//  SCTViewController.m
//  CoverFlowDemo
//
//  Created by Mugunth on 7/12/12.
//  Copyright (c) 2012 Steinlogic Consulting and Training Pte Ltd. All rights reserved.
//

#import "SCTViewController.h"

#import "MKPhotoCell.h"

#import "MKCoverFlowLayout.h"

@interface SCTViewController ()
@property (strong, nonatomic) NSArray *photosList;
@property (strong, nonatomic) NSCache *photosCache;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@end

@implementation SCTViewController

-(NSString*) photosDirectory {
  
  return [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Photos"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  self.photosList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self photosDirectory] error:nil];
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


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  
  return self.photosList.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *CellIdentifier = @"MKPhotoCell";
  
  MKPhotoCell *cell = (MKPhotoCell*) [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
  
  NSString *photoName = self.photosList[indexPath.row];
  NSString *photoFilePath = [[self photosDirectory] stringByAppendingPathComponent:photoName];
  cell.nameLabel.text =[photoName stringByDeletingPathExtension];
  
  __block UIImage* thumbImage = [self.photosCache objectForKey:photoName];
  cell.photoView.image = thumbImage;
  MKCoverFlowLayout *layout = (MKCoverFlowLayout*) collectionView.collectionViewLayout;
  
  if(!thumbImage) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
      
      UIImage *image = [UIImage imageWithContentsOfFile:photoFilePath];
      float scale = [UIScreen mainScreen].scale;
      UIGraphicsBeginImageContextWithOptions(layout.itemSize, YES, scale);
      [image drawInRect:CGRectMake(0, 0, layout.itemSize.width, layout.itemSize.height)];
      thumbImage = UIGraphicsGetImageFromCurrentImageContext();
      UIGraphicsEndImageContext();
      dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.photosCache setObject:thumbImage forKey:photoName];
        cell.photoView.image = thumbImage;
      });
    });
  }
  
  return cell;
}
@end

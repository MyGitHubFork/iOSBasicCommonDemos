//
//  SCTViewController.m
//  MasonryLayoutDemo
//
//  Created by Mugunth on 15/10/13.
//  Copyright (c) 2013 Steinlogic Consulting and Training Pte Ltd. All rights reserved.
//

#import "SCTViewController.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
@interface SCTViewController ()

@end

@implementation SCTViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
   
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  
  return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *CellIdentifier = @"Cell";
  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier
                                                                         forIndexPath:indexPath];
  cell.backgroundColor = [UIColor redColor];
  return cell;
}

// this will be called if our layout is UICollectionViewFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  
  CGFloat randomHeight = 100 + (arc4random() % 140);
  return CGSizeMake(SCREEN_WIDTH, 275); // 100 to 240 pixels tall
    //return CGSizeMake(100, 100);
}

// this will be called if our layout is MKMasonryViewLayout
- (CGFloat) collectionView:(UICollectionView*) collectionView
                    layout:(MKMasonryViewLayout*) layout
  heightForItemAtIndexPath:(NSIndexPath*) indexPath {
  
  // we will use a random height from 100 - 400
    //return 100;
  CGFloat randomHeight = 100 + (arc4random() % 140);
  return 275;
}

@end

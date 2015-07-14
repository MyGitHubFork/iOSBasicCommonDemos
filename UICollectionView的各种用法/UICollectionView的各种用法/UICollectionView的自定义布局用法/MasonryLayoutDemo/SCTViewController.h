//
//  SCTViewController.h
//  MasonryLayoutDemo
//
//  Created by Mugunth on 15/10/13.
//  Copyright (c) 2013 Steinlogic Consulting and Training Pte Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MKMasonryViewLayout.h"

@interface SCTViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate, MKMasonryViewLayoutDelegate, UICollectionViewDelegateFlowLayout>

@end

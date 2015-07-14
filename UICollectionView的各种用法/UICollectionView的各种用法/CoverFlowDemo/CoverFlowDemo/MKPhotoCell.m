//
//  MKFlagsCell.m
//  CollectionViewTest
//
//  Created by Mugunth on 4/9/12.
//  Copyright (c) 2012 Steinlogic Consulting and Training. All rights reserved.
//

#import "MKPhotoCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation MKPhotoCell

-(void) awakeFromNib {
  
  self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
  self.selectedBackgroundView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
  
  self.photoView.layer.borderColor = [[UIColor whiteColor] CGColor];
  self.photoView.layer.borderWidth = 5.0f;

  [super awakeFromNib];
}
@end

//
//  CountryCustomCell.m
//  DP1
//
//  Created by Umakanta on 12/11/13.
//  Copyright (c) 2013 THBS. All rights reserved.
//

#import "CountryCustomCell.h"

@implementation CountryCustomCell
@synthesize countryName;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        countryName=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 300, 40)];
        countryName.backgroundColor=[UIColor clearColor];
        countryName.textAlignment=NSTextAlignmentLeft;
        countryName.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0];
        countryName.minimumScaleFactor=0.75f;
                
        
        [self.contentView addSubview:countryName];        
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

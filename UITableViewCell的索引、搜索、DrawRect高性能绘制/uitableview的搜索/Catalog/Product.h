//
//  Product.h
//  Catalog
//
//  Created by Patrick Alessi on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject {
    
}

@property (nonatomic) int ID;
@property (retain, nonatomic) NSString *name;
@property (retain, nonatomic) NSString *manufacturer;
@property (retain, nonatomic) NSString *details;
@property (nonatomic) float price;
@property (nonatomic) int quantity;
@property (retain, nonatomic) NSString *countryOfOrigin;
@property (retain, nonatomic) NSString *image;
@property NSInteger section;

@end

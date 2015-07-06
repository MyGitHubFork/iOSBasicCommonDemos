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
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *manufacturer;
@property (strong, nonatomic) NSString *details;
@property (nonatomic) float price;
@property (nonatomic) int quantity;
@property (strong, nonatomic) NSString *countryOfOrigin;
@property (strong, nonatomic) NSString *image;

@end

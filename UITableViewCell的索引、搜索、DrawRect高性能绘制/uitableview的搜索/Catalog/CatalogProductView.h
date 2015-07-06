//
//  CatalogProductView.h
//  Catalog
//
//  Created by Patrick Alessi on 9/6/12.
//
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface CatalogProductView : UIView {
    Product* theProduct;
}

- (void)setProduct:(Product *)inputProduct;

@end


//
//  CatalogTableViewCell.h
//  Catalog
//
//  Created by Patrick Alessi on 9/6/12.
//
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "CatalogProductView.h"

@interface CatalogTableViewCell : UITableViewCell {

}

@property (nonatomic,strong) CatalogProductView* catalogProductView;

- (void)setProduct:(Product *)theProduct;

@end

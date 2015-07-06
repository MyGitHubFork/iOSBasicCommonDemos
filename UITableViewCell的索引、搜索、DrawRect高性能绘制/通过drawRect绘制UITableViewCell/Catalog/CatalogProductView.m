//
//  CatalogProductView.m
//  Catalog
//
//  Created by Patrick Alessi on 9/6/12.
//
//

#import "CatalogProductView.h"

@implementation CatalogProductView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //透明
        self.opaque = YES;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setProduct:(Product *)inputProduct
{
    // If a different product is passed in...
    if (theProduct != inputProduct)
    {
        theProduct = inputProduct;
    }
    
    // Mark the view to be redrawn
    [self setNeedsDisplay];
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    // Draw the product text
    [theProduct.name drawAtPoint:CGPointMake(45.0,0.0)
                        forWidth:120
                        withFont:[UIFont systemFontOfSize:18.0]
                     minFontSize:12.0
                  actualFontSize:NULL
                   lineBreakMode:UILineBreakModeTailTruncation
              baselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    
    // Set to draw in dark gray
    [[UIColor darkGrayColor] set];
    
    // Draw the manufacturer label
    [theProduct.manufacturer drawAtPoint:CGPointMake(45.0,25.0)
                                forWidth:120
                                withFont:[UIFont systemFontOfSize:12.0]
                             minFontSize:12.0
                          actualFontSize:NULL
                           lineBreakMode:UILineBreakModeTailTruncation
                      baselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    
    // Set to draw in black
    [[UIColor blackColor] set];
    
    // Draw the price label
    [[[NSNumber numberWithFloat: theProduct.price] stringValue]
     drawAtPoint:CGPointMake(200.0,10.0)
     forWidth:60
     withFont:[UIFont systemFontOfSize:16.0]
     minFontSize:10.0
     actualFontSize:NULL
     lineBreakMode:UILineBreakModeTailTruncation
     baselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    
    // Draw the images
    NSString *filePath = [[NSBundle mainBundle]
                          pathForResource:theProduct.image ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    [image drawInRect:CGRectMake(0.0, 0.0, 40.0, 40.0)];
    
    filePath = [[NSBundle mainBundle]
                pathForResource:theProduct.countryOfOrigin ofType:@"png"];
    image = [UIImage imageWithContentsOfFile:filePath];
    [image drawInRect:CGRectMake(260.0, 10.0, 20.0, 20.0)];
}

@end

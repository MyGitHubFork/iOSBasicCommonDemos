//
//  DBAccess.h
//  Catalog
//
//  Created by Patrick Alessi on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

// This includes the header for the SQLite library.
#import <sqlite3.h>
#import "Product.h"

@interface DBAccess : NSObject {
    
    
}

- (NSMutableArray*) getAllProducts;
- (void) closeDatabase;
- (void)initializeDatabase;

@end


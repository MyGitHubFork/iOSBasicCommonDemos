//
//  wordVC.h
//  weiboTail
//
//  Created by Colin on 14-9-7.
//  Copyright (c) 2014年 icephone. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YouMiView.h"

@interface wordVC : UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
{
    UITableView *myTableView;
    NSMutableArray *resultArr;
    UISearchBar* searchBarReagion;
    
    NSMutableArray *filteredArr;
    
    BOOL isSearchActiveDM;

    NSString *appKey;
    NSString *appName;
}


@end

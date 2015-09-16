//
//  ViewController.h
//  DP1
//
//  Created by Umakanta on 11/11/13.
//  Copyright (c) 2013 THBS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavStackViewController : UIViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>{

    BOOL isSearchActiveFM,isSearchActiveDM;
    
    //--- customozing---
    UIFont *headerLabelFont;
    UIColor *headerLabelColor;
    UIFont *selectedHeaderLabelFont;
    UIColor *selectedHeaderLabelColor;
    UIColor *headerBackGroundColor,*selectedHeaderBackGroundColor;
    UIColor *headerSeparatorColor;
    
}

@property(nonatomic,retain) NSDictionary *jsonDictionary;


@property(nonatomic,retain) NSArray *allRegionArr;
@property(nonatomic,retain) NSMutableArray *filteredRegionArr;
@property(nonatomic,retain) UIScrollView *mainScrollView;
@property (nonatomic) UISearchBar* searchBarReagion;

@property(nonatomic,strong) UITableView *countryTbl;
@property(nonatomic,strong) NSMutableArray *allCountryArr,*filteredCountryArr;
@property(nonatomic,strong) NSString *clickedCountryName;
@property(nonatomic,strong) NSString *clickedKey;


//---set customozing---

-(void)setHeaderLabelFont:(UIFont *)font;
-(void)setHeaderLabelColor:(UIColor *)color;
-(void)setSelectedHeaderLabelFont:(UIFont *)font;
-(void)setSelectedHeaderLabelColor:(UIColor *)color;
-(void)setHeaderBackGroundColor:(UIColor *)color;
-(void)setSelectedHeaderBackGroundColor:(UIColor *)color;
-(void)setHeaderSeparatorColor:(UIColor *)color;
@end

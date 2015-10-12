//
//  ViewController.m
//  DP1
//
//  Created by Umakanta on 11/11/13.
//  Copyright (c) 2013 THBS. All rights reserved.
//

typedef enum _THBSState {
    STATE_FULL_MENU,
    STATE_DETAILS_MENU
} THBSState;

#define EACH_MODEL_HEIGHT 50.0

#import "NavStackViewController.h"
#import "ControllerView.h"
#import "CountryCustomCell.h"

@interface NavStackViewController ()

@property (nonatomic,assign) THBSState state;
@end

CGRect fromPosition;

UIImageView *imview;
UILabel *label;
NSString *headerSearchedString;
NSDictionary *custDictinary;



@implementation NavStackViewController
@synthesize mainScrollView,searchBarReagion;
@synthesize jsonDictionary;
@synthesize allRegionArr,filteredRegionArr;
@synthesize countryTbl;
@synthesize allCountryArr,filteredCountryArr,clickedCountryName, clickedKey;




#pragma mark
#pragma mark SearchBar Delegate 

- (void) searchBarTextDidBeginEditing: (UISearchBar*) searchBar {
    
    [searchBarReagion setShowsCancelButton: YES animated: YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    //NSLog(@"self.state = %d",self.state);
    
    if (self.state == STATE_FULL_MENU) {
        
        headerSearchedString = searchText;
        isSearchActiveFM = TRUE;
        [self.filteredRegionArr removeAllObjects];
        for (NSString *s in allRegionArr) {
            
            NSRange result=[s rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if(result.length>0) {
                
                [self.filteredRegionArr addObject:s];
            }
        }
        
        [self drawAllViewsOnScrollview:filteredRegionArr];
    }
    else if (self.state == STATE_DETAILS_MENU) {
        
        isSearchActiveDM = TRUE;
        [self.filteredCountryArr removeAllObjects];
        
        for (int i=0; i<allCountryArr.count; i++) {
            NSDictionary *countryDictinary = [allCountryArr objectAtIndex:i];
            NSRange result=[[countryDictinary objectForKey:@"subheadingName"] rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if(result.length>0) {
                
                [self.filteredCountryArr addObject:countryDictinary];
            }

        }
        
        [countryTbl reloadData];
        
    }
    
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    if (self.state == STATE_FULL_MENU) {
        mainScrollView.scrollEnabled = TRUE;
        
        [searchBarReagion resignFirstResponder];
        [searchBarReagion setShowsCancelButton: NO animated: YES];
    }
    else if (self.state == STATE_DETAILS_MENU) {
    
        [searchBarReagion resignFirstResponder];
        [searchBarReagion setShowsCancelButton: NO animated: YES];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar{
    
    if (self.state == STATE_FULL_MENU) {
        mainScrollView.scrollEnabled = TRUE;
        headerSearchedString = @"";
        
        isSearchActiveFM = FALSE;
        searchBarReagion.text = @"";
        [searchBarReagion setShowsCancelButton: NO animated: YES];
        [searchBarReagion resignFirstResponder];
        [self drawAllViewsOnScrollview:allRegionArr];
    }
    else if (self.state == STATE_DETAILS_MENU) {
    
        isSearchActiveDM = FALSE;
        searchBarReagion.text = @"";
        [searchBarReagion setShowsCancelButton: NO animated: YES];
        [searchBarReagion resignFirstResponder];
        
        [countryTbl reloadData];
    }
}


#pragma mark
#pragma mark Life Cycle Method

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    

    
    headerSearchedString = @"";
    filteredRegionArr = [[NSMutableArray alloc]init];
    filteredCountryArr = [[NSMutableArray alloc]init];
    custDictinary = @{@"headerLabelFont": headerLabelFont,@"headerLabelColor": headerLabelColor,@"headerBackGroundColor": headerBackGroundColor,@"headerSeparatorColor": headerSeparatorColor};
    
    
    self.title = @"手机型号";
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        searchBarReagion = [[UISearchBar alloc] initWithFrame:CGRectMake(0,64,320,44)];
    }
    else{
    
        searchBarReagion = [[UISearchBar alloc] initWithFrame:CGRectMake(0,0,320,44)];
    }

    
    
    searchBarReagion.placeholder = @"搜索";
    searchBarReagion.delegate = self;
    
    CGFloat screenheight=[[UIScreen mainScreen]bounds].size.height;
    
    float sbMaxYPt = CGRectGetMaxY(searchBarReagion.frame);
    
    
    CGFloat scrollheight= screenheight - sbMaxYPt;
    mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,sbMaxYPt,320,scrollheight)];
    mainScrollView.backgroundColor = [UIColor whiteColor];
    
    
    
    
    [self.view addSubview:searchBarReagion];
    [self.view addSubview:mainScrollView];

    
    [self getAllKeys:jsonDictionary];

    
    
}

-(void)getAllKeys:(NSDictionary *)mDict{
    
    
    //allRegionArr =  [[mDict allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    allRegionArr =  [mDict allKeys];
    
    [self drawAllViewsOnScrollview:allRegionArr];
   
}

#pragma mark -
#pragma mark Customization Method

-(void)setHeaderLabelFont:(UIFont *)font{
    headerLabelFont = font;
}
-(void)setHeaderLabelColor:(UIColor *)color{
    headerLabelColor = color;
}
-(void)setHeaderBackGroundColor:(UIColor *)color{
    headerBackGroundColor = color;
}

-(void)setSelectedHeaderLabelFont:(UIFont *)font{
    selectedHeaderLabelFont = font;
}
-(void)setSelectedHeaderLabelColor:(UIColor *)color{
    selectedHeaderLabelColor = color;
}
-(void)setSelectedHeaderBackGroundColor:(UIColor *)color{
    selectedHeaderBackGroundColor = color;
}
-(void)setHeaderSeparatorColor:(UIColor *)color{
    headerSeparatorColor = color;
}




-(void)drawAllViewsOnScrollview :(NSArray *)drawArr{

    
    
    
    [mainScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    int yPos = 0;
    
    for (int i=0; i<drawArr.count; i++) {
        
        
        NSString *name = [drawArr objectAtIndex:i];
        
                
        ControllerView *contFullview = [[ControllerView alloc]initWithFrame:(CGRectMake(0, yPos, 320, EACH_MODEL_HEIGHT)) withTitle:name withCustomizationDict:custDictinary];
        [mainScrollView addSubview:contFullview];
        
       
        [contFullview.optionBtn addTarget:self action:@selector(optionBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [contFullview.dummyBtn addTarget:self action:@selector(dummyBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        yPos += EACH_MODEL_HEIGHT;
    }
    
    float sizeOfContent = 0;
    UIView *lLast = [mainScrollView.subviews lastObject];
    NSInteger wd = lLast.frame.origin.y;
    NSInteger ht = lLast.frame.size.height;
    sizeOfContent = wd+ht;
    mainScrollView.contentSize = CGSizeMake(mainScrollView.frame.size.width, sizeOfContent);
    
    
}









#pragma mark
#pragma mark Expanding

-(IBAction)dummyBtnPressed:(id)sender {
    
        
    searchBarReagion.text = @"";
    [searchBarReagion resignFirstResponder];
    [searchBarReagion setShowsCancelButton: NO animated: YES];
    
    fromPosition = [sender superview].frame;
    
    float mid_clicked = CGRectGetMidY([sender superview].frame);
    
    float scrollViewContentHeight = [(UIScrollView *)[[sender superview] superview] contentSize].height +50;
    
    
    for (UIView* view in [[[sender superview] superview] subviews]) {
        
        float mid_view = CGRectGetMidY(view.frame);
        
        if([view isKindOfClass:[ControllerView class]] && (mid_view < mid_clicked))
        {
            int diff_factor = (mid_clicked-mid_view)/EACH_MODEL_HEIGHT;
            
            
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionTransitionCrossDissolve|UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionAllowAnimatedContent animations:^{
                
                view.frame = CGRectMake(0, -50*diff_factor, 320, 50);
                
            } completion:^(BOOL finished) {
                self.state = STATE_DETAILS_MENU;
                
            }];
        }
        else if([view isKindOfClass:[ControllerView class]] && (mid_view == mid_clicked))
        {
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionTransitionCrossDissolve|UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionAllowAnimatedContent animations:^{
                
                view.frame = CGRectMake(0, mainScrollView.contentOffset.y, 320, 50);
                view.backgroundColor = selectedHeaderBackGroundColor;
               
                
            } completion:^(BOOL finished) {
                self.state = STATE_DETAILS_MENU;
                mainScrollView.scrollEnabled = FALSE;
            }];
            
            
            [UIView animateWithDuration:0.4 delay:0.1 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionTransitionCrossDissolve|UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionAllowAnimatedContent animations:^{
                
                
                //resize inside the view
                for (UIView* view in [[sender superview] subviews]) {
                    if([view isKindOfClass:[UILabel class]])
                    {
                        UILabel* label = (UILabel*)view;
                        if (label.tag == 1) {
                            
                            label.frame = CGRectMake(120, 5, 155, 35);
                            label.font = selectedHeaderLabelFont;
                            label.textColor = selectedHeaderLabelColor;
                            
                            //label.minimumScaleFactor=0.75f;
                            //label.adjustsFontSizeToFitWidth = YES;
                           
                            clickedCountryName = label.text;
                            allCountryArr = [[NSMutableArray alloc]init];
                            NSDictionary *fDict = [jsonDictionary objectForKey:label.text];
                            allCountryArr = [fDict objectForKey:@"subheadingArr"];
                            
                            
                        }
                        
                    }
                    else if([view isKindOfClass:[UIButton class]]){
                        
                        UIButton *button = (UIButton*)view;
                        
                        if (button.tag == 4) {
                            
                            button.hidden = NO;
                        }
                        else if (button.tag == 6) {
                            
                            button.userInteractionEnabled = NO;
                        }
                    }
                    else if([view isKindOfClass:[UIImageView class]]){
                        
                        UIImageView *imageView = (UIImageView*)view;
                        if (imageView.tag == 5) {
                            
                            imageView.hidden = NO;
                            imageView.frame=CGRectMake(2, 5, 50, 40);
                            
                            //imageView.image= [UIImage imageNamed:@"carModelPlaceHolder.png"];
                        
                            
                            
                        }
                    }
                }
                
                
                
            } completion:^(BOOL finished) {
                self.state = STATE_DETAILS_MENU;
                mainScrollView.scrollEnabled = FALSE;
               
                
            }];
            
            
            
            
            
        }
        else if([view isKindOfClass:[ControllerView class]] && (mid_view > mid_clicked))
        {
            
            int diff_factor = (mid_view-mid_clicked)/EACH_MODEL_HEIGHT;
            
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionTransitionCrossDissolve|UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionAllowAnimatedContent animations:^{
                
                view.frame = CGRectMake(0, scrollViewContentHeight+diff_factor*EACH_MODEL_HEIGHT, 320, 50);
                
            } completion:^(BOOL finished) {
                self.state = STATE_DETAILS_MENU;
            }];
        }
    }
    
    
    
    [self loadHeadingData:clickedCountryName withSubHeadings:allCountryArr withFrame:fromPosition];
    
}

-(void)loadHeadingData:(NSString *)headingName withSubHeadings:(NSMutableArray *)subHeadingArray withFrame:(CGRect)clickedFrame{

    
    CGFloat screenheight=[[UIScreen mainScreen]bounds].size.height;
    CGFloat tableheight= screenheight - (64+44+EACH_MODEL_HEIGHT);
    
    countryTbl=[[UITableView alloc]initWithFrame:CGRectMake(0.0, CGRectGetMaxY(clickedFrame), 320.0, tableheight) style:UITableViewStylePlain];
    countryTbl.delegate=self;
    countryTbl.dataSource=self;
    
    CGRect frame = countryTbl.frame;
    frame.size.height = countryTbl.contentSize.height;
    countryTbl.frame = frame;
    
    countryTbl.rowHeight=50.0;
    countryTbl.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    countryTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    

    [mainScrollView addSubview:countryTbl];
    //[mainScrollView sendSubviewToBack:countryTbl];

    
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionTransitionCrossDissolve|UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionAllowAnimatedContent animations:^{
        
        countryTbl.frame = CGRectMake(0, mainScrollView.contentOffset.y+EACH_MODEL_HEIGHT, 320, tableheight);
        
    } completion:^(BOOL finished) {
        self.state = STATE_DETAILS_MENU;
        searchBarReagion.placeholder = [NSString stringWithFormat:@"在 %@ 中搜索",headingName];
    }];
    
}


#pragma mark
#pragma mark TableView DataSource & Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    
    if (isSearchActiveDM) {
        return [filteredCountryArr count];
    }else{
        return [allCountryArr count];
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"CellIdentifier";
    CountryCustomCell *customCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (customCell == nil) {
        customCell = [[CountryCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        customCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSDictionary *countryDictinary;
    if (isSearchActiveDM) {
        
        countryDictinary = [filteredCountryArr objectAtIndex:indexPath.row];
    }else{
        
        countryDictinary = [allCountryArr objectAtIndex:indexPath.row];
        
    }

    customCell.countryName.text = [countryDictinary objectForKey:@"subheadingName"];
    customCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    
    return customCell;
}







-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSDictionary *countryDictinary;
    if (isSearchActiveDM) {
        
        countryDictinary = [filteredCountryArr objectAtIndex:indexPath.row];
    }else{
        
        countryDictinary = [allCountryArr objectAtIndex:indexPath.row];
        
    }    
}


#pragma mark
#pragma mark Squzing
-(IBAction)optionBtnPressed:(id)sender {
    
    [self searchBarCancelButtonClicked:searchBarReagion];

   
    if (![headerSearchedString isEqualToString:@""]) {
        
        searchBarReagion.text = headerSearchedString;
        [searchBarReagion becomeFirstResponder];
        [searchBarReagion setShowsCancelButton: YES animated: YES];
    }else{
        
        searchBarReagion.text = @"";
        headerSearchedString = @"";
    
    }
    
    
    mainScrollView.scrollEnabled = TRUE;
    
    
    int yPos = 0;
    
    for (UIView* view in [[[sender superview] superview] subviews]) {
        if([view isKindOfClass:[ControllerView class]])
        {
            
            [UIView animateWithDuration:0.4 delay:0.1 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionTransitionCrossDissolve|UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionAllowAnimatedContent animations:^{
                
                view.frame = CGRectMake(0, yPos, 320, 50);
                
                if (view == [sender superview]) {
                   
                    view.backgroundColor = headerBackGroundColor;
                    
                    //resizeBack inside the view
                    for (UIView* subView in [view subviews]) {
                        
                        if([subView isKindOfClass:[UILabel class]])
                        {
                            
                            UILabel* label = (UILabel*)subView;
                            if (label.tag == 1) {
                                
                                label.frame = CGRectMake(20, 5, 160, 35);
                                label.font = headerLabelFont;
                                label.textColor = headerLabelColor;
                                
                            }
                            else if (label.tag == 2) {
                                
                                label.frame = CGRectMake(220, 10, 30, 30);
                                label.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0];
                                label.layer.cornerRadius = 15.0;
                            }
                        }
                        else if([subView isKindOfClass:[UIButton class]]){
                            
                            UIButton *button = (UIButton*)subView;
                            if (button.tag == 3) {
                                button.frame=CGRectMake(270, 12, 25, 25);
                                button.userInteractionEnabled = YES;
                            }
                            else if (button.tag == 4) {
                                
                                button.hidden = YES;
                            }
                            else if (button.tag == 6) {
                                
                                button.userInteractionEnabled = YES;
                            }
                        }
                        else if([subView isKindOfClass:[UIImageView class]]){
                            
                            UIImageView *imageView = (UIImageView*)subView;
                            if (imageView.tag == 5) {
                                
                                imageView.hidden = YES;
                            }
                            
                        }
                    }
                }
                

            } completion:^(BOOL finished) {
                self.state = STATE_FULL_MENU;
                self.title = @"手机型号";
                searchBarReagion.placeholder = @"搜索";
                
            }];
        }
        yPos += EACH_MODEL_HEIGHT;
        
     }
    
    [mainScrollView sendSubviewToBack:countryTbl];
    [NSTimer scheduledTimerWithTimeInterval: 0.2 target: self selector: @selector(callAfterFewSecond:) userInfo:nil repeats: NO];
    
    
    //[countryTbl removeFromSuperview];
}


-(void) callAfterFewSecond:(NSTimer*)t
{
    [countryTbl removeFromSuperview];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

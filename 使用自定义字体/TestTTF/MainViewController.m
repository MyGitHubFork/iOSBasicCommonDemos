//
//  MainViewController.m
//  TestTTF
//
//  Created by yunfenghan Ling on 13-3-15.
//  Copyright (c) 2013年 yunfenghan Ling. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
//    NSArray * fontArrays = [[NSArray alloc] initWithArray:[UIFont familyNames]];
//    for (NSString * temp in fontArrays) {
//        NSLog(@"Font name  = %@", temp);
//    }
    
    NSArray *familyNames = [UIFont familyNames];
    
    for( NSString *familyName in familyNames ){
        
        printf( "Family: %s \n", [familyName UTF8String] );
        
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        
        for( NSString *fontName in fontNames ){
            
            printf( "\tFont: %s \n", [fontName UTF8String] );
            
        }  
        
    }
    
    UILabel * tempOneLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 300, 40)];
    UIFont * fontOne = [UIFont fontWithName:@"HanWangKaiBold-Gb5" size:15];
    [tempOneLabel setFont:fontOne];
    [tempOneLabel setText:@"这是新字体吗_Two----->汉王粗楷体"];
    [self.view addSubview:tempOneLabel];
    
    //
    UILabel * tempTwoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 300, 40)];
    UIFont * fontTwo = [UIFont fontWithName:@"经典细圆简" size:15];
    [tempTwoLabel setFont:fontTwo];
    [tempTwoLabel setText:@"这是新字体——ONe----->经典细圆简"];
    [self.view addSubview:tempTwoLabel];
    
    UILabel * tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 150, 300, 40)];
    [tempLabel setFont:[UIFont systemFontOfSize:15]];
    [tempLabel setText:@"这是默认字体---ONe--->默认字体"];
    [self.view addSubview:tempLabel];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ViewController.m
//  CoreText杂志应用
//
//  Created by yifan on 15/8/20.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "ViewController.h"
#import "CTView.h"
#import "MarkupParser.h"

#warning http://www.oschina.net/translate/how-to-create-a-simple-magazine-app-with-core-text?lang=chs&page=1#

#warning http://www.raywenderlich.com/4147/core-text-tutorial-for-ios-making-a-magazine-app
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"zombies" ofType:@"txt"];
    NSString* text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    MarkupParser* p = [[MarkupParser alloc] init];
    NSAttributedString* attString = [p attrStringFromMarkup: text];
    //[(CTView*)self.view setAttString: attString];
    [(CTView *)[self view] setAttString:attString withImages: p.images];
    [(CTView *)[self view] buildFrames];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

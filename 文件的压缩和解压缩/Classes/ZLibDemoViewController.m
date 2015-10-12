//
//  ZLibDemoViewController.m
//  ZLibDemo
//
//  Created by  JM on 11-1-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ZLibDemoViewController.h"
#import "zlib.h"
#import "ZipArchive.h"

@implementation ZLibDemoViewController
@synthesize imageView;


#warning 把文件先解压存放，然后再去加载存放好的文件
-(IBAction)unZip{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"11.zip" ofType:nil];
    BOOL result;
    ZipArchive *za = [[ZipArchive alloc] init];
    if ([za UnzipOpenFile:filePath]) {
        result = [za UnzipFileTo:[self dataFilePath:@"2014"] overWrite:YES];
        [za UnzipCloseFile];
    }
    [za release];
    if (result) {
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:[self dataFilePath:@"2014/11.jpg"]];
        imageView.image = image;
        [image release];
    }
    
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"xx.jpg" ofType:nil];
//    BOOL result;
//    ZipArchive *za = [[ZipArchive alloc] init];
//    [za CreateZipFile2:filePath Password:@"111"];
//    
//    [za CloseZipFile2];
    
}

-(NSString *)dataFilePath:(NSString *)fileName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
    [super dealloc];
}

@end

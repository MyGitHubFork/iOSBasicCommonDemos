//
//  ZLibDemoViewController.h
//  ZLibDemo
//
//  Created by  JM on 11-1-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLibDemoViewController : UIViewController {
    UIImageView *imageView;
}
@property(nonatomic,retain)IBOutlet UIImageView *imageView;
-(IBAction)unZip;
-(NSString *)dataFilePath:(NSString *)fileName;
@end


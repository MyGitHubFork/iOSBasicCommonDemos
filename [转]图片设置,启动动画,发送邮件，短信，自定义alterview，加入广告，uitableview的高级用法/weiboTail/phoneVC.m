//
//  phoneVC.m
//  weiboTail
//
//  Created by Colin on 14-9-7.
//  Copyright (c) 2014年 icephone. All rights reserved.
//

#import "phoneVC.h"
#import "webVC.h"

@interface phoneVC ()

@end

@implementation phoneVC

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
    
    
    //Initialize the controller data
    NSString* plistPath = [[NSBundle mainBundle] pathForResource: @"NavStackControllerData"
                                                          ofType: @"plist"];
    // Build the array from the plist
    self.jsonDictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    //customizing..
    [self setHeaderLabelFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f]];
    [self setHeaderLabelColor:[UIColor blackColor]];
    [self setHeaderBackGroundColor:[UIColor whiteColor]];
    
    [self setSelectedHeaderLabelFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0f]];
    [self setSelectedHeaderLabelColor:[UIColor blackColor]];
    [self setSelectedHeaderBackGroundColor:[UIColor whiteColor]];
    
    [self setHeaderSeparatorColor:[UIColor lightGrayColor]];
    
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    appKey = [[[[self.jsonDictionary objectForKey:self.clickedCountryName]objectForKey:@"subheadingArr"]objectAtIndex:indexPath.row]objectForKey:@"subheadingKey"];
    appName = [[[[self.jsonDictionary objectForKey:self.clickedCountryName]objectForKey:@"subheadingArr"]objectAtIndex:indexPath.row]objectForKey:@"subheadingName"];
    
    [self performSegueWithIdentifier:@"phonePushToWeb" sender:self];
}


//modal跳转响应函数 PicBack 是modal的identify
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"phonePushToWeb"])
    {
        webVC *webView = segue.destinationViewController;
        
        webView.webStr = [NSString stringWithFormat:@"http://widget.weibo.com/topics/topic_vote_base.php?tag=来自微博小尾巴&isshowright=0&language=zh_cn&dup=1&antispam=1&isOutTopicSearch=2&border=0&version=base&footbar=0&app_src=%@", appKey];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ViewController.m
//  TestLayerImage
//
//  Created by lcc on 14-7-31.
//  Copyright (c) 2014年 lcc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
{
    UIScrollView *imgScrollView;
    CGRect imgRect;
    UIImageView *scrollImageView;
    UIView *markView;
    
    UIImageView *xxx;
}

@end

@implementation ViewController

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
    
    
    UIImage *image = [UIImage imageNamed:@"1.jpg"];
    
    imgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [self.view addSubview:imgScrollView];
    imgScrollView.backgroundColor = [UIColor clearColor];
    imgScrollView.bouncesZoom = YES;
    imgScrollView.minimumZoomScale = 1.0;
    imgScrollView.delegate = self;
    imgScrollView.contentSize = imgScrollView.frame.size;
    
    markView = [[UIView alloc] initWithFrame:imgScrollView.bounds];
    markView.backgroundColor = [UIColor blackColor];
    markView.alpha = 0;
    
    scrollImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    scrollImageView.image = image;
    scrollImageView.contentMode = UIViewContentModeScaleAspectFill;
    scrollImageView.clipsToBounds = YES;
    [self.view addSubview:scrollImageView];
    
    imgRect = scrollImageView.frame;
    
    xxx = [[UIImageView alloc] initWithFrame:imgRect];
    xxx.image = image;
    xxx.contentMode = UIViewContentModeScaleAspectFill;
    xxx.clipsToBounds = YES;
    [imgScrollView addSubview:xxx];
    
    [self.view sendSubviewToBack:imgScrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)bigTapped:(id)sender
{
    if (markView.alpha == 0)
    {
        markView.alpha = 1.0;
        [self.view sendSubviewToBack:imgScrollView];
//        [imgScrollView addSubview:scrollImageView];
        
//        xxx = scrollImageView;
        
        [self performSelector:@selector(setAnimation) withObject:nil afterDelay:0.1];
    }
    else
    {
        imgScrollView.zoomScale = 1.0;
        
//        [self.view addSubview:scrollImageView];
        
        [UIView animateWithDuration:0.3 animations:^{
           markView.alpha = 0;
        }];
        
        [UIView animateWithDuration:0.5 animations:^{
            xxx.frame = imgRect;
        } completion:^(BOOL finished) {
        
        }];
        
    }
    
}

- (void) setAnimation
{
    UIImage *image = [UIImage imageNamed:@"1.jpg"];
    
    float tmpFlab = image.size.width/320.0f;
    
    float tmpHeight = image.size.height/tmpFlab;
    
    imgScrollView.maximumZoomScale = 480/tmpHeight;
    
    CGRect rect = CGRectMake(0, self.view.bounds.size.height/2 - tmpHeight/2, 320, tmpHeight);
    [UIView animateWithDuration:0.3 animations:^{
        xxx.frame = rect;
    }];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return xxx;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    
    CGSize boundsSize = scrollView.bounds.size;
    CGRect imgFrame = xxx.frame;
    CGSize contentSize = scrollView.contentSize;
    
    CGPoint centerPoint = CGPointMake(contentSize.width/2, contentSize.height/2);
    
    // center horizontally
    if (imgFrame.size.width <= boundsSize.width)
    {
        centerPoint.x = boundsSize.width/2;
    }
    
    // center vertically
    if (imgFrame.size.height <= boundsSize.height)
    {
        centerPoint.y = boundsSize.height/2;
    }
    
    xxx.center = centerPoint;
    
}

@end

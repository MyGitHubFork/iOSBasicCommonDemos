//
//  MainViewController.m
//  播放视频
//
//  Created by aiteyuan on 15/1/7.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "MainViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface MainViewController ()
@property (nonatomic,strong)MPMoviePlayerController *moviePlayer;
@property(nonatomic,strong)UIButton *playButton;
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
    self.playButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.playButton.frame = CGRectMake(100, 100, 40, 40);
    [self.playButton addTarget:self action:@selector(startplayingVideo:) forControlEvents:UIControlEventTouchUpInside];
    self.playButton.autoresizingMask =
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleRightMargin;
    [self.playButton setTitle:@"开始" forState:UIControlStateNormal];
    [self.view addSubview:self.playButton];
}


-(void)startplayingVideo:(id)paramSender
{
    NSString *str = [@"http://www.hytvu.com.cn/Public/Uploads/video/1409326789.mp4" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:str];
    if (self.moviePlayer != nil) {
        [self stopPlayingVideo:nil];
    }
    self.moviePlayer = [[MPMoviePlayerController alloc]initWithContentURL:url];
    if (self.moviePlayer != nil) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(videofinishplay:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
        self.moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
        [self.view addSubview:self.moviePlayer.view];
        [self.moviePlayer setFullscreen:YES animated:NO];
        [self.moviePlayer play];
    }else{
        NSLog(@"初始化播放器失败");
    }
}

-(void)stopPlayingVideo:(id)paramSender
{
    if (self.moviePlayer !=nil) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
        [self.moviePlayer stop];
        [self.moviePlayer.view removeFromSuperview];
    }
}

-(void)videofinishplay:(NSNotification *)paramNotification
{
    NSNumber *reason =
    paramNotification.userInfo
    [MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
    
    if (reason != nil){
        NSInteger reasonAsInteger = [reason integerValue];
        
        switch (reasonAsInteger){
            case MPMovieFinishReasonPlaybackEnded:{
                break;
            }
            case MPMovieFinishReasonPlaybackError:{
                break;
            }
            case MPMovieFinishReasonUserExited:{
                break;
            }
        }
        [self stopPlayingVideo:nil];
    }
    
}
@end

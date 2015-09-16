//
//  ViewController.m
//  系统震动和声音
//
//  Created by maiyun on 15/4/11.
//  Copyright (c) 2015年 yifan. All rights reserved.
//

#import "ViewController.h"
#import "PlaySound.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)systemshake:(id)sender {
    PlaySound *sound = [[PlaySound alloc] initSystemShake];
    [sound plays];
}

- (IBAction)systemaudio:(id)sender {
    PlaySound *sound = [[PlaySound alloc] initSystemSoundWithName:@"sms-received1" SoundType:@"caf"];
    [sound play];
}
@end

//
//  PlaySound.m
//  系统音效0326.
//
//  Created by aiteyuan on 15/3/26.
//  Copyright (c) 2015年 aiteyuan. All rights reserved.
//

#import "PlaySound.h"


@implementation PlaySound

- (id)initSystemShake
{
    self = [super init];
    if (self) {
        sound = kSystemSoundID_Vibrate;//震动  ipod不支持系统振动
    }
    return self;
}

- (id)initSystemSoundWithName:(NSString *)soundName SoundType:(NSString *)soundType
{
    self = [super init];
    if (self) {
        NSString *path = [NSString stringWithFormat:@"/System/Library/Audio/UISounds/%@.%@",soundName,soundType];
        //[[NSBundle bundleWithIdentifier:@"com.apple.UIKit" ]pathForResource:soundName ofType:soundType];//得到苹果框架资源UIKit.framework ，从中取出所要播放的系统声音的路径
        //[[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];  获取自定义的声音
        if (path) {
            OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&sound);
            
//            if (error != kAudioServicesNoError) {//获取的声音的时候，出现错误
//                sound = nil;
//            }
        }
    }
    return self;
}

- (void)play
{
    AudioServicesPlaySystemSound(sound);
    //AudioServicesPlayAlertSound(sound);
}
- (void)plays
{
     AudioServicesPlaySystemSound(sound);
    //AudioServicesPlayAlertSound(sound);
}

- (void)dealloc
{
    if (sound)
    {
       //AudioServicesDisposeSystemSoundID(sound);
    }
}
@end

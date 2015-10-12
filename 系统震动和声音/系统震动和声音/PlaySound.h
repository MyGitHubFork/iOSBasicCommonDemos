//
//  PlaySound.h
//  系统音效0326.
//
//  Created by aiteyuan on 15/3/26.
//  Copyright (c) 2015年 aiteyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface PlaySound : NSObject

{
    SystemSoundID sound;//系统声音的id 取值范围为：1000-2000
}

- (id)initSystemShake;//系统 震动
- (id)initSystemSoundWithName:(NSString *)soundName SoundType:(NSString *)soundType;//初始化系统声音
- (void)play;//播放

- (void)plays;//播放
@end


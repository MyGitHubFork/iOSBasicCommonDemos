//
//  CoreToast.m
//  Car
//
//  Created by muxi on 15/1/29.
//  Copyright (c) 2015年 muxi. All rights reserved.
//

#import "CoreToast.h"
#import "CRToastManager.h"
#import "CRToast.h"

#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

@implementation CoreToast


+(void)showMsgType:(CoreToastMsgType)msgType msg:(NSString *)msg subMsg:(NSString *)subMsg timeInterval:(NSTimeInterval)timeInterval trigger:(UIView *)trigger apperanceBlock:(void(^)())apperanceBlock completionBlock:(void(^)())completionBlock{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        NSMutableDictionary *dictM=[self settingDict];
        
        NSString *title=msg;
        
        if(msg==nil) title=@"空标题";
        
        //主标题提示
        [dictM addEntriesFromDictionary:@{kCRToastTextKey:title}];
        
        //是否显示子标题提示
        if(subMsg!=nil){
            [dictM addEntriesFromDictionary:@{kCRToastSubtitleTextKey:subMsg}];
        }
        
        //显示图片
        NSArray *imageNameArray=@[@"info",@"error",@"success"];
        NSString *imageName=[NSString stringWithFormat:@"CoreToast.bundle/%@",imageNameArray[msgType]];
        [dictM addEntriesFromDictionary:@{kCRToastImageKey:[UIImage imageNamed:imageName]}];
        
        //显示时间
        [dictM addEntriesFromDictionary:@{kCRToastTimeIntervalKey:@(timeInterval)}];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [CRToastManager showNotificationWithOptions:dictM apperanceBlock:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    //禁用触发控件
                    trigger.userInteractionEnabled=NO;
                    if(apperanceBlock!=nil) apperanceBlock();
                });
            } completionBlock:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    //禁用触发控件
                    trigger.userInteractionEnabled=YES;
                    if(completionBlock!=nil) completionBlock();
                });
            }];
        });
    });
}


+(NSMutableDictionary *)settingDict{

    NSDictionary *settingDict=@{
       
       kCRToastBackgroundColorKey:rgba(192,57,42,.95f),                                              //背景颜色
       
       kCRToastFontKey:[UIFont boldSystemFontOfSize:22.0f],                                            //字体大小
       
       kCRToastTextColorKey:[UIColor whiteColor],                                                      //字体颜色
       
       kCRToastNotificationTypeKey:@(CRToastTypeNavigationBar),                                        //显示样式：导航条
       
       kCRToastNotificationPresentationTypeKey:@(CRToastPresentationTypeCover),                        //动画模式：覆盖/推开
       
       kCRToastTextAlignmentKey:@(NSTextAlignmentCenter),                                              //文字对齐：居中
       
       kCRToastAnimationInDirectionKey:@(CRToastAnimationDirectionRight),                              //进入动画的方向：左
       
       kCRToastAnimationOutDirectionKey:@(CRToastAnimationDirectionRight),                             //进入动画的方向：右
       
       kCRToastAnimationInTypeKey:@(CRToastAnimationTypeSpring),                                       //进入动画的动画类型
       
       kCRToastAnimationOutTypeKey:@(CRToastAnimationTypeGravity),                                     //进入动画的动画类型
       
       kCRToastTextMaxNumberOfLinesKey:@(MAXFLOAT),                                                    //文字行数
       
       kCRToastSubtitleFontKey:[UIFont systemFontOfSize:16.0f],                                        //子标题字体大小
       
       kCRToastSubtitleTextColorKey:[UIColor whiteColor],                                              //字标题字体颜色
       
       kCRToastImageContentModeKey:@(UIViewContentModeCenter),                                         //图片模式
       
       kCRToastInteractionRespondersKey: @[[CRToastInteractionResponder interactionResponderWithInteractionType:CRToastInteractionTypeTap
                                                                                                     automaticallyDismiss:YES
                                                                                                                    block:nil]]
       };
    
    return [NSMutableDictionary dictionaryWithDictionary:settingDict];
}


@end

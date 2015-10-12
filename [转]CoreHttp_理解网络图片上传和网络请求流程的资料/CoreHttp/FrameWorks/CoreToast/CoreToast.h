//
//  CoreToast
//  Car
//
//  Created by muxi on 15/1/29.
//  Copyright (c) 2015年 muxi. All rights reserved.
//  导航条信息提示工具类

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum{
    
    //普通提示类
    CoreToastMsgTypeInfo=0,
    
    //错误
    CoreToastMsgTypeError,
    
    //成功
    CoreToastMsgTypeSuccess
    
}CoreToastMsgType;




@interface CoreToast : NSObject


/**
 *  提示工具
 *
 *  @param msgType         类型
 *  @param msg             标题
 *  @param subMsg          子标题
 *  @param timeInterval    时间
 *  @param trigger         触发控件
 *  @param apperanceBlock  开始回调
 *  @param completionBlock 结束回调
 */
+(void)showMsgType:(CoreToastMsgType)msgType msg:(NSString *)msg subMsg:(NSString *)subMsg timeInterval:(NSTimeInterval)timeInterval trigger:(UIView *)trigger apperanceBlock:(void(^)())apperanceBlock completionBlock:(void(^)())completionBlock;




@end

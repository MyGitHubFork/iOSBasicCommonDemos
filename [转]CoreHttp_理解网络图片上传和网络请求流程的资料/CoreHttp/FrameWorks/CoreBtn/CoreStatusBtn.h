//
//  CoreStatusBtn.h
//  CoreBtn
//
//  Created by 沐汐 on 15-3-2.
//  Copyright (c) 2015年 沐汐. All rights reserved.
//  具有状态的按钮，用来解决网络请求中的界面整体化以及逻辑化
//  本按钮具有各种状态，在网络请求中，在不同的网络请求状态中设置按钮对应的状态达到指示网络请求状态的目的
//  本按钮纯界面显示，不关联任何block过程。



#import "CoreBtn.h"


typedef enum{
    
    //最普通的状态，此状态和CoreBtn是一样的，具有可交互性
    CoreStatusBtnStatusNormal=0,
    
    //处理中
    CoreStatusBtnStatusProgress,
    
    //结果成功
    CoreStatusBtnStatusSuccess,
    
    //结果失败
    CoreStatusBtnStatusFalse,
    
}CoreStatusBtnStatus;



@interface CoreStatusBtn : CoreBtn



/**
 *  状态
 */
@property (nonatomic,assign) CoreStatusBtnStatus status;



/**
 *  提示文字
 */
@property (nonatomic,copy) NSString *msg;




@end

//
//  APPHttp.h
//  4s
//
//  Created by muxi on 15/3/10.
//  Copyright (c) 2015年 muxi. All rights reserved.
//  项目网络请求工具，每个需要都需要根据实际情况来配置

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CoreHttp.h"
#import "CoreStatusBtn.h"

@interface APPHttp : NSObject


/**
 *  GET:
 *  params中可指明参数类型
 */
+(void)getUrl:(NSString *)urlString params:(NSDictionary *)params btn:(CoreStatusBtn *)btn success:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;



/**
 *  POST:
 */
+(void)postUrl:(NSString *)urlString params:(NSDictionary *)params btn:(CoreStatusBtn *)btn success:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;



/**
 *  文件上传
 *  @params: 普通参数
 *  @files : 文件数据，里面装的都是UploadFile对象
 */
+(void)uploadUrl:(NSString *)uploadUrl params:(NSDictionary *)params btn:(CoreStatusBtn *)btn files:(NSArray *)files success:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock;

@end

//
//  APPHttp.m
//  4s
//
//  Created by muxi on 15/3/10.
//  Copyright (c) 2015年 muxi. All rights reserved.
//

#import "APPHttp.h"
#import "CoreToast.h"


@implementation APPHttp

/**
 *  GET:
 *  params中可指明参数类型
 */
+(void)getUrl:(NSString *)urlString params:(NSDictionary *)params btn:(CoreStatusBtn *)btn success:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock{
    
    [CoreHttp getUrl:urlString params:params success:^(id obj) {
        [self success:obj btn:btn successBlock:successBlock errorBlock:errorBlock];
    } errorBlock:^(CoreHttpErrorType errorType) {
        if(errorBlock!=nil) errorBlock(errorType);
        [self error:errorType btn:btn errorMsg:nil];
    }];
}

/**
 *  POST:
 */
+(void)postUrl:(NSString *)urlString params:(NSDictionary *)params btn:(CoreStatusBtn *)btn success:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock{
    
    [CoreHttp postUrl:urlString params:params success:^(id obj) {
        [self success:obj btn:btn successBlock:successBlock errorBlock:errorBlock];
    } errorBlock:^(CoreHttpErrorType errorType) {
        if(errorBlock!=nil) errorBlock(errorType);
        [self error:errorType btn:btn errorMsg:nil];
    }];
}


/**
 *  文件上传
 *  @params: 普通参数
 *  @files : 文件数据，里面装的都是UploadFile对象
 */
+(void)uploadUrl:(NSString *)uploadUrl params:(NSDictionary *)params btn:(CoreStatusBtn *)btn files:(NSArray *)files success:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock{
    [CoreHttp uploadUrl:uploadUrl params:params files:files success:^(id obj) {
        [self success:obj btn:btn successBlock:successBlock errorBlock:errorBlock];
    } errorBlock:^(CoreHttpErrorType errorType) {
        if(errorBlock!=nil) errorBlock(errorType);
        [self error:errorType btn:btn errorMsg:nil];
    }];
}


/**
 *  错误处理
 */
+(void)error:(CoreHttpErrorType)errorType btn:(CoreStatusBtn *)btn errorMsg:(NSString *)errorMsg{
    
    //btn给出状态指示
    if(btn!=nil) btn.status=CoreStatusBtnStatusFalse;
    NSLog(@"来了");
    NSString *msg=(CoreHttpErrorTypeNoNetWork == errorType)?@"无网络连接":@"操作不成功";
    
    NSString *realErrorMsg=errorMsg==nil?@"请稍后重试！":errorMsg;
    NSString *subMsg=(CoreHttpErrorTypeNoNetWork == errorType)?@"请检查网络连接设置":realErrorMsg;
    [CoreToast showMsgType:CoreToastMsgTypeError msg:msg subMsg:subMsg timeInterval:2.0f trigger:nil apperanceBlock:nil completionBlock:nil];
}


/**
 *  数据处理
 */
+(void)success:(id)obj btn:(CoreStatusBtn *)btn successBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock{
    
    if(![obj isKindOfClass:[NSDictionary class]]){
        NSLog(@"数据异常，服务器返回的数据不是字典！");return;
    }
    
    //项目数据处理
    //1.取出状态码
    NSString *status=obj[@"status"];
    
    if(![status isEqualToString:@"success"]){
        
        //服务器抛出错误
        //取出错误信息
        NSString *errorMsg=@"服务器抛出错误";
        id msgObj=obj[@"data"];
        if([msgObj isKindOfClass:[NSString class]]) errorMsg=msgObj;

        [self error:CoreHttpErrorTypeServiceRetrunErrorStatus btn:btn errorMsg:errorMsg];
        return;
    }
    
    //这里才是真正成功的地方
    //状态指示
    if(btn!=nil) btn.status=CoreStatusBtnStatusSuccess;
    
    //剥离数据
    id appObj=obj[@"data"];
    
    successBlock(appObj);
}



@end

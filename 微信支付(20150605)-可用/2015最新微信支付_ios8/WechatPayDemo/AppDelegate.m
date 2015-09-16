//
//  AppDelegate.m
//  WechatPayDemo
//
//  Created by Alvin on 3/22/14.
//  Copyright (c) 2014 Alvin. All rights reserved.
//

#import "AppDelegate.h"
#import "Constant.h"

/**
 *  微信开放平台申请得到的 appid, 需要同时添加在 URL schema
 */
NSString * const WXAppId = @"wxe2c244c0243fbb50";

/**
 * 微信开放平台和商户约定的支付密钥
 * 
 * 注意：不能hardcode在客户端，建议genSign这个过程由服务器端完成
 */
NSString * const WXAppKey = @"yePd1EMqjBHtkIrdraJs0sGtaEjtzbfH8SBuzGqkyBnSZNI5kuu93lSwLO41ctT8RPNi5IPjid9lsjfVP2oRKei4KEZdidxtk41oTRoljCKdhYyhIFieWBw8r4ZLDuqu";

/**
 * 微信开放平台和商户约定的密钥
 * 
 * 注意：不能hardcode在客户端，建议genSign这个过程由服务器端完成
 */
NSString * const WXAppSecret = @"ac41b7eddd9482594feedca01ae9940d";

/**
 * 微信开放平台和商户约定的支付密钥
 * 
 * 注意：不能hardcode在客户端，建议genSign这个过程由服务器端完成
 */
NSString * const WXPartnerKey = @"a2067c2e1a0327a3aa437d76f59b3ac3";

/**
 *  微信公众平台商户模块生成的ID
 */
NSString * const WXPartnerId = @"1220892901";

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [WXApi registerApp:WXAppId];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{    
	return [WXApi handleOpenURL:url delegate:self];
}
//用于完成支付后的程序回调，
- (BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WXApi handleOpenURL:url delegate:self];
}

- (void)onResp:(BaseResp *)resp 
{
    if ([resp isKindOfClass:[PayResp class]]) {
        
        NSString *strTitle = [NSString stringWithFormat:@"支付结果"];
        NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle 
                                                        message:strMsg 
                                                       delegate:self 
                                              cancelButtonTitle:@"OK" 
                                              otherButtonTitles:nil, nil];
        [alert show];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:HUDDismissNotification object:nil userInfo:nil];
    } 
}

@end

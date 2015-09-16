//
//  Constant.h
//  WechatPayDemo
//
//  Created by Alvin on 3/22/14.
//  Copyright (c) 2014 Alvin. All rights reserved.
//

#ifndef WechatPayDemo_Constant_h
#define WechatPayDemo_Constant_h

/**
 *  微信开放平台申请得到的 appid, 同时需要添加在 URL schema
 */
extern NSString * const WXAppId;

/**
 * 微信开放平台和商户约定的支付密钥
 * 
 * 注意：不能hardcode在客户端，建议genSign这个过程由服务器端完成
 */
extern NSString * const WXAppKey;

/**
 * 微信开放平台和商户约定的密钥
 * 
 * 注意：不能hardcode在客户端，建议genSign这个过程由服务器端完成
 */
extern NSString * const WXAppSecret;

/**
 * 微信开放平台和商户约定的支付密钥
 * 
 * 注意：不能hardcode在客户端，建议genSign这个过程由服务器端完成
 */
extern NSString * const WXPartnerKey;

/**
 *  微信公众平台商户模块生成的ID
 */
extern NSString * const WXPartnerId;

/**
 *  隐藏 HUD notification
 */
extern NSString * const HUDDismissNotification;

#endif

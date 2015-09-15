//
//  AddressPickerView.h
//  HaoHaoMaiDemo
//
//  Created by danzhu on 15/4/7.
//  Copyright (c) 2015年 mtrong. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 *  @author danzhu, 15-04-18 14:04:05
 *
 *  地址三级联动视图
 *
 *  @since 1.0
 */
@interface MYAddressPickerView : UIView

- (void)initData;

@property(strong, nonatomic)NSString *storePCDCode;

/*!
 *  @author danzhu, 15-04-18 14:04:37
 *
 *  点击确认按钮，回调
 *
 *  @since 1.0
 */
@property(strong, nonatomic)void (^addressCallback)(NSString *addressCode,NSString *address,NSDictionary *addressDict);

/**
 点击取消按钮，回调
 */
@property(strong, nonatomic)void (^cancelCallback)();

@end

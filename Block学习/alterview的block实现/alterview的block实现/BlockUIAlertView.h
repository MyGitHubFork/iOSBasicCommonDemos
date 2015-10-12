//
//  BlockUIAlertView.h
//  alterview的block实现
//
//  Created by aiteyuan on 14/11/6.
//  Copyright (c) 2014年 艾特远. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ButtonBlock)(NSInteger index);

@interface BlockUIAlertView : UIAlertView

@property(nonatomic,copy)ButtonBlock block;

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                    cancelButtonTitle:(NSString *)cancelButtonTitle
                    otherButtonTitles:(NSString *)otherButtonTitles
                    buttonBlock:(ButtonBlock)block;
@end

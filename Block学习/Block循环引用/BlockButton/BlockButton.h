//
//  BlockButton.h
//  BlockButton
//
//  Created by aiteyuan on 14/11/3.
//  Copyright (c) 2014年 黄成都. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BlockButton;
#warning 申明一个block类型
typedef void (^TouchBlock)(BlockButton *);

@interface BlockButton : UIButton

#warning 全局block要用copy，这样会将block从堆复制到栈里面。
@property(nonatomic, copy)TouchBlock block;

@end

//
//  HCDTestCell.h
//  TableViewCell左滑菜单自定义
//
//  Created by huangchengdu on 16/1/15.
//  Copyright © 2016年 huangchengdu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface HCDTestCell : UITableViewCell
/**标记左滑菜单是否打开*/
@property(nonatomic,assign,readonly)BOOL isOpen;
/**测试文字*/
@property(nonatomic,strong)UILabel *testLb;
/**取消关注的回调*/
@property(nonatomic,copy)void (^cancelCallBack)();
/**删除的回调*/
@property(nonatomic,copy)void (^deleteCallBack)();
/***左后滑动的回调*/
@property(nonatomic,copy)void (^swipCallBack)();



/**
 *  关闭左滑菜单
 *  completionHandle 完成后的回调
 */
-(void)closeMenuWithCompletionHandle:(void (^)(void))completionHandle;
@end

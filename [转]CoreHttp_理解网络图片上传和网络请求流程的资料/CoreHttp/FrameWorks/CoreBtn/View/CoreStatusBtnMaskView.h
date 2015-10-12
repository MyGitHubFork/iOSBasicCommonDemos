//
//  CoreStatusBtnMaskView.h
//  CoreBtn
//
//  Created by 沐汐 on 15-3-2.
//  Copyright (c) 2015年 沐汐. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreStatusBtn.h"

@interface CoreStatusBtnMaskView : UIView

/**
 *  状态
 */
@property (nonatomic,assign) CoreStatusBtnStatus status;


/**
 *  提示文字
 */
@property (nonatomic,copy) NSString *msg;

@property (nonatomic,weak) CoreStatusBtn *statusBtn;




/**
 *  maskView
 */
+(instancetype)maskView;



@end

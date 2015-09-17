//
//  CoreStatusBtn.m
//  CoreBtn
//
//  Created by 沐汐 on 15-3-2.
//  Copyright (c) 2015年 沐汐. All rights reserved.
//

#import "CoreStatusBtn.h"
#import "CoreStatusBtnMaskView.h"
#import "AnimForCoreBtn.h"

@interface CoreStatusBtn ()

//遮罩层
@property (nonatomic,strong) CoreStatusBtnMaskView *maskView;

@end


@implementation CoreStatusBtn



-(void)setStatus:(CoreStatusBtnStatus)status{

    dispatch_async(dispatch_get_main_queue(), ^{
        
        _status=status;
        
        self.enabled=(CoreStatusBtnStatusNormal==status || CoreStatusBtnStatusSuccess==status);
        
        if(status==CoreStatusBtnStatusFalse){
            //执行一个失败动画
            [self.layer addAnimation:[AnimForCoreBtn shake] forKey:@"shake"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.status=CoreStatusBtnStatusNormal;
            });
        }
        
        self.maskView.status=status;
    });
}



-(void)setMsg:(NSString *)msg{
    
    _msg=msg;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.maskView.msg=msg;
    });
}


-(CoreStatusBtnMaskView *)maskView{
    
    if(_maskView==nil){

        _maskView=[CoreStatusBtnMaskView maskView];
        _maskView.statusBtn=self;

        [self addSubview:_maskView];
    }
    
    return _maskView;
}


@end

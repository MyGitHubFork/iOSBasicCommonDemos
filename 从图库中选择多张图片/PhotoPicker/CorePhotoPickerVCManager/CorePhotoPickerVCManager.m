//
//  CorePhotoPickerVC.m
//  PhotoPicker
//
//  Created by muxi on 15/2/13.
//  Copyright (c) 2015年 muxi. All rights reserved.
//

#import "CorePhotoPickerVCManager.h"
#import "UzysAssetsPickerController.h"

@interface CorePhotoPickerVCManager ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UzysAssetsPickerControllerDelegate>

//相册多选控制器
@property (nonatomic,strong) UzysAssetsPickerController *multiImagePickerController;

@end

@implementation CorePhotoPickerVCManager
HMSingletonM(CorePhotoPickerVCManager)


/**
 *  选取器类型
 */
-(void)setPickerVCManagerType:(CorePhotoPickerVCMangerType)pickerVCManagerType{
    
    //记录
    _pickerVCManagerType=pickerVCManagerType;
    
    //只有设置了值，才能确定照片选取器
    //初始化照片选取器
    [self pickerVCPrepareWithManagerType:pickerVCManagerType];
}


/**
 *  初始化照片选取器
 */
-(void)pickerVCPrepareWithManagerType:(CorePhotoPickerVCMangerType)managerType{
    
    //重置错误值
    self.unavailableType=CorePhotoPickerUnavailableTypeNone;
    
    if(CorePhotoPickerVCMangerTypeCamera==_pickerVCManagerType || CorePhotoPickerVCMangerTypeSinglePhoto==_pickerVCManagerType){
        //这个是系统相册选取器
        //sourceType
        UIImagePickerControllerSourceType sourceType=[self tranformCorePhotoPickerVCMangerTypeForSourceType:managerType];
        
        UIImagePickerController *imagePickerController=[[UIImagePickerController alloc] init];
        
        //判断是否可用
        BOOL isSourceTypeAvailable = [UIImagePickerController isSourceTypeAvailable:sourceType];
        
        if(!isSourceTypeAvailable){
            //不可用，直接抛出错误
            self.unavailableType=[self tranformCorePhotoPickerVCMangerTypeForUnavailableType:managerType];
            NSLog(@"当前设备不可用:%@",@(managerType));
            return;
        }
        
        //错误处理完毕，配置照片选取控制器
        //类型
        imagePickerController.sourceType=sourceType;
        
        //允许编辑
        imagePickerController.allowsEditing=YES;
        
        //代理
        imagePickerController.delegate=self;
        
        //记录控制器
        self.imagePickerController=imagePickerController;
        
    }else if (CorePhotoPickerVCMangerTypeMultiPhoto==_pickerVCManagerType){
        //这个是第三方多张照片选取器
        
        UzysAssetsPickerController *multiImagePickerController=[[UzysAssetsPickerController alloc] init];
        
        //记录控制器
        self.multiImagePickerController=multiImagePickerController;
        
        //暂不支持选视频
        multiImagePickerController.maximumNumberOfSelectionVideo=0;
        
        //初始化最大允许选取的图片数量
        multiImagePickerController.maximumNumberOfSelectionPhoto=MAXFLOAT;
        
        //设置代理
        multiImagePickerController.delegate=self;
        
        //记录控制器
        self.imagePickerController=multiImagePickerController;
        
    }else{
        //视频选取器，暂不支持
    }
}






-(void)setMaxSelectedPhotoNumber:(NSInteger)maxSelectedPhotoNumber{
    
    if(maxSelectedPhotoNumber<=0) return;
    
    //记录
    _maxSelectedPhotoNumber=maxSelectedPhotoNumber;
    
    if(self.multiImagePickerController==nil) return;
    
    //设置
    self.multiImagePickerController.maximumNumberOfSelectionPhoto=maxSelectedPhotoNumber;
}




#pragma mark  -系统自带控制器选取相册代理方法区
#pragma mark  选取了照片
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    //关闭自己
    [picker dismissViewControllerAnimated:YES completion:^{
        
        CorePhoto *photo=[CorePhoto photoWithInfoDict:info];
        
        if(self.finishPickingMedia != nil) _finishPickingMedia(@[photo]);
    }];
}

#pragma mark  点击了取消按钮
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    //直接取消
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 多选代理方法区

-(void)uzysAssetsPickerController:(UzysAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets{

    //获取相册数组
    NSArray *photos=[CorePhoto photosWithAssets:assets];
    
    if(self.finishPickingMedia != nil) _finishPickingMedia(photos);
}

#pragma mark  超过选取上限
-(void)uzysAssetsPickerControllerDidExceedMaximumNumberOfSelection:(UzysAssetsPickerController *)picker{
    NSLog(@"超过选取上限");
}

#pragma mark  取消
-(void)uzysAssetsPickerControllerDidCancel:(UzysAssetsPickerController *)picker{
    //直接取消：无需操作
}



/**
 *  CorePhotoPickerVCMangerType 转 UIImagePickerControllerSourceType
 */
-(UIImagePickerControllerSourceType)tranformCorePhotoPickerVCMangerTypeForSourceType:(CorePhotoPickerVCMangerType)type{
    
    if(CorePhotoPickerVCMangerTypeCamera == type) return UIImagePickerControllerSourceTypeCamera;
    
    if(CorePhotoPickerVCMangerTypeSinglePhoto == type) return UIImagePickerControllerSourceTypePhotoLibrary;
    
    return 0;
}

/**
 *  CorePhotoPickerVCMangerType 转 CorePhotoPickerUnavailableType
 */
-(CorePhotoPickerUnavailableType)tranformCorePhotoPickerVCMangerTypeForUnavailableType:(CorePhotoPickerVCMangerType)type{
    
    if(CorePhotoPickerVCMangerTypeCamera == type) return CorePhotoPickerUnavailableTypeCamera;
    
    if(CorePhotoPickerVCMangerTypeSinglePhoto == type) return CorePhotoPickerUnavailableTypePhoto;
    
    return 0;
}

@end

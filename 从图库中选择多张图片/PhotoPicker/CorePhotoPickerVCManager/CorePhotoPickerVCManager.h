//
//  CorePhotoPickerVC.h
//  PhotoPicker
//
//  Created by muxi on 15/2/13.
//  Copyright (c) 2015年 muxi. All rights reserved.
//  照片选取控制器

#import <UIKit/UIKit.h>
#import "CorePhoto.h"
#import "HMSingleton.h"


typedef void(^FinishPickingMedia)(NSArray *medias);


typedef enum{
    
    //用户拍照
    CorePhotoPickerVCMangerTypeCamera=0,
    
    //单张照片选取
    CorePhotoPickerVCMangerTypeSinglePhoto,
    
    //多张照片选取
    CorePhotoPickerVCMangerTypeMultiPhoto,
    
    //视频选取（暂不考虑，本框架仍可以完美支持）
    CorePhotoPickerVCMangerTypeVideo,
    
}CorePhotoPickerVCMangerType;


typedef enum{
    
    //无错误,可用
    CorePhotoPickerUnavailableTypeNone,
    
    //相机不可用
    CorePhotoPickerUnavailableTypeCamera,
    
    //相册不可用
    CorePhotoPickerUnavailableTypePhoto,
    
}CorePhotoPickerUnavailableType;



@interface CorePhotoPickerVCManager : NSObject
HMSingletonH(CorePhotoPickerVCManager)

//照片选取器类型
@property (nonatomic,assign) CorePhotoPickerVCMangerType pickerVCManagerType;

//照片选取器不可用类型
@property (nonatomic,assign) CorePhotoPickerUnavailableType unavailableType;

//照片选取控制器
@property (nonatomic,strong) UIViewController *imagePickerController;

//选取结束block
@property (nonatomic,copy) FinishPickingMedia finishPickingMedia;

/**
 *  多选参数，单行此属性将自动忽略
 *  此属性=0，表示不限制
 */
@property (nonatomic,assign) NSInteger maxSelectedPhotoNumber;                               //最多可选取的照片数量




@end

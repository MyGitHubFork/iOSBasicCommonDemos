//
//  CorePhoto.h
//  PhotoPicker
//
//  Created by muxi on 15/2/13.
//  Copyright (c) 2015年 muxi. All rights reserved.
//  相册数据对象

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>

@interface CorePhoto : NSObject


@property (nonatomic,copy) NSString *referenceURL;                                      //相册的路径

@property (nonatomic,strong) NSString *mediaType;                                       //媒体类型

@property (nonatomic,strong) UIImage *originalImage;                                    //原image对象

@property (nonatomic,strong) UIImage *editedImage;                                      //编辑过的image对象



/**
 *  快速解析出一个实例：系统框架照片选取
 */
+(instancetype)photoWithInfoDict:(NSDictionary *)infoDict;


/**
 *  快速解析出一个实例：ALAsset
 */
+(instancetype)photoWithAsset:(ALAsset *)asset;


/**
 *  解析ALAsset数据，并返回数组
 */
+(NSArray *)photosWithAssets:(NSArray *)assets;

@end

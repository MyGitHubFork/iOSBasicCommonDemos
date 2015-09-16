//
//  CorePhoto.m
//  PhotoPicker
//
//  Created by muxi on 15/2/13.
//  Copyright (c) 2015年 muxi. All rights reserved.
//

#import "CorePhoto.h"


@implementation CorePhoto


/**
 *  快速解析出一个实例：系统框架照片选取
 */
+(instancetype)photoWithInfoDict:(NSDictionary *)infoDict{

    CorePhoto *photo = [[CorePhoto alloc] init];

    photo.editedImage=infoDict[UIImagePickerControllerEditedImage];
    photo.mediaType=infoDict[UIImagePickerControllerMediaType];
    photo.originalImage=infoDict[UIImagePickerControllerOriginalImage];
    photo.referenceURL=infoDict[UIImagePickerControllerReferenceURL];
    return photo;
}



/**
 *  快速解析出一个实例：ALAsset
 */
+(instancetype)photoWithAsset:(ALAsset *)asset{
    
    CorePhoto *photo = [[CorePhoto alloc] init];
    
    //获取全屏图片，考虑上传此处不获取高清图片
    photo.editedImage=[[UIImage alloc] initWithCGImage:asset.defaultRepresentation.fullScreenImage];
    
    return photo;
}



/**
 *  解析ALAsset数据，并返回数组
 */
+(NSArray *)photosWithAssets:(NSArray *)assets{
    
    if(assets==nil || assets.count==0) return nil;
    
    NSMutableArray *assetsM=[NSMutableArray arrayWithCapacity:assets.count];
    [assets enumerateObjectsUsingBlock:^(ALAsset *asset, NSUInteger idx, BOOL *stop) {
        CorePhoto *photo = [self photoWithAsset:asset];
        [assetsM addObject:photo];
    }];
    
    return assetsM;
}

@end

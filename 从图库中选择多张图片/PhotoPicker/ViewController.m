//
//  ViewController.m
//  PhotoPicker
//
//  Created by muxi on 15/2/13.
//  Copyright (c) 2015年 muxi. All rights reserved.
//

#import "ViewController.h"
#import "CorePhotoPickerVCManager.h"


@interface ViewController ()<UIActionSheetDelegate>

@property (nonatomic,strong) CorePhotoPickerVCManager *manager;
@property (strong, nonatomic) IBOutlet UIImageView *imageV;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)btnClick:(id)sender {
   
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:@"请选取" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍摄" otherButtonTitles:@"照片库",@"照片多选", nil];
    
    [sheet showInView:self.view];
    
    
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    CorePhotoPickerVCMangerType type=0;

    
    if(buttonIndex==0) type=CorePhotoPickerVCMangerTypeCamera;
    
    if(buttonIndex==1) type=CorePhotoPickerVCMangerTypeSinglePhoto;
    
    if(buttonIndex==2) type=CorePhotoPickerVCMangerTypeMultiPhoto;

    CorePhotoPickerVCManager *manager=[CorePhotoPickerVCManager sharedCorePhotoPickerVCManager];
    
    //设置类型
    manager.pickerVCManagerType=type;
    
    //最多可选3张
    manager.maxSelectedPhotoNumber=5;
    
    //错误处理
    if(manager.unavailableType!=CorePhotoPickerUnavailableTypeNone){
        NSLog(@"设备不可用");
        return;
    }
    
    UIViewController *pickerVC=manager.imagePickerController;
    
    //选取结束
    manager.finishPickingMedia=^(NSArray *medias){
        
        
        
        
        [medias enumerateObjectsUsingBlock:^(CorePhoto *photo, NSUInteger idx, BOOL *stop) {
            //NSLog(@"哈哈哈哈%@",photo.editedImage);
            NSLog(@"媒体类型%@", photo.mediaType);
            _imageV.image = photo.originalImage;
            
        }];
    };
    
    [self presentViewController:pickerVC animated:YES completion:nil];

    
}



@end

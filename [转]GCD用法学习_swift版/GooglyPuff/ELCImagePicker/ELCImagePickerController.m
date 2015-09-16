//
//  ELCImagePickerController.m
//  ELCImagePickerDemo
//
//  Created by ELC on 9/9/10.
//  Copyright 2010 ELC Technologies. All rights reserved.
//

#import "ELCImagePickerController.h"
#import "ELCAsset.h"
#import "ELCAssetCell.h"
#import "ELCAssetTablePicker.h"
#import "ELCAlbumPickerController.h"
#import <CoreLocation/CoreLocation.h>

@implementation ELCImagePickerController

//Using auto synthesizers

- (id)init
{
    ELCAlbumPickerController *albumPicker = [[ELCAlbumPickerController alloc] initWithStyle:UITableViewStylePlain];
    
    self = [super initWithRootViewController:albumPicker];
    if (self) {
        self.maximumImagesCount = 4;
        [albumPicker setParent:self];
    }
    return self;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.maximumImagesCount = 4;
    }
    return self;
}

- (void)cancelImagePicker
{
	if ([_imagePickerDelegate respondsToSelector:@selector(elcImagePickerControllerDidCancel:)]) {
		[_imagePickerDelegate performSelector:@selector(elcImagePickerControllerDidCancel:) withObject:self];
	}
}

- (BOOL)shouldSelectAsset:(ELCAsset *)asset previousCount:(NSUInteger)previousCount
{
    return YES;
}

- (void)selectedAssets:(NSArray *)assets
{
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
	NSMutableArray *returnArray = [[NSMutableArray alloc] init];
        
        for(ALAsset *asset in assets) {
            id obj = [asset valueForProperty:ALAssetPropertyType];
            if (!obj) {
                continue;
            }
            NSMutableDictionary *workingDictionary = [[NSMutableDictionary alloc] init];
            
            CLLocation* wgs84Location = [asset valueForProperty:ALAssetPropertyLocation];
            if (wgs84Location) {
                [workingDictionary setObject:wgs84Location forKey:ALAssetPropertyLocation];
            }
            
            [workingDictionary setObject:obj forKey:UIImagePickerControllerMediaType];
            
            //defaultRepresentation returns image as it appears in photo picker, rotated and sized,
            //so use UIImageOrientationUp when creating our image below.
            ALAssetRepresentation *assetRep = [asset defaultRepresentation];
            
            CGImageRef imgRef = [assetRep fullScreenImage];
            UIImage *img = [UIImage imageWithCGImage:imgRef
                                               scale:1.0f
                                         orientation:UIImageOrientationUp];
            [workingDictionary setObject:img forKey:UIImagePickerControllerOriginalImage];
            [workingDictionary setObject:[[asset valueForProperty:ALAssetPropertyURLs] valueForKey:[[[asset valueForProperty:ALAssetPropertyURLs] allKeys] objectAtIndex:0]] forKey:UIImagePickerControllerReferenceURL];
            
            [returnArray addObject:workingDictionary];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_imagePickerDelegate != nil && [_imagePickerDelegate respondsToSelector:@selector(elcImagePickerController:didFinishPickingMediaWithInfo:)]) {
                [_imagePickerDelegate performSelector:@selector(elcImagePickerController:didFinishPickingMediaWithInfo:) withObject:self withObject:returnArray];
            } else {
                [self popToRootViewControllerAnimated:NO];
            }
        });
    });
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return YES;
    } else {
        return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
    }
}

@end

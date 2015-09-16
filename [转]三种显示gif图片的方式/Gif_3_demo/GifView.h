//
//  GifView.h
//  GIFViewer
//
//  Created by xToucher04 on 11-11-9.
//  Copyright 2011 Toucher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>

@interface GifView : UIView {
	CGImageSourceRef gif;
	NSDictionary *gifProperties;
	size_t index;
	size_t count;
	NSTimer *timer;
}

- (id)initWithFrame:(CGRect)frame filePath:(NSString *)_filePath;
- (id)initWithFrame:(CGRect)frame data:(NSData *)_data;

@end

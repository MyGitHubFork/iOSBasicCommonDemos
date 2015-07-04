//
//  ViewController.m
//  将文字截取为图片
//
//  Created by 黄成都 on 15/7/4.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "ViewController.h"

#define CONTENT_MAX_WIDTH   300.0f

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.titleImage.image = [self imageFromText:@[@"dfasfasfas",@"你好你哈市的发生的佛山大佛阿斯顿佛啊是佛爱上",@"的风景好和我额那是对方那沙发深V就卡死都发你哈舒服",@"京东；奥积分"] withFont:18 withTextColor:[UIColor greenColor] withBgImage:[UIImage imageNamed:@"Default"] withBgColor:[UIColor blueColor]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UIImage *)imageFromText:(NSArray*)arrContent withFont:(CGFloat)fontSize withTextColor:(UIColor *)textColor withBgImage:(UIImage *)bgImage withBgColor:(UIColor *)bgColor
{
    // set the font type and size
    
    UIFont *font = [UIFont fontWithName:@"Heiti SC" size:fontSize];
    NSMutableArray *arrHeight = [[NSMutableArray alloc] initWithCapacity:arrContent.count];
    
    CGFloat fHeight = 0.0f;
    for (NSString *sContent in arrContent) {
        CGSize stringSize = [sContent sizeWithFont:font constrainedToSize:CGSizeMake(CONTENT_MAX_WIDTH, 10000) lineBreakMode:NSLineBreakByWordWrapping];
        [arrHeight addObject:[NSNumber numberWithFloat:stringSize.height]];
        
        fHeight += stringSize.height;
    }
    
    CGSize newSize = CGSizeMake(CONTENT_MAX_WIDTH+20, fHeight+50);
    
    
    // Create a stretchable image for the top of the background and draw it
    UIGraphicsBeginImageContextWithOptions(newSize,NO,0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    
    //如果设置了背景图片
    if(bgImage)
    {
        UIImage* stretchedTopImage = [bgImage stretchableImageWithLeftCapWidth:0 topCapHeight:0];
        [stretchedTopImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    }else
    {
        if(bgColor)
        {
            //填充背景颜色
            [bgColor set];
            UIRectFill(CGRectMake(0, 0, newSize.width, newSize.height));
        }
    }
    
    CGContextSetCharacterSpacing(ctx, 10);
    CGContextSetTextDrawingMode (ctx, kCGTextFill);
    [textColor set];
    
    
    int nIndex = 0;
    CGFloat fPosY = 20.0f;
    for (NSString *sContent in arrContent) {
        NSNumber *numHeight = [arrHeight objectAtIndex:nIndex];
        CGRect rect = CGRectMake(10, fPosY, CONTENT_MAX_WIDTH , [numHeight floatValue]);
        
        //把指定的文字绘制到指定的位置
        [sContent drawInRect:rect withFont:font lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        fPosY += [numHeight floatValue];
        nIndex++;
    }
    
    // transfer image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}

@end

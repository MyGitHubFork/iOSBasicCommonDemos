//
//  ViewController.m
//  CoreTextDemo_mine
//
//  Created by yifan on 15/8/19.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "ViewController.h"
#import "HCDFrameParser.h"
#import "HCDCoreTextData.h"
#import "HCDFrameParserConfig.h"
#import "HCDDisplayView.h"
#warning 参考博客地址：http://blog.devtang.com/blog/2015/06/27/using-coretext-1/
@interface ViewController ()
@property (weak, nonatomic) IBOutlet HCDDisplayView *ctVuew;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HCDFrameParserConfig *config = [[HCDFrameParserConfig alloc] init];
    config.textColor = [UIColor redColor];
    config.width = self.ctVuew.width;
    
    NSString *content =
    @" 对于上面的例子，我们给 CTFrameParser 增加了一个将 NSString 转 "
    " 换为 CoreTextData 的方法。"
    " 但这样的实现方式有很多局限性，因为整个内容虽然可以定制字体 "
    " 大小，颜色，行高等信息，但是却不能支持定制内容中的某一部分。"
    " 例如，如果我们只想让内容的前三个字显示成红色，而其它文字显 "
    " 示成黑色，那么就办不到了。"
    "\n\n"
    " 解决的办法很简单，我们让`CTFrameParser`支持接受 "
    "NSAttributeString 作为参数，然后在 NSAttributeString 中设置好 "
    " 我们想要的信息。";
    NSDictionary *attr = [HCDFrameParser attributesWithConfig:config];
    NSMutableAttributedString *attributedString =
    [[NSMutableAttributedString alloc] initWithString:content
                                           attributes:attr];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:[UIColor redColor]
                             range:NSMakeRange(0, 7)];
    
    HCDCoreTextData *data = [HCDFrameParser parseContext:attributedString config:config];
    self.ctVuew.data = data;
    self.ctVuew.height = data.height;
    self.ctVuew.backgroundColor = [UIColor yellowColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

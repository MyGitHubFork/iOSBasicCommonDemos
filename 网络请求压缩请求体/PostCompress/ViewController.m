//
//  ViewController.m
//  PostCompress
//
//  Created by Jack Cox on 3/3/12.
//  
//

#import "ViewController.h"
#import "CompressedRequest.h"
#import <QuartzCore/CAAnimation.h>

@implementation ViewController
@synthesize urlField;
@synthesize compressRequestSwitch;
@synthesize compressResponseSwitch;
@synthesize uncompPayloadSizeLabel;
@synthesize compPayloadSizeLabel;
@synthesize totalTimeConsumeLabel;
@synthesize avgRequestTimeLabel;
@synthesize iterationsLabel;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *urlValue = [def stringForKey:@"url"];
    if (urlValue != nil) {
        urlField.text = urlValue;
    }
}

- (void)viewDidUnload
{
    [self setUrlField:nil];
    [self setCompressRequestSwitch:nil];
    [self setCompressResponseSwitch:nil];
    [self setUncompPayloadSizeLabel:nil];
    [self setCompPayloadSizeLabel:nil];
    [self setTotalTimeConsumeLabel:nil];
    [self setAvgRequestTimeLabel:nil];
    [self setIterationsLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
/**
 * Run a test and report the resulting time and average
 */
- (void)runTests {
        
        double startTime = CACurrentMediaTime();
        CompressedRequest *req = [CompressedRequest new];
        
        req.compressResponse = compressResponseSwitch.on;
        req.compressRequest = compressRequestSwitch.on;
        req.urlString =  urlField.text;
        
        [req sendRequest];
         double duration = CACurrentMediaTime() - startTime; 
        timeTaken += duration;
        iterations++;
         dispatch_async(dispatch_get_main_queue(), ^{
             uncompPayloadSizeLabel.text = [NSString stringWithFormat:@"%d", req.uncompReqSize];
             compPayloadSizeLabel.text = [NSString stringWithFormat:@"%d", req.reqSize];
             
             totalTimeConsumeLabel.text = [NSString stringWithFormat:@"%0.5f", timeTaken];
             avgRequestTimeLabel.text = [NSString stringWithFormat:@"%0.5f", timeTaken / iterations];
             iterationsLabel.text = [NSString stringWithFormat:@"%f", iterations];
             if (keepRunning) {
                 [self performSelectorInBackground:@selector(runTests) withObject:nil];
             }
         });
        
    
}

/**
 * Start the tests going and disable the settings
 */
- (IBAction)startTest:(id)sender {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSString *urlString = urlField.text;
    [def setValue:urlString forKey:@"url"];
    timeTaken = 0.0;
    iterations = 0.0;
    keepRunning = YES;
    
    compressRequestSwitch.enabled = NO;
    compressResponseSwitch.enabled = NO;
    urlField.enabled = NO;
    
    [self performSelectorInBackground:@selector(runTests) withObject:nil];
    
}
/**
 * Stop the tests
 */
- (IBAction)stopTest:(id)sender {
    keepRunning = NO;
    compressRequestSwitch.enabled = YES;
    compressResponseSwitch.enabled = YES;
    urlField.enabled = YES;
}

@end

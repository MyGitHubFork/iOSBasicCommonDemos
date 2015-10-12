//
//  CompressedRequest.m
//  CompressedRequest
//
//  Created by Jack Cox on 3/3/12.
//

#import "CompressedRequest.h"
#import "zlib.h"

@implementation CompressedRequest
@synthesize compressRequest;
@synthesize compressResponse;
@synthesize urlString;
@synthesize errorOccurred;
@synthesize reqSize;
@synthesize uncompReqSize;

/*
 *  Compress a NSData and return the results in another NSData object
 */
- (NSData *)compressNSData:(NSData *)myData {
    NSMutableData *compressedData = [NSMutableData dataWithLength:16384];
    
    z_stream compressionStream;
    // setup the compression stream
    compressionStream.next_in=(Bytef *)[myData bytes];
	compressionStream.avail_in = [myData length];
    compressionStream.zalloc = Z_NULL;
	compressionStream.zfree = Z_NULL;
	compressionStream.opaque = Z_NULL;
	compressionStream.total_out = 0;
    
    // start the compression of the stream using default compression
    if (deflateInit2(&compressionStream, Z_DEFAULT_COMPRESSION, Z_DEFLATED, (15+16), 8, Z_DEFAULT_STRATEGY) != Z_OK) {
        // Something failed
        errorOccurred = YES;
        return nil;
    }
    
    
    // loop over the input stream writing bytes into the compressedData buffer in 16K chunks
    do {
        // for every 16K of data compress a chunk into the compressedData buffer
        if (compressionStream.total_out >= [compressedData length]) {
            // increase the size of the output data buffer
            [compressedData increaseLengthBy:16386];
        }
        
        compressionStream.next_out = [compressedData mutableBytes] + compressionStream.total_out;
		compressionStream.avail_out = [compressedData length] - compressionStream.total_out;
		
		deflate(&compressionStream, Z_FINISH);  
        
    } while (compressionStream.avail_out == 0);
    // end the compression run
    deflateEnd(&compressionStream);
	// set the actual length of the compressed data object to match the number of bytes
    // returned by the compression stream
	[compressedData setLength: compressionStream.total_out];
    return compressedData;
}

/*
 * Send a HTTP request to a target host
 */
-(void)sendRequest {
    errorOccurred = NO;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"xml"];  
    NSData *myData = [NSData dataWithContentsOfFile:filePath];
    NSLog(@"Initial data size = %d", [myData length]);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:
                                    [NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    // record the uncompressed size of the file
    uncompReqSize = [myData length];
    
    // if the test is a compress request operation
    if (self.compressRequest) {
        [request addValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
        NSData *compressed = [self compressNSData:myData];
        NSLog(@"Compressed data size = %d", [compressed length]);
        [request setHTTPBody:compressed];
        reqSize = [compressed length];
    } else {
        reqSize = [myData length];
        [request setHTTPBody:myData];
    }
    // if the compressResponse is false then remove the accept-encoding header
    if (!self.compressResponse) {
        [request addValue:@"" forHTTPHeaderField:@"Accept-Encoding"];
    }
    
    NSError *error = nil;
    NSHTTPURLResponse *response;
    // send the request
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if ((!error) && ([response statusCode] == 200)) {
        errorOccurred = NO;
        // got a good response
        // uncomment below if you want a trace of the bytes returned
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        NSLog(@"Received data = %@", responseString);
    } else {
        errorOccurred = YES;
        
    }
    
}

@end

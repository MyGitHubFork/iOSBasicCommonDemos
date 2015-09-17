//
//  CompressedRequest.h
//  CompressedRequest
//
//  Created by Jack Cox on 3/3/12.
//

#import <Foundation/Foundation.h>

@interface CompressedRequest : NSObject {
    NSString    *urlString;
    BOOL        compressRequest;
    BOOL        compressResponse;
    NSInteger   reqSize;
    NSInteger   uncompReqSize;
}
@property (strong) NSString *urlString;
@property (assign) BOOL compressRequest;
@property (assign) BOOL compressResponse;
@property (assign) BOOL errorOccurred;
@property (assign) NSInteger reqSize;
@property (assign) NSInteger uncompReqSize;

- (void) sendRequest;

@end

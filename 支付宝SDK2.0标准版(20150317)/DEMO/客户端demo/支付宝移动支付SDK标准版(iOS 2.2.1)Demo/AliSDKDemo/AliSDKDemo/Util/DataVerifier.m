//
//  DataVerifier.m
//  AlixPayDemo
//
//  Created by Jing Wen on 8/2/11.
//  Copyright 2011 alipay.com. All rights reserved.
//

#import "DataVerifier.h"


#import "RSADataVerifier.h"

id<DataVerifier> CreateRSADataVerifier(NSString *publicKey) {
	
	return [[RSADataVerifier alloc] initWithPublicKey:publicKey];
	
}
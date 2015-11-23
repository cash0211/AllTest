//
//  KVCTest.m
//  KCVTest
//
//  Created by cash on 15-8-26.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "KVCTest.h"

@implementation KVCTest

- (int)p1 {
    
    NSLog(@"come in the P1 getter method~");
    
    return _p1;
}

- (int)p2 {
    
    NSLog(@"come in the P2 getter method~");
    
    return _p2;
}

- (int)p3 {
    
    NSLog(@"come in the P3 getter method~");
    
    return _p3;
}


- (int)getValueByPropertyName:(NSString *)name {
    
    NSNumber *num = [self valueForKey:name];
    
    return [num intValue];
}

@end























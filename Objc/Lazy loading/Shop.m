//
//  Shop.m
//  Component
//
//  Created by Kuan-Wei Lin on 7/7/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "Shop.h"

@interface Shop ()

@end

@implementation Shop

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    
    return sharedInstance;
}

@end

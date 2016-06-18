//
//  MyDetection.m
//  MyDelegation
//
//  Created by Kuan-Wei Lin on 5/21/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "MyDetection.h"

@interface MyDetection ()

@property (strong, nonatomic) NSString *uuid;

@end

@implementation MyDetection

+ (instancetype)defaultDetection
{
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    
    return sharedInstance;
//    MyDetection *detect = [[MyDetection alloc] init];
//    return detect;
}

- (instancetype)initWithUUID: (NSString *)uuid
{
    self = [super init];
    if (self) {
        self.uuid = uuid;
    }
    return self;
}

- (void)startRangeBeacon
{
    NSString *beacon = @"myBeacon";
    if ([self.delegate respondsToSelector:@selector(didDetectBeaconRegion:)]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate didDetectBeaconRegion:beacon];
        });
    }
    
    [self didReceiveBeaconInfo];
}

- (void)didReceiveBeaconInfo{
    
    NSDictionary *dic = @{
                          @"p1":@"major",
                          @"p2":@"minor",
                          @"p3":@"proximity",
                          @"p4":@"accuracy",
                          @"p5":@"rssi"
                          };
    
    if ([self.delegate respondsToSelector:@selector(passDetectionInfo:)]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate passDetectionInfo:dic];
        });
    }
}

@end

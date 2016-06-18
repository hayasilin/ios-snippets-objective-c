//
//  MyDataManager.m
//  MyDelegation
//
//  Created by Kuan-Wei Lin on 5/21/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "MyDataManager.h"

@implementation MyDataManager

+ (instancetype)defaultManager{
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        //Custom init
    }
    return self;
}

- (void)getBeaconList{
    NSDictionary *beaconList = @{
                                 @"p1":@"111-222-333-444-555",
                                 @"p2":@"2.8"
                                 };
    
    if ([self.delegate respondsToSelector:@selector(didReceiveBeaconList:)]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate didReceiveBeaconList:beaconList];
        });
    }
}

- (void)getAdDataWithBeaconInfo:(NSDictionary *)beaconInfo
{
    NSLog(@"beaconInfo = %@", beaconInfo);
    
    NSDictionary *adDics = @{
                            @"p1":@"Ad title",
                            @"p2":@"Ad content",
                            @"p3":@"Ad url",
                            @"p4":@"Ad pic",
                            @"p5":@"Ad info"
                            };
    
    if ([self.delegate respondsToSelector:@selector(passDataFromManager:)]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate passDataFromManager:adDics];
        });
    }
}



@end

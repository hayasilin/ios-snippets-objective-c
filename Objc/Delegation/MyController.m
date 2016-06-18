//
//  MyController.m
//  MyDelegation
//
//  Created by Kuan-Wei Lin on 5/21/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "MyController.h"

@interface MyController ()

@property (strong, nonatomic) MyDataManager *manager;
@property (strong, nonatomic) MyDetection *detection;

@end

@implementation MyController

+ (instancetype)defaultController
{
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
        [self getBeaconListFromManager];
    }
    return self;
}

- (void)getBeaconListFromManager
{
    //Manager
    self.manager = [MyDataManager defaultManager];
    self.manager.delegate = self;
    [self.manager getBeaconList];
}


//MARK: - MyDetectionDelegate
- (void)didDetectBeaconRegion:(NSString *)region
{
    NSLog(@"region = %@", region);
    
}

- (void)passDetectionInfo:(NSDictionary *)beaconInfo
{
    //NSLog(@"beaconInfo = %@", beaconInfo);
    
    [self.manager getAdDataWithBeaconInfo:beaconInfo];
}

//MARK: - MyDataManagerDelegate

- (void)didReceiveBeaconList:(NSDictionary *)beaconList
{
    NSLog(@"beaconList = %@", beaconList);
    
    //dection
    self.detection = [[MyDetection defaultDetection] initWithUUID:beaconList[@"p1"]];
    self.detection.delegate = self;
    [self.detection startRangeBeacon];
}

- (void)passDataFromManager:(NSDictionary *)adData
{
    NSLog(@"passDataFromManager data = %@", adData);
    
    //Send callback function if did receive adData
    if (adData != nil) {
        if ([self.delegate respondsToSelector:@selector(beaconSDKDidCompleteUpdating)]){
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate beaconSDKDidCompleteUpdating];
            });
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(beaconSDKDidFailUpdating:)])
        {
            NSError *error;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate beaconSDKDidFailUpdating:error];
            });
        }
    }
}



@end

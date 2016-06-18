//
//  MyDetection.h
//  MyDelegation
//
//  Created by Kuan-Wei Lin on 5/21/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MyDetectionDelegate <NSObject>

- (void)didDetectBeaconRegion:(NSString *)region;
- (void)passDetectionInfo:(NSDictionary *)beaconInfo;

@end

@interface MyDetection : NSObject

@property (weak, nonatomic) id <MyDetectionDelegate> delegate;

+ (instancetype)defaultDetection;
- (instancetype)initWithUUID: (NSString *)uuid;

- (void)startRangeBeacon;
- (void)didReceiveBeaconInfo;

@end

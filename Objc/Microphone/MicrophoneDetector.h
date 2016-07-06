//
//  MicrophoneDetector.h
//  201606_Flashligh&Blow_POC
//
//  Created by Kuan-Wei on 2016/6/20.
//  Copyright © 2016年 Kuan-Wei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MicrophoneDetector : NSObject

@property (nonatomic) BOOL isGranted;
@property (strong, nonatomic) NSString *permissionStatusString;
@property (nonatomic) int currentDecibel;
@property (nonatomic) int maxDecibel;

+ (instancetype)defaultDetector;
- (void)checkMicrophonePermission;
- (void)startSoundDetector;
- (void)startSoundDetectorWithSecond:(float)second;
- (void)closeSoundDetector;

@end

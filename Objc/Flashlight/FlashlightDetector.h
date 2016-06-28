//
//  FlashlightDetector.h
//  201606_Flashligh&Blow_POC
//
//  Created by Kuan-Wei on 2016/6/20.
//  Copyright © 2016年 Kuan-Wei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlashlightDetector : NSObject

+ (instancetype)defaultDetector;
- (void)turnFlashlightOn;
- (void)turnFlashlightOff;
- (void)FlashlightOnOffSwitch;
- (void)startFlashlightWithTimeInterval:(float)second times:(int)times;
- (void)stopFlashlightAndTimer;

@end

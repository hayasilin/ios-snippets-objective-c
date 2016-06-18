//
//  MyController.h
//  MyDelegation
//
//  Created by Kuan-Wei Lin on 5/21/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyDataManager.h"
#import "MyDetection.h"

@protocol MyControllerDelegate <NSObject>

@required

@optional
- (void)beaconSDKDidCompleteUpdating;
- (void)beaconSDKDidFailUpdating: (NSError *)error;

@end

@interface MyController : NSObject <MyDataManagerDelegate, MyDetectionDelegate>

@property (weak, nonatomic) id <MyControllerDelegate> delegate;

+ (instancetype)defaultController;


@end

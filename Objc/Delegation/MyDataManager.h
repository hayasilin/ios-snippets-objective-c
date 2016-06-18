//
//  MyDataManager.h
//  MyDelegation
//
//  Created by Kuan-Wei Lin on 5/21/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MyDataManagerDelegate <NSObject>

- (void)didReceiveBeaconList:(NSDictionary *)beaconList;
- (void)passDataFromManager:(NSDictionary *)adData;

@end

@interface MyDataManager : NSObject

@property (weak, nonatomic) id <MyDataManagerDelegate> delegate;

+ (instancetype)defaultManager;
- (void)getBeaconList;
- (void)getAdDataWithBeaconInfo:(NSDictionary *)beaconInfo;


@end

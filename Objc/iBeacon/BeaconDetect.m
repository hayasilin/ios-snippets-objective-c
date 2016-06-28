//
//  BeaconDetect.m
//  BeaconSDK
//
//  Created by Kuan-Wei on 2016/5/3.
//  Copyright © 2016年 Kuan-Wei. All rights reserved.
//

#import "BeaconDetect.h"
#import "BeaconDefine.h"

//BeaconSDK
#import "BeaconDataManager.h"
#import "BeaconNotification.h"
#import "BeaconBatteryData.h"
#import "BeaconDevice.h"
#import "BeaconData.h"

@interface BeaconDetect ()

/*! The list of first 5 iBeacon devices */
@property (retain, nonatomic) NSMutableDictionary * beaconDic;

/*! The list contains iBeacon device's uuids. */
@property (retain, nonatomic) NSMutableArray * targetUUIDs;

/*! iBeacon device's uuid. */
@property (retain, nonatomic) NSString * targetUUID;

/*! The list contains iBeacon device's power uuids*/
@property (retain, nonatomic) NSMutableArray *powerUUIDs;

/*! iBeacon's power uuid */
@property (retain, nonatomic) NSString * powerUUID;

/*! iBeacon's power region */
@property (retain, nonatomic) CLBeaconRegion * powerRegion;

/*! iBeacon's mac address */
@property (retain, nonatomic) NSString *beacon_mac;

/*! iBeacon's power voltage */
@property float powerVol;

/*! Delay time for updating iBeacon device's voltage info */
@property (retain, nonatomic) NSString *voltageDelayTime;

/*Functional properties below================================================================================*/

//Properties for monitoring iBeacon devices
@property (strong, nonatomic) CLLocationManager *locationManager;
//BeaconData for store ad waiting time value
@property (retain, nonatomic) BeaconData *data;

//Nearest iBeacon device property
@property (nonatomic,retain) NSArray * beaconList;
@property (nonatomic,retain) CLBeacon * nearistBeacon;

@end

@implementation BeaconDetect

- (void)dealloc{
    
}

+ (BeaconDetect *)detectBeaconWithUUID: (NSString*)uuid{
    BeaconDetect * object = [[BeaconDetect alloc] initWithUUID:uuid];
    return object;
}

- (id)initWithUUID: (NSString*)uuid{
    self = [super init];
    if (self) {
        _targetUUIDs = [NSMutableArray arrayWithCapacity:5];
        [_targetUUIDs addObject:uuid];
        self.powerRegion = nil;
        self.powerUUID = @"";
        //[self startSearching];
    }
    return self;
}

+ (BeaconDetect *)detectBeaconWithUUIDs: (NSArray*)uuids{
    BeaconDetect * object = [[BeaconDetect alloc] initWithUUIDs:uuids];
    return object;
}

- (id)initWithUUIDs: (NSArray*)uuids{
    self = [super init];
    if (self) {
        _targetUUIDs = [NSMutableArray arrayWithCapacity:5];
        [_targetUUIDs addObjectsFromArray:uuids];
        self.powerRegion = nil;
        self.powerUUID = @"";
        //[self startSearching];
    }
    return self;
}

//如果Server回傳Poweruuid有兩組以上的情況
- (void)setUUIDsForDetectPowerVoltage: (NSArray *)powerUUIDs{
    _powerUUIDs = [NSMutableArray arrayWithCapacity:5];
    [_powerUUIDs addObjectsFromArray:powerUUIDs];
}

- (void)setUUIDForDetectPowerVoltage:(NSString *)aPowerUUID{
    if(![aPowerUUID isEqualToString:@""]){
        self.powerUUID = aPowerUUID;
    }
}

-(void)startSearching{
    NSLog(@"startSearching");
    //init
    _beaconDic = [NSMutableDictionary dictionaryWithCapacity:5];
    
    //beacon
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }
    
    int count = 1;
    NSLog(@"targetUUIDs = %@", _targetUUIDs);
    
    for (NSString * uuid in _targetUUIDs) {
        NSUUID * nsuuid = [[NSUUID alloc] initWithUUIDString:uuid];
        CLBeaconRegion * beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:nsuuid identifier:[NSString stringWithFormat:@"region%d",count]];
        [_locationManager startMonitoringForRegion:beaconRegion];
        count++;
    }
    
    //PowerUUID有兩組以上的情況
    int powerCount = 1;
    NSLog(@"powerUUIDs = %@", _powerUUIDs);
    for (NSString *powerUUID in _powerUUIDs) {
        NSUUID *puuid = [[NSUUID alloc]initWithUUIDString:powerUUID];
        self.powerRegion = [[CLBeaconRegion alloc] initWithProximityUUID:puuid identifier:[NSString stringWithFormat:@"power%d", powerCount]];
        [_locationManager startMonitoringForRegion:self.powerRegion];
        powerCount++;
    }
    
    //set powerUUID to start monitor power advertise僅有1組PowerUUID
    //    if(![self.powerUUID isEqualToString:@""]){
    //        NSUUID * puuid = [[NSUUID alloc] initWithUUIDString:self.powerUUID];
    //        self.powerRegion = [[CLBeaconRegion alloc] initWithProximityUUID:puuid identifier:@"power"];
    //        [_locationManager startMonitoringForRegion:self.powerRegion];
    //    }
}

#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error{
    NSLog(@"monitoring Did Fail For Region = %@",error);
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region{
    NSLog(@"didStartMonitoringForRegion %@",region);
    CLBeaconRegion * beaconRegion  = (CLBeaconRegion * )region;
    [self.locationManager startRangingBeaconsInRegion:beaconRegion];
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    //Callback
    if ([self.delegate respondsToSelector:@selector(BSDKisEnterBeaconRegion:)]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate BSDKisEnterBeaconRegion:region];
        });
    }
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
    NSLog(@"離開 %@ 區域", region.identifier);
    if ([self.delegate respondsToSelector:@selector(BSDKisExitBeaconRegion:)]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate BSDKisExitBeaconRegion:region];
        });
    }
}

- (void)updateVoltageDelayTime: (NSString *)delayTime{
    self.voltageDelayTime = delayTime;
}

-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region{
    
    if (beacons.count == 0) {
        return;
    }
    //MARK: - 電量偵測if this is the power beacon data
    if([region isEqual:self.powerRegion]){
        for(int i = 0; i < beacons.count; i++){
            CLBeacon *aBeacon = (CLBeacon *)[beacons objectAtIndex:i];
            
            self.powerVol = [[BeaconBatteryData defaultBatteryData] calculateVoltageWithMinor:aBeacon.minor];
            self.beacon_mac = [[BeaconBatteryData defaultBatteryData] calculateMacAddressWithMajor:aBeacon.major Minor:aBeacon.minor];
            
            //Update voltage to server if it is in the right time
            [self renewVoltageToServerWithDelayTime:[self.voltageDelayTime doubleValue]];
            
            //Callback function
            if([self.delegate respondsToSelector:@selector(BSDKdidReceivedPowerVoltage:fromBeacon:)]){
                [self.delegate BSDKdidReceivedPowerVoltage:self.powerVol fromBeacon:self.beacon_mac];
            }
        }
    }else{
        [_beaconDic setObject:beacons forKey:region.proximityUUID.UUIDString];
        [self callBackToUpdateBeaconList];
    }
}

//Power voltage renew method
- (void)renewVoltageToServerWithDelayTime: (float)delayTime{
    NSString *defaultTime = [[NSUserDefaults standardUserDefaults] objectForKey:@"beaconSDKDefaultStartTime"];
    if (defaultTime == nil) {
        //Record the start time when first update to the server
        NSLog(@"Fisrt time open the app, create a NSUserDefaults plist to save start time");
        NSTimeInterval startTime = [[NSDate date] timeIntervalSince1970];
        NSNumber *startTimeNumber = [NSNumber numberWithDouble:startTime];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:startTimeNumber forKey:@"beaconSDKDefaultStartTime"];
        [userDefaults synchronize];
        //Update voltage to server，因iOS僅能得到Mac address的後5碼，因此1.0.0版本不實作上傳電量至Server
        //[[BeaconDataManager defaultManager] updateVoltageToServer:self.powerVol macAddress:self.beacon_mac];
    }else{
        NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
        NSLog(@"Second after the last voltage updating = %f", nowTime - [defaultTime doubleValue]);
        //If nowTime divides defaultTime is bigger than delayTime, then update voltage info to the server
        if (nowTime - [defaultTime doubleValue] > delayTime) {
            NSLog(@"Voltage info need to be renewed, renew the NSUserDefaults plist");
            //Renew start time
            NSTimeInterval startTime = [[NSDate date] timeIntervalSince1970];
            NSNumber *startTimeNumber = [NSNumber numberWithDouble:startTime];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:startTimeNumber forKey:@"beaconSDKDefaultStartTime"];
            [userDefaults synchronize];
            //Update voltage to server，因iOS僅能得到Mac address的後5碼，因此1.0.0版本不實作上傳電量至Server
            //[[BeaconDataManager defaultManager] updateVoltageToServer:self.powerVol macAddress:self.beacon_mac];
        }else{
            NSLog(@"Voltage info NO need to be renewed");
        }
    }
}

#pragma mark CallBack
-(void)callBackToUpdateBeaconList{
    NSMutableArray * beaconsArray = [NSMutableArray arrayWithCapacity:5];
    for ( NSString * key in _beaconDic.allKeys ) {
        NSArray * beaconsFromSpecficUUID = _beaconDic[key];
        [beaconsArray addObjectsFromArray:beaconsFromSpecficUUID];
    }
    
    _beaconList = (NSArray *)beaconsArray;
    
    if([self.delegate respondsToSelector:@selector(BSDKbeaconListChangeTo:)]){
        [self.delegate BSDKbeaconListChangeTo:_beaconList];
    }
    
    if([self.delegate respondsToSelector:@selector(BSDKnearestBeaconChangeTo:)]){
        NSArray * sorted = [self beaconsSortedByRSSI:_beaconList];
        if (sorted.count == 0) {
            
        }else{
            CLBeacon * nearist = sorted[0];
            if (_nearistBeacon == nil) {
                _nearistBeacon = nearist;
                [self.delegate BSDKnearestBeaconChangeTo:nearist];
            }else{
                if ([self beacon:_nearistBeacon isEqualToBeacon:nearist]) {
                    //如果最近的iBeacon相同，為了每秒都抓到beacon資訊加入下面程式碼
                    [self.delegate BSDKnearestBeaconChangeTo:nearist];
                }else{
                    //如果最近的iBeacon不同，更新iBeacon資訊
                    _nearistBeacon = nearist;
                    [self.delegate BSDKnearestBeaconChangeTo:nearist];
                }
            }
        }
    }
}

#pragma mark EASY FILTER - beaconsSortedByMajorMinor

-(NSArray*)beaconsSortedByMajorMinor:(NSArray*)original{
    
    NSMutableDictionary * beaconDicWithSortingKey = [NSMutableDictionary dictionaryWithCapacity:5];
    int count = 1;
    
    for (int j = 0; j < original.count ; j++) {
        if ([original[j] isKindOfClass:[CLBeacon class]]) {
            CLBeacon * beacon = original[j];
            NSString * extendedMajor = [self string:[NSString stringWithFormat:@"%d",beacon.major.intValue] FilledWithZeroToLenth:5];
            NSString * extendedMinor = [self string:[NSString stringWithFormat:@"%d",beacon.minor.intValue] FilledWithZeroToLenth:5];
            NSString * sortingKey = [NSString stringWithFormat:@"%@_%@_%@_%d",beacon.proximityUUID.UUIDString,extendedMajor,extendedMinor,count];
            [beaconDicWithSortingKey setObject:beacon forKey:sortingKey];
            count ++;
        }else{
            
        }
    }
    
    if (count == 1) {
        return original;
    }else{
        
        NSArray * sortedKeys = [beaconDicWithSortingKey.allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        NSMutableArray * arrayToReturn = [NSMutableArray arrayWithCapacity:5];
        for ( NSString * sortedKey in sortedKeys ) {
            [arrayToReturn addObject:beaconDicWithSortingKey[sortedKey]];
        }
        return arrayToReturn;
    }
}

#pragma mark EASY FILTER - beaconsSortedByRSSI

-(NSArray*)beaconsSortedByRSSI:(NSArray*)original{
    
    NSMutableDictionary * beaconDicWithSortingKey = [NSMutableDictionary dictionaryWithCapacity:5];
    int count = 1;
    
    for (int j = 0; j < original.count ; j++) {
        if ([original[j] isKindOfClass:[CLBeacon class]]) {
            CLBeacon * beacon = original[j];
            
            NSString * biasedRSSI;
            
            if (beacon.proximity == CLProximityUnknown ) {
                biasedRSSI = @"0";
            }else{
                biasedRSSI =  [NSString stringWithFormat:@"%ld", (long)(beacon.rssi + 1000) ];
            }
            
            NSString * sortingKey = [self string:biasedRSSI FilledWithZeroToLenth:5];
            [beaconDicWithSortingKey setObject:beacon forKey:sortingKey];
            count ++;
        }else{
            
        }
    }
    
    //NSLog(@"%@",beaconDicWithSortingKey.allKeys);
    //return @[@"1",@"2"];
    
    if (count == 1) {
        return original;
    }else{
        
        NSArray * sortedKeys = [beaconDicWithSortingKey.allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        NSMutableArray * arrayToReturn = [NSMutableArray arrayWithCapacity:5];
        for ( NSString * sortedKey in sortedKeys ) {
            //[arrayToReturn addObject:beaconDicWithSortingKey[sortedKey]];
            [arrayToReturn insertObject:beaconDicWithSortingKey[sortedKey] atIndex:0];
        }
        return arrayToReturn;
    }
}

#pragma mark EASY FILTER - beaconsNoUnknownProximity
-(NSArray*)beaconsNoUnknownProximity:(NSArray*)original{
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:5];
    for (int j = 0; j < original.count ; j++) {
        if ([original[j] isKindOfClass:[CLBeacon class]]) {
            CLBeacon * beacon = original[j];
            if (beacon.proximity == CLProximityUnknown ) {
                
            }else{
                [array addObject:beacon];
            }
        }else{
            
        }
    }
    return array;
}

#pragma mark helper
-(NSString *)string:(NSString*)originalString  FilledWithZeroToLenth:(int)length{
    NSMutableString * string = [NSMutableString stringWithCapacity:5];
    if (originalString.length < length) {
        for (int i = 0 ; i < (length - originalString.length ); i++ ) {
            [string appendString:@"0"];
        }
        [string appendString:originalString];
    }else{
        [string appendString:[originalString substringWithRange:NSMakeRange(0, length)]];
    }
    
    return string;
}

-(BOOL)beacon:(CLBeacon*)beacon1 isEqualToBeacon:(CLBeacon*)beacon2{
    //NSLog(@"compare \n %@ %@ \n %@ %@ \n %@ %@",beacon1.major,beacon2.major ,beacon1.minor,beacon2.minor,beacon1.proximityUUID.UUIDString,beacon2.proximityUUID.UUIDString);
    
    if(beacon1.major == beacon2.major && beacon1.minor == beacon2.minor && [beacon1.proximityUUID.UUIDString isEqualToString:beacon2.proximityUUID.UUIDString]){
        return YES;
    }else{
        return NO;
    }
}

@end

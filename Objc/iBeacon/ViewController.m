//
//  ViewController.m
//  iBeacon_sample
//
//  Created by Kuan-Wei on 2016/5/5.
//  Copyright © 2016年 Kuan-Wei. All rights reserved.
//

#import "ViewController.h"

static NSString * const Terminal_UUID = @"9E350FE2-118F-4840-A203-E39A58C5E41A";
static NSString * const USBeacon_UUID = @"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0";
static NSString * const TEST_POWER_UUID = @"00112233-4455-6677-8899-AABBCCDDEEFF";

@interface ViewController ()

@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager requestWhenInUseAuthorization];
    
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:USBeacon_UUID];
    CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:@"myRegion"];
    
    [self.locationManager startRangingBeaconsInRegion:region];
    [self.locationManager startMonitoringForRegion:region];
    
    NSLog(@"start searching beacon");
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray<CLBeacon *> *)beacons inRegion:(CLBeaconRegion *)region{
    if ([beacons count] > 0) {
        CLBeacon *beacon = [beacons objectAtIndex:0];
        int major = [beacon.major intValue];
        int minor = [beacon.minor intValue];
        CLLocationAccuracy accuracy = beacon.accuracy;
        NSInteger rssi = beacon.rssi;
        
        switch (beacon.proximity) {
            case CLProximityUnknown:
                NSLog(@"%d %d  距離未知(%f)(%lddb)", major, minor, accuracy, (long)rssi);
                break;
            case CLProximityFar:
                NSLog(@"%d %d  距離遠(%f)(%lddb)", major, minor, accuracy, (long)rssi);
                break;
            case CLProximityNear:
                NSLog(@"%d %d  距離附近(%f)(%lddb)", major, minor, accuracy, (long)rssi);
                break;
            case CLProximityImmediate:
                NSLog(@"%d %d  距離旁邊(%f)(%lddb)", major, minor, accuracy, (long)rssi);
                break;
            default:
                break;
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    NSLog(@"進入 %@ 區域", region.identifier);
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
    NSLog(@"離開 %@ 區域", region.identifier);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

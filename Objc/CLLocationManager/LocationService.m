//
//  LocationService.m
//  JPGourmet
//
//  Created by Kuan-Wei Lin on 7/9/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "LocationService.h"

@interface LocationService ()

@property (strong, nonatomic) CLLocationManager *manager;

@end

@implementation LocationService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.manager = [[CLLocationManager alloc] init];
        self.manager.delegate = self;
    }
    return self;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            
            [self.manager requestWhenInUseAuthorization];
            
            break;
        case kCLAuthorizationStatusRestricted:
            
            if ([self.delegate respondsToSelector:@selector(LSAuthRestricted)]) {
                [self.delegate LSAuthRestricted];
            }
            break;
        case kCLAuthorizationStatusDenied:
            
            if ([self.delegate respondsToSelector:@selector(LSAuthDenied)]) {
                [self.delegate LSAuthDenied];
            }
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            NSLog(@"Can use current location");
            break;
            
        default:
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    [self.manager stopUpdatingLocation];
    
    CLLocation *lastLocation = [locations lastObject];
    
    if (lastLocation != nil) {
        if ([self.delegate respondsToSelector:@selector(LSDidUpdateLocation:)]) {
            [self.delegate LSDidUpdateLocation:lastLocation];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(LSDidFailLocation)]) {
        [self.delegate LSDidFailLocation];
    }
}

//MARK: - Application

- (void)startUpdatingLocation{
    [self.manager startUpdatingLocation];
}











@end

//
//  LocationService.h
//  JPGourmet
//
//  Created by Kuan-Wei Lin on 7/9/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreLocation/CoreLocation.h"

@protocol LocationServiceDelegate <NSObject>

@optional
- (void)LSAuthDenied;
- (void)LSAuthRestricted;
- (void)LSAuthorized;
- (void)LSDidUpdateLocation:(CLLocation *)location;
- (void)LSDidFailLocation;

@end

@interface LocationService : NSObject <CLLocationManagerDelegate>

@property (weak, nonatomic) id <LocationServiceDelegate> delegate;

- (void)startUpdatingLocation;

@end

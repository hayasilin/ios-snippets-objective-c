//
//  BeaconDetect.h
//  BeaconSDK
//
//  Created by Kuan-Wei of TaiwanMobile Co.,Ltd. on 2016/5/3
//  Copyright © 2016年 TaiwanMobile Co.,Ltd. All rights reserved.
//

/*!
 @file BeaconDetect.h
 
 @header BeaconDetect.h
 
 @brief This is the header file where iBeacon detection code is contained.
 
 This file contains the most importnant method and properties decalaration. It's parted by many methods in total, which can be used to perform iBeacon device detection.
 
 @author Kuan-Wei
 @copyright  2016 TaiwanMobile Co., Ltd.
 @version    1.0.0
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//Apple iBeacon framework
#import "CoreBluetooth/CoreBluetooth.h"
#import "CoreLocation/CoreLocation.h"

//#import "BeaconController.h"

/*!
 @protocol BeaconDetectDelegate
 
 @brief The BeaconDetectDelegate protocol
 
 The <b>BeaconDetectDelegate</b> is a protocol to provide callback function when it detects iBeacon devices.
 */
@protocol BeaconDetectDelegate <NSObject>

@optional
/*! This method will find the nearest iBeacon once it detect once. */
- (void)BSDKnearestBeaconChangeTo:(CLBeacon*)beacon;
/*! This method will find a list which contains 5 nearest iBeacon devices */
- (void)BSDKbeaconListChangeTo:(NSArray*)beacons;
//fromBeacon parameter will return the Beacon's last 5 MAC Address data for example
- (void)BSDKdidReceivedPowerVoltage:(float)voltage fromBeacon:(NSString *)mac;

//Callback of BeaconController
/*! Call back when is enter a iBeacon device region */
- (void)BSDKisEnterBeaconRegion:(CLRegion *)region;
/*! call back when is exit a iBeacon device region */
- (void)BSDKisExitBeaconRegion:(CLRegion *)region;

@end

/*!
 @class BeaconDetect
 
 @brief The BeaconDetect class
 
 @discussion The purpose of the <b>BeaconDetect</b> class is to provide an application which detect the neariest iBeacon signal.
 
 @remark The <b>BeaconDetect</b> class is a subclass of the <b>NSObject</b>, and it conforms to the <b>CLLocationManagerDelegate</b> protocol.
 
 @superclass SuperClass: NSObject\n
 @classdesign Delegation design.
 */
@interface BeaconDetect : NSObject <CLLocationManagerDelegate>

/*! Delegate property of BeaconDetectDelegate */
@property (weak, nonatomic) id <BeaconDetectDelegate> delegate;

/*!
 @brief It sets a uuid of <b>iBeacon device</b>.
 
 @discussion This method accepts a NSString value representing the uuid for create the BeaconDetect object to store uuid of iBeacon devices.
 
 @param uuid The input value representing the iBeacon device's uuid.
 
 @return BeaconDetect object with initialization.
 */
+ (BeaconDetect *)detectBeaconWithUUID:(NSString*)uuid;

/*!
 @brief It sets mutiple uuids of <b>iBeacon device</b>.
 
 @discussion This method accepts a NSArray value representing a list of uuids for create the BeaconDetect object to store uuids of iBeacon device.
 
 @param uuids The input value representing the list of iBeacon device's uuid.
 
 @return BeaconDetect object with initialization.
 */
//easy start, set iBeacon with multiple uuids
+ (BeaconDetect *)detectBeaconWithUUIDs:(NSArray*)uuids;

/*!
 @brief It sets uuid for detecting iBeacon's voltage, every USBeacon(太和光公司出品的iBeacon) has a unique power uuid for detecting voltage.
 
 @discussion This method accepts a NSString value representing a power uuid for providing the uuid to the powerUUID property to detect iBeacon's poewr region.
 
 @param powerUUID The input value representing the power uuid of the USBeacon.
 
 @remark The power signal of USBeacon will emit every 10 to 20 seconds.
 */
//set uuid for detecting iBeacon's voltage, every USBeacon has a unique power uuid for detecting voltage
-(void)setUUIDForDetectPowerVoltage:(NSString *)powerUUID;


/*!
 @brief It sets mutiple uuids for detecting iBeacon's voltage, every USBeacon(太和光公司出品的iBeacon) has a unique power uuid for detecting voltage.
 
 @discussion This method accepts a NSArray value representing a list of power uuids for providing the uuid to the powerUUID property to detect iBeacon's power region.
 
 @param powerUUIDs The input value representing the power uuid of the USBeacon.
 
 @remark The power signal of USBeacon will emit every 10 to 20 seconds.
 */
- (void)setUUIDsForDetectPowerVoltage: (NSArray *)powerUUIDs;

/*!
 @brief It updates iBeacon device's voltage to the voltageDelayTime property.
 
 @discussion In order not to let the voltageDelayTime property expose to outsider, use this methods to update the property.
 */
- (void)updateVoltageDelayTime: (NSString *)delayTime;

/*!
 @brief It start monitoring iBeacons, both device and voltage.
 
 @discussion This method create CLLocationManager and CLBeaconRegion to start monitoring iBeacon with known target uuid.
 
 @remark It performs everything that is needed to monitoring iBeacon devices.
 */
-(void)startSearching;

/*!
 @brief It is a filter for sorting iBeacon with proximity.
 
 @param original The input value representing the list of iBeacon.
 */
-(NSArray*)beaconsNoUnknownProximity:(NSArray*)original;

/*!
 @brief It is a filter for sorting iBeacon with major and minor.
 
 @param original The input value representing the list of iBeacon.
 */
-(NSArray*)beaconsSortedByMajorMinor:(NSArray*)original;

/*!
 @brief It is a filter for sorting iBeacon with RSSI.
 
 @param original The input value representing the list of iBeacon.
 */
-(NSArray*)beaconsSortedByRSSI:(NSArray*)original;

@end

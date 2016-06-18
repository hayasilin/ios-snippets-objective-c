//
//  ReachabilityViewController.h
//  DailyNews_AFNetworking basic
//
//  Created by Kuan-Wei Lin on 2/5/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Reachability;

@interface ReachabilityViewController : UIViewController

@property (nonatomic) Reachability *hostReachability;
@property (nonatomic) Reachability *internetReachability;
@property (nonatomic) Reachability *wifiReachability;

@end

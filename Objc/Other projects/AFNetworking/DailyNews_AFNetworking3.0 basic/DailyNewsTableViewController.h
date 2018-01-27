//
//  DailyNewsTableViewController.h
//  DailyNews_AFNetworking basic
//
//  Created by Kuan-Wei Lin on 2/5/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Reachability;
@interface DailyNewsTableViewController : UITableViewController

@property(strong, nonatomic) NSDictionary *newsJSON;
@property(strong, nonatomic) NSMutableArray *newsArray;
@property(weak, nonatomic) id responseObject;

@property (nonatomic) Reachability *hostReachability;
@property (nonatomic) Reachability *internetReachability;
@property (nonatomic) Reachability *wifiReachability;

@end

//
//  Shop.h
//  Component
//
//  Created by Kuan-Wei Lin on 7/7/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Shop : NSObject

@property (strong, nonatomic) NSString *gid;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *photoUrl;
@property (strong, nonatomic) NSString *yomi;
@property (strong, nonatomic) NSString *tel;
@property (strong, nonatomic) NSString *address;
@property (nonatomic) double lat;
@property (nonatomic) double lon;
@property (strong, nonatomic) NSString *catchPlay;
@property (nonatomic) BOOL hasCoupon;
@property (strong, nonatomic) NSString *station;
@property (strong, nonatomic) NSString *url;

+ (instancetype)sharedInstance;

@end

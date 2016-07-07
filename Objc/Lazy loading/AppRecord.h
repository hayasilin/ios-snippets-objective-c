//
//  AppRecord.h
//  Component
//
//  Created by Kuan-Wei Lin on 7/7/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppRecord : NSObject

@property (nonatomic, strong) NSString *restaurantName;
@property (nonatomic, strong) UIImage *appIcon;
@property (nonatomic, strong) NSString *imageURLString;
@property (nonatomic, strong) NSString *appURLString;

@end

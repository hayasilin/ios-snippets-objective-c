//
//  IconDownloader.h
//  Component
//
//  Created by Kuan-Wei Lin on 7/7/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AppRecord;

@interface IconDownloader : NSObject

@property (nonatomic, strong) AppRecord *appRecord;
@property (nonatomic, copy) void (^completionHandler)(void);

- (void)startDownload;
- (void)cancelDownload;

@end

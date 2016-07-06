//
//  APIDataManager.h
//  Component
//
//  Created by Kuan-Wei Lin on 7/6/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol APIDataManagerDelegate <NSObject>

@required

@optional
- (void)didCompleteGettingDataFromAPI:(NSArray *)gourmetArray;
- (void)didFailGettingDataFromAPI:(NSError *)error;

@end

@interface APIDataManager : NSObject

@property (weak, nonatomic) id <APIDataManagerDelegate> delegate;
@property (strong, nonatomic) NSArray *gourmetArray;

+ (instancetype)defaultManager;
- (void)getDataFromAPI:(NSString *)urlString;

@end

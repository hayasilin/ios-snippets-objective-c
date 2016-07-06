//
//  ParmsDataManager.h
//  Component
//
//  Created by Kuan-Wei Lin on 7/6/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ParmsDataManagerDelegate <NSObject>

@required

@optional
- (void)didCompleteGettingDataFromAPIParams:(NSArray *)gourmetArray;
- (void)didFailGettingDataFromAPIParams:(NSError *)error;

@end

@interface ParmsDataManager : NSObject

@property (weak, nonatomic) id <ParmsDataManagerDelegate> delegate;
@property (strong, nonatomic) NSArray *gourmetArray;

+ (instancetype)defaultManager;
- (void)getDataFromAPI:(NSString *)urlString;

@end

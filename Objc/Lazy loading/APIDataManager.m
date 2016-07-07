//
//  APIDataManager.m
//  Component
//
//  Created by Kuan-Wei Lin on 7/6/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "APIDataManager.h"

static NSString * const gourmetSushiUrl = @"http://search.olp.yahooapis.jp/OpenLocalPlatform/V1/localSearch?appid=dj0zaiZpPUhhdVJPbm9hMnVUMSZzPWNvbnN1bWVyc2VjcmV0Jng9ZmE-&device=mobile&group=gid&sort=score&output=json&gc=01&query=%E5%AF%BF%E5%8F%B8";

@interface APIDataManager ()

@end

@implementation APIDataManager

+ (instancetype)defaultManager{
    static id manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[[self class] alloc] init];
    });
    
    return manager;
}

- (void)getDataFromAPI:(NSString *)urlString{
    
    NSURL *URLString = [NSURL URLWithString:urlString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:URLString cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:4.0];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTaskRequest = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            self.gourmetArray = json[@"Feature"];
            
            if ([self.delegate respondsToSelector:@selector(didCompleteGettingDataFromAPI:)]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.delegate didCompleteGettingDataFromAPI:self.gourmetArray];
                });
            }
            
        }else{
            if ([self.delegate respondsToSelector:@selector(didFailGettingDataFromAPI:)]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.delegate didFailGettingDataFromAPI:error];
                });
            }
        }
        
    }];
    [dataTaskRequest resume];
    [session finishTasksAndInvalidate];
}



@end

//
//  ParmsDataManager.m
//  Component
//
//  Created by Kuan-Wei Lin on 7/6/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ParmsDataManager.h"

@interface ParmsDataManager ()

//QueryCondition
@property (strong, nonatomic) NSString *query;
@property (strong, nonatomic) NSMutableDictionary *queryParams;

//YahooSearch
@property (strong, nonatomic) NSString *apiID;
@property (strong, nonatomic) NSString *apiUrl;

@end

@implementation ParmsDataManager

+ (instancetype)defaultManager{
    static id manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[[self class] alloc] init];
    });
    
    return manager;
}

//Sort dictionary into long string
- (NSString *)stringForHTTPPost:(NSDictionary*)parms {
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *key in parms) {
        id obj = [parms objectForKey:key];
        NSString *value;
        
        if ([obj isKindOfClass:[NSString class]]) {
            value = obj;
        } else if ([obj isKindOfClass:[NSNumber class]]) {
            value = [(NSNumber *)obj stringValue];
        } else if ([obj isKindOfClass:[NSURL class]]) {
            value = [(NSURL *)obj absoluteString];
        } else {
            value = [obj description];
        }
        [array addObject:[NSString stringWithFormat:@"%@=%@", key, value]];
    }
    NSString *postString = [array componentsJoinedByString:@"&"];
    NSLog(@"postString = %@", postString);
    return postString;
}

- (void)getDataFromAPI:(NSString *)urlString{
    
    self.apiUrl = @"http://search.olp.yahooapis.jp/OpenLocalPlatform/V1/localSearch";
    self.apiID = @"dj0zaiZpPUhhdVJPbm9hMnVUMSZzPWNvbnN1bWVyc2VjcmV0Jng9ZmE-";
    
    //Start queryParams
    self.queryParams = [NSMutableDictionary dictionary];
    
    [self.queryParams setObject:_apiID forKey:@"appid"];
    [self.queryParams setObject:@"json" forKey:@"output"];
    [self.queryParams setObject:@"tokyo" forKey:@"query"];
    [self.queryParams setObject:@"gid" forKey:@"group"];

    NSLog(@"queryParams = %@", self.queryParams);
    
    
    NSString *postStr = [self stringForHTTPPost:self.queryParams];
    
//    NSData *postData = [postStr dataUsingEncoding:NSUTF8StringEncoding];
//    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", self.apiUrl]];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", self.apiUrl, postStr]];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:4.0];
    
    [urlRequest setHTTPMethod:@"POST"];
//    [urlRequest setHTTPBody:postData];
//    [urlRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [urlRequest setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Current-Type"];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTaskRequest = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if (!error) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"response = %@", response);

            self.gourmetArray = json[@"Feature"];
            NSLog(@"Feature = %@", self.gourmetArray[0]);

            if ([self.delegate respondsToSelector:@selector(didCompleteGettingDataFromAPIParams:)]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.delegate didCompleteGettingDataFromAPIParams:self.gourmetArray[0]];
                });
            }

        }else{
            if ([self.delegate respondsToSelector:@selector(didFailGettingDataFromAPIParams:)]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.delegate didFailGettingDataFromAPIParams:error];
                });
            }
        }

    }];
    [dataTaskRequest resume];
    [session finishTasksAndInvalidate];

}

@end

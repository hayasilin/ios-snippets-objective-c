//
//  ViewController.m
//  Component
//
//  Created by Kuan-Wei Lin on 6/18/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"

static NSString * const gourmetSushiUrl = @"http://search.olp.yahooapis.jp/OpenLocalPlatform/V1/localSearch?appid=dj0zaiZpPUhhdVJPbm9hMnVUMSZzPWNvbnN1bWVyc2VjcmV0Jng9ZmE-&device=mobile&group=gid&sort=score&output=json&gc=01&query=%E5%AF%BF%E5%8F%B8";

@interface ViewController ()

@property (strong, nonatomic) APIDataManager *apiDataManager;

@property (strong, nonatomic) ParmsDataManager *paramsDataManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    self.apiDataManager = [APIDataManager defaultManager];
    self.apiDataManager.delegate = self;
    
    [self.apiDataManager getDataFromAPI:gourmetSushiUrl];
    
    self.paramsDataManager = [ParmsDataManager defaultManager];
    self.paramsDataManager.delegate = self;
    [self.paramsDataManager getDataFromAPI:nil];
}

#pragma mark - APIDataManagerDelegate
- (void)didCompleteGettingDataFromAPI:(NSArray *)gourmetArray{
    NSLog(@"api = %@", gourmetArray);
}

- (void)didFailGettingDataFromAPI:(NSError *)error{
    NSLog(@"error = %@", error.description);
}

#pragma mark - ParmsDataManagerDelegate
- (void)didCompleteGettingDataFromAPIParams:(NSArray *)gourmetArray{
    NSLog(@"params = %@", gourmetArray);
}

- (void)didFailGettingDataFromAPIParams:(NSError *)error{
    NSLog(@"error = %@", error.description);
}

@end

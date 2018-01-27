//
//  ViewController.m
//  UnitTesting
//
//  Created by Kuan-Wei Lin on 12/11/16.
//  Copyright © 2016 cracktheterm. All rights reserved.
//

#import "ViewController.h"

static NSString * const gourmetSushiUrl = @"http://search.olp.yahooapis.jp/OpenLocalPlatform/V1/localSearch?appid=dj0zaiZpPUhhdVJPbm9hMnVUMSZzPWNvbnN1bWVyc2VjcmV0Jng9ZmE-&device=mobile&group=gid&sort=score&output=json&gc=01&query=%E5%AF%BF%E5%8F%B8";


@interface ViewController ()

@end

@implementation ViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //[self getDataFromAPI:gourmetSushiUrl];
    
    NSArray *arr = @[@(-1), @(3) , @(-10), @(-20), @(40), @(5)];
    
    NSLog(@"max = %i", [self theMaxValueMultipliedBynumberArray:arr]);
}

-(int)theMaxValueMultipliedBynumberArray: (NSArray<NSNumber *>*)nums
{
    NSNumber *num1 = nums[0];
    int value1 = [num1 intValue];
    
    if (value1 < 0)
    {
        value1 = value1 * -1;
    }
    
    NSNumber *num2 = nums[1];
    int value2 = [num2 intValue];
    
    if (value2 < 0)
    {
        value2 = value2 * -1;
    }
    
    int maxValue = value1 * value2;
    
    
    for (int i = 1; i < nums.count - 1; i ++)
    {
        NSNumber *num1 = nums[i];
        int value1 = [num1 intValue];
        
        if (value1 < 0)
        {
            value1 = value1 * -1;
        }
        
        NSNumber *num2 = nums[i+1];
        int value2 = [num2 intValue];
        
        if (value2 < 0)
        {
            value2 = value2 * -1;
        }
        
        int newValue = value1 * value2;
        
        if (newValue > maxValue)
        {
            maxValue = newValue;
        }
    }
    
    return maxValue;
}


- (void)blockCallbackDemo:(NSString *)str complete:(void(^)(NSArray *arr))completeHandler
{
    
    //NSArray *arrDemo = @[@"1", @"2", @"3"];
//    NSDictionary *dictDemo = @{
//                               @"1":@"one",
//                               @"2":@"two",
//                               @"3":@"three"};
    
    
    NSURL *URLString = [NSURL URLWithString:gourmetSushiUrl];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:URLString cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:4.0];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTaskRequest = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error)
        {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            self.gourmetArray = json[@"Feature"];
            //NSLog(@"Feature = %@", self.gourmetArray[0]);
            
            completeHandler(self.gourmetArray);
            
        }else
        {
            NSLog(@"error = %@", error.localizedDescription);
        }
        
    }];
    [dataTaskRequest resume];
    [session finishTasksAndInvalidate];
    
}

- (void)getDataFromAPI:(NSString *)urlString{
    
    NSURL *URLString = [NSURL URLWithString:urlString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:URLString cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:4.0];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTaskRequest = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error)
        {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            self.gourmetArray = json[@"Feature"];
            //NSLog(@"Feature = %@", self.gourmetArray[0]);
            
            
        }else
        {
            NSLog(@"error = %@", error.localizedDescription);
        }
        
    }];
    [dataTaskRequest resume];
    [session finishTasksAndInvalidate];
}

- (int)divideTwo:(int)num1 num2:(int)num2
{
    int i = (num1 + num2) / 2;
    
    return i;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

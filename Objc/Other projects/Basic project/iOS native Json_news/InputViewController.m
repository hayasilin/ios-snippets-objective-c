//
//  InputViewController.m
//  iOS native Json
//
//  Created by Kuan-Wei Lin on 3/6/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "InputViewController.h"

@interface InputViewController ()

@end

@implementation InputViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.newsUrl = @"https://ajax.googleapis.com/ajax/services/search/news?v=1.0&topic=p&hl=ja&rsz=8";
    self.taipeiUrl = @"http://data.taipei.gov.tw/opendata/apply/json/RkRDNjk0QzUtNzdGRC00ODFCLUJBNDktNEJCMUVCMDc3ODFE";
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:self.taipeiUrl] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        //NSLog(@"%@", json);
        
        self.newsArray = [json valueForKey:@"name"];
        
        //self.newsArray = json[@"responseData"][@"results"];
        
        NSLog(@"%@", self.newsArray);
    }];
    [dataTask resume];
    

    
    /*
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:self.newsUrl] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@", json);
    }];
    
    [dataTask resume];
    */
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)buttonClicked:(id)sender {
    for (int i = 0; i < self.newsArray.count; i++) {
        NSString *str = [NSString stringWithFormat:@"1 = %@", self.newsArray[i]];
        self.nameLabel.text = str;
    }
}
@end

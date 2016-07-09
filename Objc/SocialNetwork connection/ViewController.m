//
//  ViewController.m
//  table
//
//  Created by Kuan-Wei Lin on 7/7/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"
#import "Social/Social.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)dealloc{
    NSLog(@"vc dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Check the status of the usage of Line, Facebook, and Twitter
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"line://"]]) {
        _lineButton.enabled = YES;
    }
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        _twitterButton.enabled = YES;
    }
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        _facebookButton.enabled = YES;
    }
}

#pragma mark - Application logic: Social framework
- (void)share:(NSString *)type{
    NSString *name = @"Yahoo homepage japan";
    NSString *urlString = @"http://www.yahoo.com.jp";
    NSURL *url = [NSURL URLWithString:urlString];
    
    SLComposeViewController *vc = [SLComposeViewController composeViewControllerForServiceType:type];
    [vc setInitialText:[NSString stringWithFormat:@"%@\n", name]];
    [vc addURL:url];
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)lineTapped:(UIButton *)sender {
    NSString *urlString = @"http://loco.yahoo.co.jp/place/g-b6iwu0xvWok";
    NSString *message = @"";
    NSString *newMessage = @"";
    
    NSString *name = @"Store name";
    message = [NSString stringWithFormat:@"%@\n", name];
    newMessage = [message stringByAppendingString:[NSString stringWithFormat:@"%@\n", urlString]];
    
    NSString *encoded = [newMessage stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *uri = [NSURL URLWithString:[NSString stringWithFormat:@"line://msg/text/%@", encoded]];
    [[UIApplication sharedApplication] openURL:uri];
}

- (IBAction)facebookTapped:(UIButton *)sender {
    [self share:SLServiceTypeFacebook];
}

- (IBAction)twitterTapped:(UIButton *)sender {
    [self share:SLServiceTypeTwitter];
}

@end

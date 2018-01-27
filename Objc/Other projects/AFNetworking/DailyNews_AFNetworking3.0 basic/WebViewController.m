//
//  WebViewController.m
//  DailyNews_AFNetworking basic
//
//  Created by Kuan-Wei Lin on 2/5/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController
@synthesize newsUrl, indicatorView, webView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.webView.delegate = self;
    NSURL *url = [NSURL URLWithString:newsUrl];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [indicatorView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [indicatorView stopAnimating];
}

@end

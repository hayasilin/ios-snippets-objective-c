//
//  WebViewController.m
//  YoutubeApp_objc
//
//  Created by Kuan-Wei Lin on 10/6/15.
//  Copyright © 2015 Kuan-Wei Lin. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController
@synthesize newsUrl, webView, indicator;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.delegate = self;
    
    NSURL *url = [NSURL URLWithString:newsUrl];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:urlRequest];
    
    NSLog(@"%@", newsUrl);
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    //NSLog(@"start loading");
    [indicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //NSLog(@"Finish loading");
    [indicator stopAnimating];
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

@end

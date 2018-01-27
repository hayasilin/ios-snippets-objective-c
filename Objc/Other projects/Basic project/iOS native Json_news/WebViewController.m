//
//  WebViewController.m
//  iOS native Json
//
//  Created by Kuan-Wei Lin on 4/16/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.delegate = self;
    
    NSURL *url = [NSURL URLWithString:self.urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.indicatorView stopAnimating];
    self.indicatorView.hidesWhenStopped = YES;
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

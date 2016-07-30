//
//  ViewController.m
//  Components
//
//  Created by Kuan-Wei Lin on 7/11/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicatorView;

@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) UIView *loadingView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
}

- (IBAction)startDefaultActivityIndicator:(UIButton *)sender {
    
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    self.activityIndicatorView.center = self.view.center;
    self.activityIndicatorView.hidesWhenStopped = YES;
    self.activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [self.view addSubview:self.activityIndicatorView];
    [self.activityIndicatorView startAnimating];
}

- (IBAction)startCustomActivityIndicator:(UIButton *)sender {
    
    self.containerView = [[UIView alloc] init];
    self.containerView.frame = self.view.frame;
    self.containerView.backgroundColor = [UIColor colorWithRed:200 green:200 blue:200 alpha:0.3];
    
    self.loadingView = [[UIView alloc] init];
    self.loadingView.frame = CGRectMake(0, 0, 80, 80);
    self.loadingView.center = self.view.center;
    self.loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    self.loadingView.clipsToBounds = YES;
    self.loadingView.layer.cornerRadius = 10;
    
    self.activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    self.activityIndicatorView.center = CGPointMake(self.loadingView.frame.size.width / 2, self.loadingView.frame.size.height /2);
    
    [self.loadingView addSubview:self.activityIndicatorView];
    [self.containerView addSubview:self.loadingView];
    [self.view addSubview:self.containerView];
    
    [self.activityIndicatorView startAnimating];
    
    [self performSelector:@selector(stopCustomActivityIndicator) withObject:nil afterDelay:5];
}

- (IBAction)stopActivityIndicator:(UIButton *)sender {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.activityIndicatorView stopAnimating];
}

- (void)stopCustomActivityIndicator{
    
    [self.activityIndicatorView stopAnimating];
    [self.loadingView removeFromSuperview];
    [self.containerView removeFromSuperview];
}



@end

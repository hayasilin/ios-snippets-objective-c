//
//  ViewController.m
//  YoutubeApp_objc
//
//  Created by Kuan-Wei Lin on 10/5/15.
//  Copyright © 2015 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"
#import "SWRevealViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.showBtn.target = self.revealViewController;
    self.showBtn.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end

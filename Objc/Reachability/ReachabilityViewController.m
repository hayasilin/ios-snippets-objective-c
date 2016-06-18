//
//  ReachabilityViewController.m
//
//  Created by Kuan-Wei Lin on 2/5/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ReachabilityViewController.h"
#import "Reachability.h"

@interface ReachabilityViewController ()

@end

@implementation ReachabilityViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.hostReachability = [Reachability reachabilityWithHostName:@"www.apple.com"];
    [self.hostReachability startNotifier];
    
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    
    self.wifiReachability = [Reachability reachabilityForLocalWiFi];
    [self.wifiReachability startNotifier];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
}

- (void)reachabilityChanged: (NSNotification *)notification{
    Reachability *reachability = [notification object];
    [self logReachability:reachability];
}

- (void) logReachability: (Reachability *)reachability{
    NSString *whichReachabilityString = nil;
    if (reachability == self.hostReachability) {
        whichReachabilityString = @"www.apple.com";
    }else if (reachability == self.internetReachability){
        whichReachabilityString = @"The internet";
    }else if (reachability == self.wifiReachability){
        whichReachabilityString = @"Local Wi-Fi";
    }
    
    NSString *howReachableString = nil;
    switch (reachability.currentReachabilityStatus) {
        case NotReachable:{
            howReachableString = @"not reachable";
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"注意" message:@"並無偵測到網路連線，請再次確認喔！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:alertAction];
            [self presentViewController:alertController animated:YES completion:nil];
            break;
        }
        case ReachableViaWWAN:{
            howReachableString = @"Reachable via cellular data";
            break;
        }
        case ReachableViaWiFi:{
            howReachableString = @"Reachable via wifi";
            break;
        }
    }
    NSLog(@"%@, %@", whichReachabilityString, howReachableString);
}

- (void) viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
 
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

@end

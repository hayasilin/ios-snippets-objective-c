//
//  AppDelegate.m
//  iOS native Json
//
//  Created by Kuan-Wei Lin on 3/6/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "AppDelegate.h"

static NSString * const taipeiUrl = @"http://data.taipei.gov.tw/opendata/apply/json/RkRDNjk0QzUtNzdGRC00ODFCLUJBNDktNEJCMUVCMDc3ODFE";

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //UI
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //create the navigation controller and add the controllers view to the window
    self.navigationController = [[UINavigationController alloc] init];
    [self.window addSubview:[self.navigationController view]];
    
    NewsTableViewController *newsViewController = [[NewsTableViewController alloc] initWithNibName:@"NewsTableViewController" bundle:nil];
    
    //push the first viewcontroller into the navigation view controller stack
    [self.navigationController pushViewController:newsViewController animated:YES];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    
    // show in the status bar that network activity is starting
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//    
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:taipeiUrl] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
//        
//        if (error != nil){
//            [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
//                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//                
//                if ([error code] == NSURLErrorAppTransportSecurityRequiresSecureConnection){
//                    abort();
//                }
//                else{
//                    [self handleError:error];
//                }
//            }];
//        }
//        else{
//            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            //
//            //            self.newsArray = [json valueForKey:@"name"];
//            self.urlArray = [json valueForKey:@"website"];
//            //            NSLog(@"%@", self.newsArray);
//            
//            NSLog(@"%@", self.urlArray);
//            
//            __weak AppDelegate *weakSelf = self;
//            
//            dispatch_async(dispatch_get_main_queue(), ^(void){
//                
//                //NewsTableViewController *rootViewController = (NewsTableViewController *)[(UINavigationController *)weakSelf.window.rootViewController topViewController];
//                
//                NewsTableViewController *rootViewController = (NewsTableViewController *)[self.navigationController topViewController];
//                
//                [rootViewController.tableView reloadData];//無法真正的reload TableView
//            });
//            // show in the status bar that network activity is starting
//            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        }
//    }];
//    
//    [dataTask resume];
//    [session finishTasksAndInvalidate];
    
    return YES;
}

//	handleError:error
//  Reports any error with an alert which was received from connection or loading failures.
- (void)handleError:(NSError *)error
{
    NSString *errorMessage = [error localizedDescription];
    
    // alert user that our current record was deleted, and then we leave this view controller
    //
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"There is something wrong" message:errorMessage preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // dissmissal of alert completed
    }];
    
    [alert addAction:OKAction];
    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

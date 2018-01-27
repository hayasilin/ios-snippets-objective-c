//
//  DailyNewsTableViewController.m
//  DailyNews_AFNetworking basic
//
//  Created by Kuan-Wei Lin on 2/5/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "DailyNewsTableViewController.h"
#import "AFNetworking/AFNetworking.h"
#import "WebViewController.h"
#import "Reachability.h"

@interface DailyNewsTableViewController ()
{
    NSString *newsUrl;
    NSString *publisher;
    
}
@end

@implementation DailyNewsTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.hostReachability = [Reachability reachabilityWithHostName:@"www.apple.com"];
    [self.hostReachability startNotifier];
    
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    
    self.wifiReachability = [Reachability reachabilityForLocalWiFi];
    [self.wifiReachability startNotifier];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    /*
    self.hostReachability = [Reachability reachabilityWithHostName:@"www.apple.com"];
    [self.hostReachability startNotifier];
    
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    
    self.wifiReachability = [Reachability reachabilityForLocalWiFi];
    [self.wifiReachability startNotifier];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object: nil];
     */
}

- (void)reachabilityChanged:(NSNotification *)notification{
    Reachability *reachability = [notification object];
    [self logReachability:reachability];
}

/*
- (void)reachabilityChanged:(NSNotification *)notification {
    Reachability *reachability = [notification object];
    [self logReachability: reachability];
}
*/

- (void)logReachability: (Reachability *)reachability{
    NSString *whichReachabilityString = nil;
    if (reachability == self.hostReachability) {
        whichReachabilityString = @"www.apple.com";
    }else if (reachability == self.internetReachability){
        whichReachabilityString = @"The Internet";
    }else if (reachability == self.wifiReachability){
        whichReachabilityString = @"Local Wi-Fi";
    }
    
    NSString *howReachableString = nil;
    switch (reachability.currentReachabilityStatus) {
        case NotReachable:{
            howReachableString = @"not reachable";
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"注意" message:@"沒有偵測到網路，請確認網路連線" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:alertAction];
            [self presentViewController:alertController animated:YES completion:^{
                NSLog(@"presentviewcontroller");
            }];
            break;
        }
        case ReachableViaWWAN:{
            howReachableString = @"Reachable by cellular data";
            break;
        }
        case ReachableViaWiFi:{
            howReachableString = @"Reachable by Wi-Fi";
            break;
        }
    }
    NSLog(@"%@ %@", whichReachabilityString, howReachableString);
}

/*
- (void)logReachability:(Reachability *)reachability {
    
    NSString *whichReachabilityString = nil;
    
    if (reachability == self.hostReachability) {
        whichReachabilityString = @"www.apple.com";
    } else if (reachability == self.internetReachability) {
        whichReachabilityString = @"The Internet";
    } else if (reachability == self.wifiReachability) {
        whichReachabilityString = @"Local Wi-Fi";
    }
    NSString *howReachableString = nil;
    switch (reachability.currentReachabilityStatus) {
        case NotReachable: {
            howReachableString = @"not reachable";
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"注意" message:@"手機目前沒有連上網路喔，請確認網路連線" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
            break;
        }
        case ReachableViaWWAN: {
            howReachableString = @"reachable by cellular data";
            break;
        }
        case ReachableViaWiFi: {
            howReachableString = @"reachable by Wi-Fi";
            break;
        }
    }
    
    NSLog(@"%@ %@", whichReachabilityString, howReachableString);
}
*/

- (void) viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
-(void) viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
 */

 
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self reloadData];
    
    
    //[self logReachability:self.hostReachability];
    //[self logReachability:self.internetReachability];
    //[self logReachability:self.wifiReachability];
    
    
}

- (void)reloadData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:@"https://ajax.googleapis.com/ajax/services/search/news?v=1.0&topic=p&hl=ja&rsz=8"] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject){
        self.newsJSON = (NSDictionary *)responseObject;
        self.newsArray = self.newsJSON[@"responseData"][@"results"];
        NSLog(@"%@", self.newsArray);
        [self.tableView reloadData];
    }failure:^(NSURLSessionTask *operation, NSError *error){
        NSLog(@"Error: %@", error);
    }];
    
    
    /*
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:@"https://ajax.googleapis.com/ajax/services/search/news?v=1.0&topic=p&hl=ja&rsz=8"] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        self.newsJSON = (NSDictionary *)responseObject;
        self.newsArray = self.newsJSON[@"responseData"][@"results"];
        
        //NSLog(@"%@", self.newsArray);
        
        [self.tableView reloadData];
        
    }failure:^(NSURLSessionTask *operation, NSError *error) {
        //NSLog(@"Error: %@", error);
    }];
     */
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    UILabel *label = (UILabel *)[cell viewWithTag:101];
    label.text = [[self.newsArray valueForKey:@"title"] objectAtIndex:indexPath.row];
    
    UILabel *detailLabel = (UILabel *)[cell viewWithTag:102];
    detailLabel.text = [[self.newsArray valueForKey:@"publisher"] objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    newsUrl = [[self.newsArray valueForKey:@"unescapedUrl"] objectAtIndex:indexPath.row];
    publisher = [[self.newsArray valueForKey:@"publisher"] objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"toWebView" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    WebViewController *wvc = segue.destinationViewController;
    wvc.newsUrl = newsUrl;
    wvc.title = publisher;
}


@end

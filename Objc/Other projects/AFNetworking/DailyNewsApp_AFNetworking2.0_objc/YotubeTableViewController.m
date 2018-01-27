//
//  YotubeTableViewController.m
//  YoutubeApp_objc
//
//  Created by Kuan-Wei Lin on 10/5/15.
//  Copyright © 2015 Kuan-Wei Lin. All rights reserved.
//

#import "YotubeTableViewController.h"
#import "SWRevealViewController.h"
#import "AFNetworking/AFNetworking.h"
#import "WebViewController.h"

@interface YotubeTableViewController ()
{
    NSString *newsUrl;
    NSString *publisher;
}
@end

@implementation YotubeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.showBtn.target = self.revealViewController;
    self.showBtn.action = @selector(revealToggle:);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    self.YoutubeArray = [[NSMutableArray alloc] init];
    
    [self reloadData];
}

- (void)reloadData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:[NSString stringWithFormat:@"https://ajax.googleapis.com/ajax/services/search/news?v=1.0&topic=p&hl=ja&rsz=8"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        self.YoutubeJSON = (NSDictionary *)responseObject;
        self.YoutubeArray = self.YoutubeJSON[@"responseData"][@"results"];
        
        [self.tableView reloadData];
        
        //NSLog(@"%@", self.YoutubeArray);
        
    }failure:^(AFHTTPRequestOperation *operation, id responseObject){
            
    }];
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
    return self.YoutubeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    UILabel *label = (UILabel *)[cell viewWithTag:101];
    label.text = [[self.YoutubeArray valueForKey:@"title"] objectAtIndex:indexPath.row];;
    
    UILabel *detailLabel = (UILabel *)[cell viewWithTag:102];
    detailLabel.text = [[self.YoutubeArray valueForKey:@"publisher"] objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    newsUrl = [[self.YoutubeArray valueForKey:@"unescapedUrl"] objectAtIndex:indexPath.row];
    publisher = [[self.YoutubeArray valueForKey:@"publisher"] objectAtIndex:indexPath.row];
    
    //NSLog(@"%@ / %@", newsUrl, publisher);
    
    [self performSegueWithIdentifier:@"toWebView" sender:self];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    WebViewController *wvc = segue.destinationViewController;
    wvc.newsUrl = newsUrl;
    wvc.title = publisher;
}


@end

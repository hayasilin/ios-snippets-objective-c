//
//  NewsTableViewController.m
//  iOS native Json
//
//  Created by Kuan-Wei Lin on 4/15/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "NewsTableViewController.h"
#import "NewsTableViewCell.h"
#import "WebViewController.h"

static NSString * const taipeiUrl = @"http://data.taipei.gov.tw/opendata/apply/json/RkRDNjk0QzUtNzdGRC00ODFCLUJBNDktNEJCMUVCMDc3ODFE";
static NSString * const urlString = @"https://ajax.googleapis.com/ajax/services/search/news?v=1.0&topic=p&hl=ja&rsz=8";

@interface NewsTableViewController ()

@end

@implementation NewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"reload" style:UIBarButtonItemStyleDone target:self  action:@selector(reloadData)];
    self.navigationItem.rightBarButtonItem = rightButton;
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    [self reloadData];

    //UIRefreshControl
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(handleRefresh) forControlEvents:UIControlEventValueChanged];
    //End
    
    //UISearchController
    _mySearchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _mySearchController.searchResultsUpdater = self;
    _mySearchController.dimsBackgroundDuringPresentation = NO;
    
    CGRect rect = _mySearchController.searchBar.frame;
    rect.size.height = 44.0;
    _mySearchController.searchBar.frame = rect;
    
    self.tableView.tableHeaderView = _mySearchController.searchBar;
    self.definesPresentationContext = YES;
    //End
}

- (void)viewDidAppear:(BOOL)animated{
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"Refresh"];
}

- (void)reloadData{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    //NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:taipeiUrl] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        self.newsArray = [json valueForKey:@"name"];
        self.urlArray = [json valueForKey:@"website"];
        
        //self.newsArray = json[@"responseData"][@"results"];
        NSLog(@"%@", self.urlArray);
        
        [self.tableView reloadData];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
    
    [dataTask resume];
    [session finishTasksAndInvalidate];
}

- (void)handleRefresh{
    //進行資料更新程序
    //模擬資料更新[NSThread sleepForTimeInterval:2.0];
    [self.refreshControl endRefreshing];
    [self.tableView reloadData];
}

#pragma mark - NSURLSessionDataDelegate
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{
    NSLog(@"response = %@", response);
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    NSLog(@"didReceiveData");
    //偶爾會發生傳回json資料是null的情況，不確定原因
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    self.newsArray = [json valueForKey:@"name"];
    self.urlArray = [json valueForKey:@"website"];

    //self.newsArray = json[@"responseData"][@"results"];
    NSLog(@"%@", self.urlArray);

    [self.tableView reloadData];
}

#pragma mark - NSURLSessionTaskDelegate
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    if (error) {
        NSLog(@"error: %@", error.description);
    }else{
        
    }
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_searchResult != nil) {
        return _searchResult.count;
    }else{
        return self.newsArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    }
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    }
    
    if (_searchResult != nil) {
        cell.textLabel.text = [_searchResult objectAtIndex:indexPath.row];
    }else{
        cell.textLabel.text = self.newsArray[indexPath.row];
        cell.detailTextLabel.text = self.urlArray[indexPath.row];
    }
    
    return cell;
}

//SearchController
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    if (searchController.isActive) {
        NSString *searchString = searchController.searchBar.text;
        
        if ([searchString length] > 0) {
            NSPredicate *p = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@", searchString];
            _searchResult = [self.newsArray filteredArrayUsingPredicate:p];
        }else{
            _searchResult = nil;
        }
    }else{
        _searchResult = nil;
    }
    
    [self.tableView reloadData];
}

#pragma Shaking event
//模擬搖晃事件
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (event.subtype == UIEventSubtypeMotionShake) {
        [self reloadData];
        NSLog(@"My iPhone is shaking");
    }
}

- (BOOL)canBecomeFirstResponder{
    return YES;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.newsArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    [self.newsArray exchangeObjectAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
}

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    WebViewController *detailViewController = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    
    self.newsUrl = [self.newsArray objectAtIndex:indexPath.row];
    self.taipeiUrlString = [self.urlArray objectAtIndex: indexPath.row];
    detailViewController.navigationItem.title = self.newsUrl;
    detailViewController.urlString = self.taipeiUrlString;
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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

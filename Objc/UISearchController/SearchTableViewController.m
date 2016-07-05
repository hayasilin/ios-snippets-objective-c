//
//  SearchTableViewController.m
//  Component
//
//  Created by Kuan-Wei Lin on 7/5/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "SearchTableViewController.h"

@interface SearchTableViewController ()

@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) NSArray *searchResultArray;
@property (strong, nonatomic) UISearchController *mySearchController;

@end

@implementation SearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = @[@"David", @"Ellen", @"Peter", @"Tom", @"Jerry", @"Ellen", @"Peter", @"Tom", @"Jerry", @"Ellen", @"Peter", @"Tom", @"Jerry", @"Ellen", @"Peter", @"Tom", @"Jerry", @"Ellen", @"Peter", @"Tom", @"Jerry"];
    //self.dataArray = @[@"David", @"Ellen", @"Peter", @"Tom", @"Jerry"];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    UIBarButtonItem *goTopButton = [[UIBarButtonItem alloc] initWithTitle:@"hideSearchBar" style:UIBarButtonItemStyleDone target:self action:@selector(hideSearchBar)];
    
    self.navigationItem.rightBarButtonItem = goTopButton;

    self.mySearchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.mySearchController.searchResultsUpdater = self;
    self.mySearchController.dimsBackgroundDuringPresentation = NO;
    
    CGRect rect = _mySearchController.searchBar.frame;
    rect.size.height = 44.0;
    _mySearchController.searchBar.frame = rect;
    
    self.tableView.tableHeaderView = _mySearchController.searchBar;
    self.definesPresentationContext = YES;
    
    //下方兩段功能一樣，皆是能夠隱藏tableHeaderView，但是tableView長度要超過window才有效果
    //[self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [self.tableView setContentOffset:CGPointMake(0, 44) animated:YES];
    
    //如果資料不夠多，用延遲的方法可以隱藏SearchBar
    //[self performSelector:@selector(hideSearchBar) withObject:nil afterDelay:0.01];
}

- (void)hideSearchBar{
    [self.tableView setContentOffset:CGPointMake(0, -20) animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchResultArray != nil) {
        return self.searchResultArray.count;
    }
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if (_searchResultArray != nil) {
        cell.textLabel.text = _searchResultArray[indexPath.row];
    }else{
        cell.textLabel.text = self.dataArray[indexPath.row];
    }

    return cell;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    if (searchController.isActive) {
        NSString *searchString = searchController.searchBar.text;
        
        if ([searchString length] > 0) {
            NSPredicate *p = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@", searchString];
            _searchResultArray = [self.dataArray filteredArrayUsingPredicate:p];
        }else{
            _searchResultArray = nil;
        }
    }else{
        _searchResultArray = nil;
    }
    
    [self.tableView reloadData];
}

@end

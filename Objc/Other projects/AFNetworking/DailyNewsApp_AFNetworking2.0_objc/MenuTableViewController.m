//
//  MenuTableViewController.m
//  YoutubeApp_objc
//
//  Created by Kuan-Wei Lin on 10/5/15.
//  Copyright © 2015 Kuan-Wei Lin. All rights reserved.
//

#import "MenuTableViewController.h"
#import "SWRevealViewController.h"

@interface MenuTableViewController ()

@end

@implementation MenuTableViewController
{
    NSArray *menu;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    menu = @[@"first", @"second"];
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
    return menu.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = [menu objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}


@end

//
//  RearViewController.m
//  Component
//
//  Created by Kuan-Wei Lin on 6/19/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "RearViewController.h"
#import "SWRevealViewController.h"
#import "FrontViewController.h"

@interface RearViewController ()
{
    NSInteger _presentedRow;
}

@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation RearViewController

- (void)viewDidLoad{
    self.rearTableView.dataSource = self;
    self.rearTableView.delegate = self;
    self.rearTableView.backgroundColor = [UIColor darkGrayColor];
    
    self.dataArray = @[@"First", @"Second", @"Third"];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Grab a handle to the reveal controller, as if you'd do with a navigtion controller via self.navigationController.
    SWRevealViewController *revealController = self.revealViewController;
    
    // selecting row
    NSInteger row = indexPath.row;
    
    // if we are trying to push the same row or perform an operation that does not imply frontViewController replacement
    // we'll just set position and return
    
    if ( row == _presentedRow ){
        [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
        return;
    }else if (row == 2){
        [revealController setFrontViewPosition:FrontViewPositionRightMost animated:YES];
        return;
    }else if (row == 3){
        [revealController setFrontViewPosition:FrontViewPositionRight animated:YES];
        return;
    }
    
    // otherwise we'll create a new frontViewController and push it with animation
    UIViewController *newFrontController = nil;
    
    if (row == 0){
        newFrontController = [[FrontViewController alloc] init];
    }else if (row == 1){
        newFrontController = [[FrontViewController alloc] init];
    }else if (row == 2){
         newFrontController = [[FrontViewController alloc] init];
    }
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newFrontController];
    [revealController pushFrontViewController:navigationController animated:YES];
    
    _presentedRow = row;  // <- store the presented row
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}



@end

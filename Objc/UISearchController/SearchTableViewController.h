//
//  SearchTableViewController.h
//  Component
//
//  Created by Kuan-Wei Lin on 7/5/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

//
//  ViewController.h
//  Component
//
//  Created by Kuan-Wei Lin on 6/18/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LazyLoadingTableViewCell.h"
#import "APIDataManager.h"
#import "AppRecord.h"
#import "IconDownloader.h"
#import "Shop.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, APIDataManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *shops;

@end


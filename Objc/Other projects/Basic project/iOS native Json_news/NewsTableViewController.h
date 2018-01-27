//
//  NewsTableViewController.h
//  iOS native Json
//
//  Created by Kuan-Wei Lin on 4/15/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewController : UITableViewController <UISearchResultsUpdating, NSURLSessionTaskDelegate, NSURLSessionDataDelegate>

@property (strong, nonatomic) UILabel *titleLabel;
@property (weak, nonatomic) UILabel *publisherLabel;

@property (nonatomic, strong) NSString *newsUrl;
@property (nonatomic, strong) NSString *taipeiUrlString;

@property (strong, nonatomic) NSDictionary *newsJSON;
@property (nonatomic, strong) NSMutableArray *newsArray;
@property (nonatomic, strong) NSMutableArray *urlArray;
@property (weak, nonatomic) id responseObject;

@property (strong, nonatomic) UISearchController *mySearchController;
@property (strong, nonatomic) NSArray *searchResult;
@property (strong, nonatomic) NSMutableArray *list;

@end

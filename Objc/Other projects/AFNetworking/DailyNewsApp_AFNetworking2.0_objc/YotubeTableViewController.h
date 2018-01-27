//
//  YotubeTableViewController.h
//  YoutubeApp_objc
//
//  Created by Kuan-Wei Lin on 10/5/15.
//  Copyright © 2015 Kuan-Wei Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YotubeTableViewController : UITableViewController
{
    int rows;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *showBtn;

@property (strong, nonatomic) NSDictionary *YoutubeJSON;
@property (strong, nonatomic) NSMutableArray *YoutubeArray;
@property (weak, nonatomic) id responseObject;

@end

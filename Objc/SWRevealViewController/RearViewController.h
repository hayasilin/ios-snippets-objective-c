//
//  RearViewController.h
//  Component
//
//  Created by Kuan-Wei Lin on 6/19/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RearViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *rearTableView;
@end

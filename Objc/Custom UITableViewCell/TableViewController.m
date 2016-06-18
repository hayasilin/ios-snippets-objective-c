//
//  TableViewController.m
//
//  Created by Kuan-Wei Lin on 3/5/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"

@interface TableViewController ()

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = @[@"First", @"Second", @"Three", @"Four", @"Five", @"Second", @"Three", @"Four", @"Five", @"Second", @"Three", @"Four", @"Five", @"Second", @"Three", @"Four", @"Five"];
    
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Defaule UITableViewCell syntax
    /*
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    // Configure the cell...
    cell.textLabel.text = self.dataArray[indexPath.row];
    */
    
    TableViewCell *cell = (TableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    }
    
    cell.label1.text = self.dataArray[indexPath.row];
    cell.label2.text = self.dataArray[indexPath.row];
    
    return cell;
}

@end

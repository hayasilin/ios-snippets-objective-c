//
//  LazyLoadingTableViewCell.m
//  Component
//
//  Created by Kuan-Wei Lin on 7/7/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "LazyLoadingTableViewCell.h"

@implementation LazyLoadingTableViewCell
@synthesize imageView;

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    NSLog(@"shop = %@", _shop);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

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

- (void)setShop:(Shop *)shop{
    //用Setter不能用self.不然會變成無限迴圈
    //等於Swift的didSet
    
    _shop = shop;
    
    //NSLog(@"self.shop = %@", _shop);
    self.nameLabel.text = _shop.name;
    if ([_shop.station isEqualToString:@""]) {
       self.stationLabel.hidden = YES;
    }else{
        self.stationLabel.text = _shop.station;
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

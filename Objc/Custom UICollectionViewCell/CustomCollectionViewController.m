//
//  CustomCollectionViewController.m
//
//  Created by Kuan-Wei Lin on 4/20/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "CustomCollectionViewController.h"
#import "CustomCollectionViewCell.h"

@interface MyCollectionViewController ()

@property (strong, nonatomic) CustomCollectionViewCell *collectionViewCell;

@end

@implementation MyCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register default cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    //Register Custom cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"CustomCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout = (UICollectionViewFlowLayout *)[self.collectionView collectionViewLayout];
    
    layout.itemSize = CGSizeMake(100, 150);
    
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    layout.sectionInset = UIEdgeInsetsMake(10, 20, 10, 20);

    layout.minimumLineSpacing = 20;
    
    layout.minimumInteritemSpacing = 0;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 40;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //Default cell
    //UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    CustomCollectionViewCell *cell = (CustomCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    cell.backgroundView = [[UIView alloc] init];
    cell.backgroundView.backgroundColor = [UIColor cyanColor];
    
    cell.selectedBackgroundView = [[UIView alloc] init];
    cell.selectedBackgroundView.backgroundColor = [UIColor orangeColor];
    
    return cell;
}

@end

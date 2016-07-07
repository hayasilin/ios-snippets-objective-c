//
//  ViewController.m
//  Component
//
//  Created by Kuan-Wei Lin on 6/18/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"

#define kCustomRowCount 7

static NSString *CellIdentifier = @"cell";
static NSString *PlaceholderCellIdentifier = @"PlaceholderCell";

static NSString * const gourmetHamburgerUrl = @"http://search.olp.yahooapis.jp/OpenLocalPlatform/V1/localSearch?appid=dj0zaiZpPUhhdVJPbm9hMnVUMSZzPWNvbnN1bWVyc2VjcmV0Jng9ZmE-&device=mobile&group=gid&sort=score&output=json&gc=01&query=%E3%83%8F%E3%83%B3%E3%83%90%E3%83%BC%E3%82%AC%E3%83%BC&results=20&sort=score&start=1";

@interface ViewController ()

@property (strong, nonatomic) APIDataManager *manager;

@property (strong, nonatomic) NSArray *groumetArray;

@property (strong, nonatomic) NSMutableArray *restaurantNameArray;
@property (strong, nonatomic) NSMutableArray *propertyArray;
@property (strong, nonatomic) NSMutableArray *restaurantAddressArray;

@property (strong, nonatomic) NSMutableArray *photoUrlArray;
@property (strong, nonatomic) NSMutableArray *stationArray;
@property (strong, nonatomic) NSMutableDictionary *stationDictionary;

// the set of IconDownloader objects for each app, lazy loading
@property (nonatomic, strong) AppRecord *appRecord;//儲存從Server存下來的資料
@property (nonatomic, strong) NSMutableArray *entries;//將AppRecord物件存進此Array之中
@property (nonatomic, strong) NSMutableDictionary *imageDownloadsInProgress;//還不確定它是幹啥用的

@end

@implementation ViewController

- (void)dealloc{
    // terminate all pending download connections
    [self terminateAllDownloads];
}

-(void)viewDidLoad{
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.manager = [APIDataManager defaultManager];
    self.manager.delegate = self;
    [self.manager getDataFromAPI:gourmetHamburgerUrl];
    
    _imageDownloadsInProgress = [NSMutableDictionary dictionary];
}

- (void)terminateAllDownloads{
    // terminate all pending download connections
    NSArray *allDownloads = [self.imageDownloadsInProgress allValues];
    [allDownloads makeObjectsPerformSelector:@selector(cancelDownload)];
    [self.imageDownloadsInProgress removeAllObjects];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // terminate all pending download connections
    [self terminateAllDownloads];
}

#pragma mark - APIDataManager
- (void)didCompleteGettingDataFromAPI:(NSArray *)gourmetArray{
    
    if (gourmetArray != nil) {
        
        self.shops = [NSMutableArray array];
        self.restaurantNameArray = [NSMutableArray array];
        self.stationArray = [NSMutableArray array];
        self.photoUrlArray = [NSMutableArray array];
        
        for (NSDictionary *dict in gourmetArray) {
            Shop *shop = [[Shop alloc] init];
            shop.gid = dict[@"Gid"];
            
            shop.name = dict[@"Name"];
            [self.restaurantNameArray addObject:dict[@"Name"]];
            
            shop.yomi = dict[@"Property"][@"Yomi"];
            shop.tel = dict[@"Property"][@"Tel1"];
            shop.address = dict[@"Property"][@"Address"];
            NSString *geometry = dict[@"Geometry"][@"Coordinates"];
            NSArray *components = [geometry componentsSeparatedByString:@","];
            shop.lat = [components[1] doubleValue];
            shop.lon = [components[0] doubleValue];
            shop.catchPlay = dict[@"Property"][@"CatchCopy"];
            
            shop.photoUrl = dict[@"Property"][@"LeadImage"];
            if (dict[@"Property"][@"LeadImage"] != nil) {
                [self.photoUrlArray addObject:dict[@"Property"][@"LeadImage"]];
            }else{
                [self.photoUrlArray addObject:@"No photo"];
            }
            
            
            if ([dict[@"Property"][@"CouponFlag"] isEqualToString:@"true"]) {
                shop.hasCoupon = YES;
            }
            
            NSArray *stations = dict[@"Property"][@"Station"];
            NSString *line = @"";
            if (stations[0][@"Railway"] != nil) {
                NSString *lineString = stations[0][@"Railway"];
                NSArray *lines = [lineString componentsSeparatedByString:@"/"];
                line = lines[0];
            }
            if (stations[0][@"Name"] != nil) {
                NSString *station = stations[0][@"Name"];
                shop.station = [NSString stringWithFormat:@"%@%@", line, station];
                [self.stationArray addObject:[NSString stringWithFormat:@"%@%@", line, station]];
                
            }else{
                shop.station = line;
                [self.stationArray addObject:@"No station"];
            }
            
            [self.shops addObject:shop];
        }
        
    }else{
        
    }
    [self.tableView reloadData];
    
    
    //建立一個獨立Object儲存圖片Url
    self.entries = [NSMutableArray array];
    
    for (int i = 0; i < self.restaurantNameArray.count; i++) {
        self.appRecord = [[AppRecord alloc] init];
        self.appRecord.imageURLString = self.photoUrlArray[i];
        [self.entries addObject:self.appRecord];
    }
    self.appRecord = nil;
    
    NSLog(@"nameArray = %@", self.restaurantNameArray);
    NSLog(@"photoArray = %@", self.photoUrlArray);

}

- (void)didFailGettingDataFromAPI:(NSError *)error{
    NSLog(@"error = %@", error);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"哎呀" message:@"似乎網路連線發生問題，想重新連線嗎？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.manager getDataFromAPI:gourmetHamburgerUrl];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
    
    [alertController addAction:alertAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return self.restaurantNameArray.count;
    NSUInteger count = self.restaurantNameArray.count;
    NSLog(@"count = %li", count);
    
    // if there's no data yet, return enough rows to fill the screen
    if (count == 0)
    {
        return kCustomRowCount;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger nodeCount = self.restaurantNameArray.count;
    
    LazyLoadingTableViewCell *cell = (LazyLoadingTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
//    if (!cell) {
//        [tableView registerNib:[UINib nibWithNibName:@"JPGRecommendTableViewCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
//        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    }
    
    // Leave cells empty if there's no data yet
    if (nodeCount > 0){
        // Set up the cell representing the app
        AppRecord *appRecord = (self.entries)[indexPath.row];
        
        cell.nameLabel.text = self.restaurantNameArray[indexPath.row];
        cell.stationLabel.text = self.stationArray[indexPath.row];
        cell.shop = self.shops[indexPath.row];
        
        // Only load cached images; defer new downloads until scrolling ends
        if (!appRecord.appIcon){
            if (self.tableView.dragging == NO && self.tableView.decelerating == NO){
                [self startIconDownload:appRecord forIndexPath:indexPath];
            }
            // if a download is deferred or in progress, return a placeholder image
            cell.imageView.image = [UIImage imageNamed:@"no-photo.jpg"];
        }else{
            cell.imageView.image = appRecord.appIcon;
        }
    }
    
    return cell;
}

#pragma mark - Table cell image support

- (void)startIconDownload:(AppRecord *)appRecord forIndexPath:(NSIndexPath *)indexPath{
    
    IconDownloader *iconDownloader = (self.imageDownloadsInProgress)[indexPath];
    if (iconDownloader == nil)
    {
        iconDownloader = [[IconDownloader alloc] init];
        iconDownloader.appRecord = appRecord;
        [iconDownloader setCompletionHandler:^{
            
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            
            // Display the newly loaded image
            cell.imageView.image = appRecord.appIcon;
            
            // Remove the IconDownloader from the in progress list.
            // This will result in it being deallocated.
            [self.imageDownloadsInProgress removeObjectForKey:indexPath];
            
        }];
        (self.imageDownloadsInProgress)[indexPath] = iconDownloader;
        [iconDownloader startDownload];
    }
}

// -------------------------------------------------------------------------------
//	loadImagesForOnscreenRows
//  This method is used in case the user scrolled into a set of cells that don't
//  have their app icons yet.
// -------------------------------------------------------------------------------
- (void)loadImagesForOnscreenRows{
    if (self.entries.count > 0){
        NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths)
        {
            AppRecord *appRecord = (self.entries)[indexPath.row];
            
            if (!appRecord.appIcon)
                // Avoid the app icon download if the app already has an icon
            {
                [self startIconDownload:appRecord forIndexPath:indexPath];
            }
        }
    }
}

#pragma mark - UIScrollViewDelegate
// -------------------------------------------------------------------------------
//	scrollViewDidEndDragging:willDecelerate:
//  Load images for all onscreen rows when scrolling is finished.
// -------------------------------------------------------------------------------
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        [self loadImagesForOnscreenRows];
    }
}

// -------------------------------------------------------------------------------
//	scrollViewDidEndDecelerating:scrollView
//  When scrolling stops, proceed to load the app icons that are on screen.
// -------------------------------------------------------------------------------
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnscreenRows];
}




@end

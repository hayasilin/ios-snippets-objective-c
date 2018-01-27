//
//  ViewController.h
//  MyLocationDemo
//
//  Created by Kuan-Wei Lin on 10/4/15.
//  Copyright © 2015 Kuan-Wei Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *latituteLabel;

@property (weak, nonatomic) IBOutlet UILabel *longtituteLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;


- (IBAction)getCurrentLocation:(id)sender;

@end


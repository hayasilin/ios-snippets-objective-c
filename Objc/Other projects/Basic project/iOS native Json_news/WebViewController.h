//
//  WebViewController.h
//  iOS native Json
//
//  Created by Kuan-Wei Lin on 4/16/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) NSString *urlString;

@end

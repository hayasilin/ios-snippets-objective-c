//
//  WebViewController.h
//  YoutubeApp_objc
//
//  Created by Kuan-Wei Lin on 10/6/15.
//  Copyright © 2015 Kuan-Wei Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) NSString *newsUrl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@end

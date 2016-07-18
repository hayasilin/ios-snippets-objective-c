//
//  ViewController.h
//  Components2
//
//  Created by Kuan-Wei Lin on 7/11/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (void)blockCallbackDemo:(NSString *)str complete:(void(^)(NSArray *arr, NSDictionary *dict))completeHandler;

@end


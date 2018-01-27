//
//  ViewController.h
//  UnitTesting
//
//  Created by Kuan-Wei Lin on 12/11/16.
//  Copyright © 2016 cracktheterm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) NSArray *gourmetArray;

- (void)getDataFromAPI:(NSString *)urlString;

- (int)divideTwo:(int)num1 num2:(int)num2;

- (void)blockCallbackDemo:(NSString *)str complete:(void(^)(NSArray *arr))completeHandler;


@end


//
//  DetailViewController.h
//  Block
//
//  Created by kuanwei on 2020/7/28.
//  Copyright © 2020 kuanwei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

@property (nonatomic, strong) NSArray *data;
- (void)blockCallbackDemo:(NSString *)str complete:(void(^)(NSArray *arr, NSDictionary *dict))completeHandler;

@end

NS_ASSUME_NONNULL_END

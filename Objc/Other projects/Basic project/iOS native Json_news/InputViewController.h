//
//  InputViewController.h
//  iOS native Json
//
//  Created by Kuan-Wei Lin on 3/6/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputViewController : UIViewController <NSURLConnectionDataDelegate>
{
    NSMutableData *datas;
}

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) UILabel *titleLabel;
@property (weak, nonatomic) UILabel *publisherLabel;

@property (nonatomic, strong) NSString *newsUrl;
@property (nonatomic, strong) NSString *taipeiUrl;
@property (nonatomic, strong) NSArray *newsArray;
@property (weak, nonatomic) id responseObject;

- (IBAction)buttonClicked:(id)sender;

@end

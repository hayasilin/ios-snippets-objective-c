//
//  TwoViewController.h
//  pickerView
//
//  Created by Kuan-Wei Lin on 6/7/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TwoViewControllerDelegate <NSObject>

- (void)sendDataBack:(NSString *)dataString;

@end

@interface TwoViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) id <TwoViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (strong, nonatomic) NSString *text;

- (IBAction)action:(id)sender;

@end

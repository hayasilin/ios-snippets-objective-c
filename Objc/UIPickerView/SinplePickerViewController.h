//
//  ViewController.h
//  pickerView
//
//  Created by Kuan-Wei Lin on 6/7/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimplePickerViewController : UIViewController <UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end


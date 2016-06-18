//
//  ViewController.h
//  pickerView
//
//  Created by Kuan-Wei Lin on 6/7/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwoViewController.h"

@interface FirstViewController : UIViewController <TwoViewControllerDelegate, UIPickerViewDelegate, UITextFieldDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@end


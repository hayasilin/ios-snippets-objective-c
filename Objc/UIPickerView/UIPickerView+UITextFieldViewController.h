//
//  ViewController.h
//  pickerView
//
//  Created by Kuan-Wei on 2016/6/8.
//  Copyright © 2016年 Kuan-Wei Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPickerViewDelegate, UITextFieldDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *testField;

@end

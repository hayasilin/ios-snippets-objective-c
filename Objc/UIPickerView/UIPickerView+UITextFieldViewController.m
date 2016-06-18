//
//  ViewController.m
//  pickerView
//
//  Created by Kuan-Wei on 2016/6/8.
//  Copyright © 2016年 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSArray *pickerArray;

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    UIToolbar *toolBar = [[UIToolbar alloc] init];
    
    UIBarButtonItem *aboutButton = [[UIBarButtonItem alloc] initWithTitle:@"請選擇您希望的選項" style:UIBarButtonItemStyleDone target:self action:@selector(doSomething)];
    
    //讓aboutButton置中
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:flexibleSpace, aboutButton, flexibleSpace, nil]];
    
    self.pickerArray = [NSArray arrayWithObjects:@"Animal",@"Plant",@"Stone",@"Sky", nil];
    self.testField.inputView = pickerView;
    self.testField.inputAccessoryView = toolBar;
    self.testField.delegate = self;
    pickerView.delegate = self;
    pickerView.dataSource = self;
}
                      
- (void)doSomething{
    NSLog(@"yes!");

}

#pragma make - Dismiss keyboard
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.pickerArray count];
}
- (NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.pickerArray objectAtIndex:row];
}

#pragma mark - UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.testField.text = [self.pickerArray objectAtIndex:row];
}

#pragma UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField.text isEqualToString:@""]) {
        textField.text = [self.pickerArray objectAtIndex:0];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}

@end

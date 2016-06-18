//
//  ViewController.m
//  pickerView
//
//  Created by Kuan-Wei Lin on 6/7/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"

@interface SimplePickerViewController ()

@property (strong, nonatomic) NSArray *pickerArray;

@end

@implementation SimplePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pickerArray = [NSArray arrayWithObjects:@"First",@"Second",@"Third",@"Four", @"Five", @"six", @"Seven", @"Eight", @"Nine", @"ten", nil];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
}

#pragma mark - UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.pickerArray count];
}
- (NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.pickerArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.textField.text = [self.pickerArray objectAtIndex:row];
}

@end

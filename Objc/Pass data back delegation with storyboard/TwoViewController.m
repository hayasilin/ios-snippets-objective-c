//
//  TwoViewController.m
//  pickerView
//
//  Created by Kuan-Wei Lin on 6/7/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "TwoViewController.h"

@interface TwoViewController ()

@property (strong, nonatomic) NSArray *pickerArray;


@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.label.text = self.text;
    
    self.pickerArray = [NSArray arrayWithObjects:@"First",@"Second",@"Third",@"Four", @"Five", nil];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
}

#pragma mark - UIPickerViewDatasource
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
    self.text = [self.pickerArray objectAtIndex:row];
    self.label.text = [self.pickerArray objectAtIndex:row];
}

#pragma mark - IBAction
- (IBAction)action:(id)sender {
    if ([self.delegate respondsToSelector:@selector(sendDataBack:)]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate sendDataBack:self.text];
        });
    }
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
@end

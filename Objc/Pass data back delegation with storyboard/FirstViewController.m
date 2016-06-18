//
//  ViewController.m
//  pickerView
//
//  Created by Kuan-Wei Lin on 6/7/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"
#import "TwoViewController.h"

@interface FirstViewController ()

@property (strong, nonatomic) NSArray *pickerArray;
@property (strong, nonatomic) TwoViewController *viewController2;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pickerArray = [NSArray arrayWithObjects:@"First",@"Second",@"Third",@"Four", @"Five", nil];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
    self.textField.delegate = self;
    self.textField.text = @"X2fq241u92o34u";
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"goNext"]) {
        TwoViewController *twoVC = (TwoViewController *)segue.destinationViewController;
        twoVC.delegate = self;
        twoVC.text = self.textField.text;
    }
}

#pragma mark - TwoViewControllerDelegate
- (void)sendDataBack:(NSString *)dataString{
    self.textField.text = dataString;
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
    self.textField.text = [self.pickerArray objectAtIndex:row];
}

#pragma mark - IBAction
- (IBAction)goNextAction:(id)sender {
    [self performSegueWithIdentifier:@"goNext" sender:nil];
    
}

@end

//
//  ViewController.m
//  Component
//
//  Created by Kuan-Wei Lin on 6/18/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSArray *pickerArray;
@property (strong, nonatomic) NSArray *segmentedControlArray;
@property (strong, nonatomic) UITextField *inputTextField;
@property (nonatomic) BOOL isFlag;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    [self segmentedControlSetting];
    
    self.pickerViewInputTextField.delegate = self;
    
    [self createSlotIDInputPickerView];
    
    UIButton *requestButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    requestButton.frame = CGRectMake(CGRectGetMidX(self.view.bounds) - 50, 250, 100, 40);
    requestButton.backgroundColor = [UIColor blueColor];
    requestButton.layer.cornerRadius = 5.0;
    [requestButton setTitle:@"Request" forState:UIControlStateNormal];
    [requestButton setTintColor:[UIColor whiteColor]];
    [requestButton addTarget:self action:@selector(requestButtonPressedCheck) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:requestButton];
}

- (void)segmentedControlSetting{
    //建立陣列並設定其內容來當作選項
//    self.segmentedControlArray =[NSArray arrayWithObjects:@"Choose slot ID", @"Input slot ID", nil];
    //使用陣列來建立UISegmentedControl
//    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:self.segmentedControlArray];
    //設定外觀大小與初始選項
//    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
//    segmentedControl.frame = CGRectMake(20.0, 300.0, 280.0, 44.0);
//    segmentedControl.selectedSegmentIndex = 0;
    //設定所觸發的事件條件與對應事件
//    [segmentedControl addTarget:self action:@selector(segmentedControlChooseOne:) forControlEvents:UIControlEventValueChanged];
    
    //加入畫面中
//    [self.view addSubview:segmentedControl];

    
    [self.segmentedControl setTitle:@"Choose slot ID" forSegmentAtIndex:0];
    [self.segmentedControl setTitle:@"Input slot ID" forSegmentAtIndex:1];
}

//- (void)segmentedControlChooseOne:(id)sender {
//    NSLog(@"%@", [sender titleForSegmentAtIndex:[sender selectedSegmentIndex]]);
//}


- (void)createSlotIDInputPickerView{
    //PickerView
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    UIToolbar *toolBar = [[UIToolbar alloc] init];
    
    UIBarButtonItem *aboutButton = [[UIBarButtonItem alloc] initWithTitle:@"請選擇您希望的選項" style:UIBarButtonItemStyleDone target:self action:nil];
    
    //讓aboutButton置中
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:flexibleSpace, aboutButton, flexibleSpace, nil]];
    
    self.pickerArray = [NSArray arrayWithObjects:@"Animal",@"Plant",@"Stone",@"Sky", nil];
    self.pickerViewInputTextField.inputView = pickerView;
    self.pickerViewInputTextField.inputAccessoryView = toolBar;
    self.pickerViewInputTextField.delegate = self;
    pickerView.delegate = self;
    pickerView.dataSource = self;
    
    self.pickerViewInputTextField.text = self.pickerArray[0];
}

- (void)createInputTextField{
    CGRect pickerViewInputTextFieldRect = self.pickerViewInputTextField.frame;
    self.inputTextField = [[UITextField alloc] initWithFrame:pickerViewInputTextFieldRect];
    self.inputTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.inputTextField.placeholder = @"Please input your custom request";
    self.inputTextField.returnKeyType = UIReturnKeyDone;
    self.inputTextField.font = [UIFont systemFontOfSize:15];
    self.inputTextField.delegate = self;
    [self.view addSubview:self.inputTextField];
}

- (void)requestButtonPressedCheck{
    [self.view endEditing:YES];
    
    if (!self.inputTextField.hidden) {
        if (self.inputTextField.text == nil || [self.inputTextField.text isEqualToString:@""]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:@"The textfield can not be blank" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:alertAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }else{
            NSLog(@"Request successfully");
        }
    }else{
         NSLog(@"Request successfully");
    }
}

#pragma mark - UISegmentedControl
- (IBAction)segmentedControlSwitchAction:(UISegmentedControl *)sender {
    switch ([sender selectedSegmentIndex]) {
        case 0:
            [self.view endEditing:YES];
            self.isFlag = NO;
            self.pickerViewInputTextField.hidden = NO;
            if (self.inputTextField != nil) {
                self.inputTextField.hidden = YES;
            }
            break;
        case 1:
            [self.view endEditing:YES];
            self.isFlag = YES;
            self.pickerViewInputTextField.hidden = YES;
            if (self.inputTextField == nil) {
                [self createInputTextField];
            }else{
                self.inputTextField.hidden = NO;
            }
        default:
            break;
    }
}

#pragma makr - Dismiss keyboard
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
    self.pickerViewInputTextField.text = [self.pickerArray objectAtIndex:row];
}

#pragma UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([self.pickerViewInputTextField.text isEqualToString:@""]) {
        self.pickerViewInputTextField.text = [self.pickerArray objectAtIndex:0];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self requestButtonPressedCheck];
    return [self.inputTextField resignFirstResponder];
}



@end

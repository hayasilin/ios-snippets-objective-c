//
//  ViewController.h
//  calculator_objc
//
//  Created by Kuan-Wei Lin on 2/20/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Calculation.h"

@interface ViewController : UIViewController
{
    IBOutlet UILabel *display_label;
    Calculation *cal;
    bool isFirstDigit;
    bool hasTapEqual;
    float operand;
    float result;
    int digitCount;
    NSInteger digit;
}
@property (retain, nonatomic) IBOutlet UILabel *display_label;
- (void) processCalc: (char)op;
- (void) displayProcess: (float)num;
//按鈕事件處理
- (IBAction)tapDigit:(id)sender;
- (IBAction)tapPlus:(id)sender;
- (IBAction)tapMinus:(id)sender;
- (IBAction)tapMultiply:(id)sender;
- (IBAction)tapDivide:(id)sender;
- (IBAction)tapAC:(id)sender;
- (IBAction)tapEqual:(id)sender;

//Practice UITest
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
- (IBAction)pressAction:(id)sender;


@end


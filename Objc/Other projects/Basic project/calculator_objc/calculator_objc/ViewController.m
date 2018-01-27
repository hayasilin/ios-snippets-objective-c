//
//  ViewController.m
//  calculator_objc
//
//  Created by Kuan-Wei Lin on 2/20/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize  display_label, nameLabel;

- (void)viewDidLoad {
    
    cal = [[Calculation alloc] init];
    cal.isFirstOperand = 1;
    isFirstDigit = 1;
    hasTapEqual = 0;
    [display_label setText:@"0"];
    [super viewDidLoad];
}

- (IBAction)tapDigit:(id)sender{
    digit = [sender tag];
    if (isFirstDigit && digit == 0) {
        isFirstDigit = 1;
    }//避免第一個位數，使用者輸入0造成數字以0開頭的情況
    else{
        if (digitCount >= 9) {
            return; //do nothing
        }//將輸入位數控制在9個以內
        isFirstDigit = 0;
        operand = operand*10+digit;
        [self displayProcess:operand];
    }
    digitCount++;
}

- (void) processCalc: (char)op{
    if (cal.isFirstOperand) {
        cal.operandA = operand;
        cal.isFirstOperand = 0;
    }else if (hasTapEqual){
        cal.operandA = result;
        cal.operandB = operand;
        hasTapEqual = 0;
    }else{
        cal.operandB = operand;
        result = [cal calcResult];
        [self displayProcess:result];
        cal.operandA = result;
    }
    cal.op = op;
    operand = 0;
    digitCount = 0;
}

- (IBAction)tapPlus:(id)sender{
    [self processCalc:'+'];
}
- (IBAction)tapMinus:(id)sender{
    [self processCalc:'-'];
}
- (IBAction)tapMultiply:(id)sender{
    [self processCalc:'*'];
}
- (IBAction)tapDivide:(id)sender{
    [self processCalc:'/'];
}

- (IBAction)tapEqual:(id)sender{
    if (!cal.isFirstOperand) {
        cal.operandB = operand;
        result = [cal calcResult];
        [self displayProcess:result];
        cal.operandA = result;
        hasTapEqual = 1;
    }
}

- (IBAction)tapAC:(id)sender{
    [display_label setText:@"0"];
    cal.operandA = 0;
    cal.operandB = 0;
    cal.isFirstOperand = 1;
    result = 0;
    operand = 0;
    isFirstDigit = 1;
    hasTapEqual = 0;
}

- (void) displayProcess: (float)num{
    NSMutableString *str = [NSMutableString stringWithFormat:@"%.f", num];
    NSInteger zeroLength = [str length] - 1;
    NSInteger zeroIndex = zeroLength;
    BOOL zeroBreak = TRUE;
    while (zeroBreak) {
        if ([str characterAtIndex:zeroIndex] != '0') {
            zeroBreak = FALSE;
        }else{
            zeroIndex--;
        }
    }
    [str deleteCharactersInRange:NSMakeRange(zeroIndex + 1, zeroLength - zeroIndex)];
    [display_label setText:str];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressAction:(id)sender {
    [nameLabel setText:@"Button pressed"];
}
@end

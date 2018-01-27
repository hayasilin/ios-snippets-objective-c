//
//  Calculation.m
//  calculator_objc
//
//  Created by Kuan-Wei Lin on 2/20/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "Calculation.h"

@implementation Calculation
@synthesize operandA, operandB, op, isFirstOperand;

- (float) calcResult{
    switch (op) {
        case '+':{
            result = operandA + operandB;
            break;
        }
        case '-':{
            result = operandA - operandB;
            break;
        }
        case '*':{
            result = operandA * operandB;
            break;
        }
        case '/':{
            result = operandA / operandB;
            break;
        }
    }
    return result;
}


@end

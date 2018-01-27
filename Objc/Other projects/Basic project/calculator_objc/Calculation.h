//
//  Calculation.h
//  calculator_objc
//
//  Created by Kuan-Wei Lin on 2/20/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculation : NSObject
{
    float operandA;
    float operandB;
    float result;
    char op;
    bool isFirstOperand;
}

@property float operandA;
@property float operandB;
@property char op;
@property bool isFirstOperand;

- (float) calcResult;

@end

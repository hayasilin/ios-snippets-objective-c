//
//  ViewController.m
//  Components2
//
//  Created by Kuan-Wei Lin on 7/11/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int i = 53;
    void(^someCode)() = ^{
        NSLog(@"The value of i is %i", i);
    };
    
    someCode();
    
    ///////////////
    NSArray *someArray = @[@"apple", @"Apple", @"Orange"];
    
    NSPredicate *filterPredicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nonnull evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        NSString *theString = evaluatedObject;
        return [theString hasPrefix:@"Apple"];
    }];
    
    NSArray *filteredArray = [someArray filteredArrayUsingPredicate:filterPredicate];
    NSLog(@"filteredArray = %@", filteredArray);
    ///////////////
    
    BOOL hasValue = YES;
    
    void(^myBlockVariable)(BOOL isOpen);
    
    myBlockVariable = ^(BOOL isOpen){
        NSLog(@"isOpen = %d", isOpen);
    };
    
    myBlockVariable(hasValue);
    
    //省略寫法
    void(^myBlock)() = ^{
        NSLog(@"str");
    };
    myBlock();
    
    
    //Block與記憶體管理，因block中，物件被retain，但對非物件來說，變數資料在一開始建立block之時就已經被複製到block裡面了，所以需要用__block來避免改值時發生問題
    __block int j = 0;
    void(^myBlockManager)() = ^{
        j = 4;
    };
    
    myBlockManager();
    NSLog(@"myBlockManager = %i", j);
}

- (void)blockCallbackDemo:(NSString *)str complete:(void(^)(NSArray *arr, NSDictionary *dict))completeHandler{
    
    NSArray *arrDemo = @[@"1", @"2", @"3"];
    NSDictionary *dictDemo = @{
                               @"1":@"one",
                               @"2":@"two",
                               @"3":@"three"};
    
    completeHandler(arrDemo, dictDemo);
}



@end

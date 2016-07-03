//
//  ViewController.m
//  Component
//
//  Created by Kuan-Wei Lin on 6/18/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)AddNSUserDefaults{
    
    NSArray *nameArray = @[@"david", @"ellen", @"peter", @"tom", @"jerry"];
    
    NSUserDefaults *userDefults = [NSUserDefaults standardUserDefaults];
    
    int count = 1;
    
    for (int i = 0; i < nameArray.count; i++) {
        NSString *str = [NSString stringWithFormat:@"name%i", count];
        //儲存資料到NSUserDefaults
        [userDefults setObject:nameArray[i] forKey:str];
        
        NSLog(@"%@", [userDefults objectForKey:str]);
        count++;
    }
    
    [userDefults synchronize];
}

- (void)displayNSUserDefaults{
    //Display content for key
    NSUserDefaults *userDefults = [NSUserDefaults standardUserDefaults];
    [userDefults objectForKey:@"Input key"];
    
    //Display all contents of NSUserDefaults
     NSLog(@"All contents of NSUserDefaults: %@", [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]);
}

- (void)removeNSUserDefaults{
    //Remove content for key
    NSUserDefaults *userDefults = [NSUserDefaults standardUserDefaults];
    [userDefults removeObjectForKey:@"Inpu key"];
    
    [userDefults synchronize];
}

@end

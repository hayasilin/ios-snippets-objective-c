//
//  ViewController.m
//  table
//
//  Created by Kuan-Wei Lin on 7/7/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"
#import "Social/Social.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)dealloc{
    NSLog(@"vc dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)phoneTapped:(UIButton *)sender {
    NSString *name = @"Someone's name";
    NSString *tel = @"0917553948";
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", tel]];
    
    if (url == nil) {
        return;
    }
    
    if (![[UIApplication sharedApplication] canOpenURL:url]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warning" message:@"This device don't have phone call function" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:alertAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return;
    }
    
     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:name message:[NSString stringWithFormat:@"打電話給 %@ 嗎", name] preferredStyle:UIAlertControllerStyleAlert];
    
     UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"打電話" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
         
     [[UIApplication sharedApplication] openURL:url];
         
     return;
     }];
    
     UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
     [alertController addAction:cancelAction];
     [alertController addAction:alertAction];
     [self presentViewController:alertController animated:YES completion:nil];
}

@end

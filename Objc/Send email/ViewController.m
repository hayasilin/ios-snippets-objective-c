//
//  ViewController.m
//  table
//
//  Created by Kuan-Wei Lin on 7/7/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)dealloc{
    NSLog(@"vc dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, 100, 100);
    button.center = self.view.center;
    button.backgroundColor = [UIColor cyanColor];
    [button setTitle:@"Press me" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(sendEmail) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}

- (void)sendEmail{
    // Email Subject
    NSString *emailTitle = @"請給我們支持與指教";
    // Email Content
    NSString *messageBody = @"請寫下您的意見...";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"kuanwei.hayasi@gmail.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:YES];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}


@end

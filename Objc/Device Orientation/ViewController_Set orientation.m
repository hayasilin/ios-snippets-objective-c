//
//  ViewController.m
//  Components
//
//  Created by Kuan-Wei Lin on 7/11/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"

#define ORIENTATION_LANDSCAPE_RIGHT @"UIInterfaceOrientationLandscapeRight"
#define ORIENTATION_LANDSCAPE_LEFT @"UIInterfaceOrientationLandscapeLeft"
#define ORIENTATION_PORTRAIT @"UIInterfaceOrientationPortrait"

@interface ViewController ()

@property (strong, nonatomic)NSArray *appSupportInterfaceOrientationsArray;
@property (nonatomic) BOOL isRotate;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    //存入iPhone的各種轉向選擇
    self.appSupportInterfaceOrientationsArray = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"UISupportedInterfaceOrientations"];
    NSLog(@"arrayAppSupportInterfaceOrientations = %@", self.appSupportInterfaceOrientationsArray);
    
    //監聽iPhone的轉向
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewDidRotate:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

#pragma mark - Device rotate
- (void) viewDidRotate:(NSNotification *)notification {
    NSLog(@"viewDidRotate");
    
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    if (orientation == UIDeviceOrientationLandscapeLeft)
    {
        NSLog(@"Landscape Left!");
    }
    if (orientation == UIDeviceOrientationLandscapeRight)
    {
        NSLog(@"Landscape Right!");
    }
    if (orientation == UIDeviceOrientationPortrait)
    {
        NSLog(@"Portrait Up!");
    }
}

- (IBAction)rotate:(UIButton *)sender {
    // strDirection 1: portrait, 0: landscape
    NSString *strDirection;
    
    //Simulate that value is given by server side
    if (self.isRotate) {
        strDirection = @"1";
        self.isRotate = NO;
    }else{
        strDirection = @"0";
        self.isRotate = YES;
    }
    NSLog(@"strDirection = %@", strDirection);
    
    int nDeviceOrientation = -1;
    
    if ( [strDirection intValue] == 0 ) {
        if ( [self.appSupportInterfaceOrientationsArray containsObject:ORIENTATION_LANDSCAPE_RIGHT] ) {
            nDeviceOrientation = UIDeviceOrientationLandscapeRight;
        }
        else if ( [self.appSupportInterfaceOrientationsArray containsObject:ORIENTATION_LANDSCAPE_LEFT] ) {
            nDeviceOrientation = UIDeviceOrientationLandscapeLeft;
        }
    } else if ( [strDirection intValue] == 1 ) {
        if ( [self.appSupportInterfaceOrientationsArray containsObject:ORIENTATION_PORTRAIT] ) {
            nDeviceOrientation = UIDeviceOrientationPortrait;
        }
    }
    
    NSLog(@"nDeviceOrientation = %i", nDeviceOrientation);
    if ( nDeviceOrientation >= 0 ) {
        if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
            
            //MARK: - One way to rotate the iPhone device
//            NSLog(@"Using NSInvocation to transform to UIDevice Orientation %d", nDeviceOrientation);
//            SEL selector = NSSelectorFromString(@"setOrientation:");
//            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
//            [invocation setSelector:selector];
//            [invocation setTarget:[UIDevice currentDevice]];
//            [invocation setArgument:&nDeviceOrientation atIndex:2];
//            [invocation invoke];
            
            //MARK: - Another way to rotate the iPhone device
            NSNumber *value = [NSNumber numberWithInt:nDeviceOrientation];
            [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
            
        } else {
            NSLog(@"UIDevice setOrientation does not exist!!");
        }
    }
}

- (IBAction)rotateLandscapeRight:(UIButton *)sender {
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger: UIInterfaceOrientationLandscapeRight] forKey:@"orientation"];
}

- (IBAction)rotateLandscapeLeft:(UIButton *)sender {
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger: UIInterfaceOrientationLandscapeLeft] forKey:@"orientation"];
}

- (IBAction)rotatePortrait:(UIButton *)sender {
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger: UIInterfaceOrientationPortrait] forKey:@"orientation"];
}

@end

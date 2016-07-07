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

-(void)viewDidLoad{
    //單指點擊
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapThreeTimesByOneFinger)];
    
    //設定行為
    [recognizer setNumberOfTouchesRequired:1];
    [recognizer setNumberOfTapsRequired:3];
    
    //加入欲互動區的 UIView 中
    [self.view addGestureRecognizer:recognizer];
    
    //滑動手勢
    UISwipeGestureRecognizer * swipeleft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeleft:)];
    swipeleft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeleft];
    
    UISwipeGestureRecognizer * swiperight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swiperight:)];
    swiperight.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swiperight];
    
    //長按手勢
    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
    longPressGr.minimumPressDuration = 1.0;
    [self.view addGestureRecognizer:longPressGr];
}

- (void)tapThreeTimesByOneFinger{
    NSLog(@"tapThreeTimesByOneFinger");
}

-(void)swipeleft:(UISwipeGestureRecognizer*)gestureRecognizer{
    [self performSegueWithIdentifier:@"goRight" sender:nil];
}

-(void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer{
    [self performSegueWithIdentifier:@"goLeft" sender:nil];
}

-(void)longPressToDo:(UILongPressGestureRecognizer *)gesture{
    
//    if(gesture.state == UIGestureRecognizerStateBegan){
//        CGPoint point = [gesture locationInView:self.view];
//        NSLog(@"point x = %f, y = %f", point.x, point.y);
//    }
    
    for (int i = 0; i < gesture.numberOfTouchesRequired; i++) {
        CGPoint point = [gesture locationOfTouch:i inView:self.view];
        NSLog(@"第%d根的手指的位置在%@", (i + 1), NSStringFromCGPoint(point));
    }
}



@end

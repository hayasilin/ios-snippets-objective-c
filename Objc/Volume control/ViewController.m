//
//  ViewController.m
//  Components2
//
//  Created by Kuan-Wei Lin on 7/11/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"

#import "MediaPlayer/MediaPlayer.h"

@interface ViewController ()

@property (nonatomic) float volumeFloat;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setSystemVolume:(float)volume{
    
    MPVolumeView *volumeView = [[MPVolumeView alloc] init];
    for (UIView *view in volumeView.subviews) {
        if ([NSStringFromClass(view.classForCoder) isEqualToString:@"MPVolumeSlider"]) {
            UISlider *slider = (UISlider *)view;
            [slider setValue:volume animated:YES];
        }
    }
}

- (IBAction)volumeUp:(UIButton *)sender {
    if (self.volumeFloat < 1) {
        self.volumeFloat += 0.0625;
        [self setSystemVolume:self.volumeFloat];
    }else{
        self.volumeFloat = 1;
        [self setSystemVolume:self.volumeFloat];
    }
}

- (IBAction)volumeDown:(UIButton *)sender {
    if (self.volumeFloat == 0) {
        self.volumeFloat = 0;
    }else{
        self.volumeFloat -= 0.0625;
        [self setSystemVolume:self.volumeFloat];
    }
}

- (IBAction)minVolume:(UIButton *)sender {
    self.volumeFloat = 0.0625;
    [self setSystemVolume:self.volumeFloat];
}

- (IBAction)maxVolume:(UIButton *)sender {
    self.volumeFloat = 1;
    [self setSystemVolume:self.volumeFloat];
}

- (IBAction)mute:(UIButton *)sender {
    self.volumeFloat = 0;
    [self setSystemVolume:self.volumeFloat];
}



@end

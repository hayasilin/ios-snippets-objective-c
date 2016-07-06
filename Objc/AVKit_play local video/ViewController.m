//
//  ViewController.m
//  Component
//
//  Created by Kuan-Wei Lin on 6/18/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

@import AVKit;

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()

@property (strong, nonatomic) AVPlayerViewController *playViewController;
@property (strong, nonatomic) AVPlayer *playerView;

@property (nonatomic, strong) AVPlayerLayer *playerLayer;

//MPMoviePlayerController is deprecated
//@property (nonatomic, strong) MPMoviePlayerController *mediaPlayer;

@end

@implementation ViewController

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    //Normal AVPlayerViewController
    NSString *path = [[NSBundle mainBundle]pathForResource:@"emoji zone" ofType:@"mp4"];
    NSLog(@"path = %@", path);
    self.playerView = [[AVPlayer alloc]initWithURL:[NSURL fileURLWithPath:path]];
    self.playViewController = [[AVPlayerViewController alloc] init];
    self.playViewController.player = self.playerView;

    [self loopPlayerLayer];
}

- (void)loopPlayerLayer{
    //AVPlayerLayer
    UIView *controllerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 2)];
    controllerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:controllerView];
    
    [self.view.layer insertSublayer:self.playerLayer below:controllerView.layer];
    
    // loop movie
    self.playerLayer.player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(replayMovie:)
                                                 name: AVPlayerItemDidPlayToEndTimeNotification
                                               object:nil];
}

- (AVPlayerLayer*)playerLayer{
    if(!_playerLayer){
        // find movie file
        NSURL *moviePath = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource: @"emoji zone" ofType:@"mp4"]];
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:[[AVPlayer alloc]initWithURL:moviePath]];
        //_playerLayer.frame = CGRectMake(0,0,self.view.frame.size.width, self.view.frame.size.height);
        _playerLayer.frame = CGRectMake(0, 70, self.view.frame.size.width, 200);
        [_playerLayer.player play];
        
    }
    return _playerLayer;
}

-(void)replayMovie:(NSNotification *)notification{
    AVPlayerItem *repeatPlayer = [notification object];
    [repeatPlayer seekToTime:kCMTimeZero];
}

- (IBAction)playVideoAction:(id)sender {
    NSLog(@"play clicked");
        [self presentViewController:self.playViewController animated:YES completion:^{
        [self.playViewController.player play];
    }];
}

//- (IBAction)startMediaPlayerAction:(id)sender {
//    //MPMoviePlayerController is deprecated;
//    self.mediaPlayer = [[MPMoviePlayerController alloc] initWithContentURL:sourceMovieURL];
//    self.mediaPlayer.view.frame = CGRectMake(0, 0, 1024, 768);
//    self.mediaPlayer.controlStyle = MPMovieControlStyleNone;
//    
//    // Play the movie!
//    [self.view addSubview:self.mediaPlayer.view];
//}


- (IBAction)startAVPlayerAction:(id)sender {
    //Below is not working
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"emoji zone" ofType:@"mp4"];
    NSURL *sourceMovieURL = [NSURL fileURLWithPath:filePath];
    
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.frame = self.view.layer.bounds;
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    [self.view.layer addSublayer:playerLayer];
    [player play];
}





@end

//
//  ViewController.m
//  Component
//
//  Created by Kuan-Wei Lin on 8/5/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@import AVKit;

@interface ViewController ()

@property (strong, nonatomic) AVPlayerViewController *playViewController;
@property (strong, nonatomic) AVPlayer *playerView;

@property (nonatomic, strong) AVPlayerLayer *playerLayer;

@property (nonatomic, strong) UIButton *videoControlButton;
@property (nonatomic) BOOL isPause;

//MPMoviePlayerController is deprecated in iOS 7
//@property (nonatomic, strong) MPMoviePlayerController *mediaPlayer;

@end

@implementation ViewController

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
   
    [self createAVPlayerViewControllerAndAVPlayer];
    
    //[self narrowPlayerStart];
    
    //[self loopPlayerLayer];
}

#pragma mark - Combination of AVPlayerViewController & AVPlayer
- (void)createAVPlayerViewControllerAndAVPlayer{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"emoji zone" ofType:@"mp4"];
    
    self.playerView = [[AVPlayer alloc]initWithURL:[NSURL fileURLWithPath:path]];
    self.playViewController = [[AVPlayerViewController alloc] init];
    self.playViewController.player = self.playerView;
    
    self.playViewController.videoGravity = AVLayerVideoGravityResizeAspect;
    self.playViewController.allowsPictureInPicturePlayback = true;    //画中画，iPad可用
    self.playViewController.showsPlaybackControls = true;
    [self addChildViewController:self.playViewController];
    self.playViewController.view.translatesAutoresizingMaskIntoConstraints = true;
    
    self.playViewController.view.frame = CGRectMake(0, CGRectGetMidY(self.view.frame), self.view.frame.size.width, 180);
    [self.view addSubview:_playViewController.view];
    [_playViewController.player play];
}

#pragma mark - Simple custom video controller
- (void)narrowPlayerStart{
    //AVPlayerLayer
    UIView *controllerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    controllerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:controllerView];
    
    [self.view.layer insertSublayer:self.playerLayer below:controllerView.layer];
    
    //MARK: - Video Controller
    self.videoControlButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.videoControlButton.frame = CGRectMake(CGRectGetMidX(self.view.frame) - 50, CGRectGetMidY(self.view.frame) - 15, 100, 30);
    self.videoControlButton.center = self.view.center;
    self.videoControlButton.backgroundColor = [UIColor clearColor];
    [self.videoControlButton setTitle:@"Pause" forState:UIControlStateNormal];
    [self.videoControlButton addTarget:self action:@selector(playerPause:) forControlEvents:UIControlEventTouchUpInside];
    [controllerView addSubview:self.videoControlButton];
}

- (void)playerPause:(UIButton *)sender {
    NSLog(@"videoControlButton pressed");
    
    if (!self.isPause) {
        self.isPause = YES;
        [_playerLayer.player pause];
        [self.videoControlButton setTitle:@"Play" forState:UIControlStateNormal];
    }else{
        self.isPause = NO;
        [_playerLayer.player play];
        [self.videoControlButton setTitle:@"Pause" forState:UIControlStateNormal];
    }
}

#pragma mark - loopPlayerLabyer
- (void)loopPlayerLayer{
    //Normal AVPlayerViewController
    NSString *path = [[NSBundle mainBundle]pathForResource:@"emoji zone" ofType:@"mp4"];
    NSLog(@"path = %@", path);
    self.playerView = [[AVPlayer alloc]initWithURL:[NSURL fileURLWithPath:path]];
    self.playViewController = [[AVPlayerViewController alloc] init];
    self.playViewController.player = self.playerView;
    
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
        
        //        _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        //        _playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        _playerLayer.videoGravity = AVLayerVideoGravityResize;
        
        [_playerLayer.player play];
        
    }
    return _playerLayer;
}

-(void)replayMovie:(NSNotification *)notification{
    AVPlayerItem *repeatPlayer = [notification object];
    [repeatPlayer seekToTime:kCMTimeZero];
}

#pragma mark - AVPlayerViewController full screen
- (IBAction)playVideoAction:(id)sender {
    NSLog(@"play clicked");
    [self presentViewController:self.playViewController animated:YES completion:^{
        [self.playViewController.player play];
    }];
}

#pragma mark - AVPlayerLayer & AVPlayer
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

//MPMoviePlayerController is deprecated in iOS 7
//- (IBAction)startMediaPlayerAction:(id)sender {
//    self.mediaPlayer = [[MPMoviePlayerController alloc] initWithContentURL:sourceMovieURL];
//    self.mediaPlayer.view.frame = CGRectMake(0, 0, 1024, 768);
//    self.mediaPlayer.controlStyle = MPMovieControlStyleNone;
//
//    // Play the movie!
//    [self.view addSubview:self.mediaPlayer.view];
//}




@end
